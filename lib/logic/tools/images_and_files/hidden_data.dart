import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';


const HIDDEN_FILE_IDENTIFIER = '<<!!!HIDDEN_FILE!!!>>';

Future<List<PlatformFile>> hiddenData(PlatformFile data, {bool calledFromSearchMagicBytes = false, int fileIndex = 0}) async {
  if (data == null) return [];

  var resultList = <PlatformFile>[];
  var bytes = data.bytes;

  while (bytes != null && bytes.length > 0) {
    int imageLength;
    FileType detectedFileType = getFileType(bytes);

    switch (detectedFileType) {
      case FileType.JPEG:
        imageLength = jpgImageSize(bytes);
        break;
      case FileType.PNG:
        imageLength = pngImageSize(bytes);
        break;
      case FileType.GIF:
        imageLength = gifImageSize(bytes);
        break;
      case FileType.BMP:
        imageLength = bmpImageSize(bytes);
        break;
      case FileType.ZIP:
        imageLength = zipFileSize(bytes);
        break;
      case FileType.RAR:
        imageLength = rarFileSize(bytes);
        break;
      case FileType.MP3:
        imageLength = mp3FileSize(bytes);
        break;
      case FileType.TAR:
        imageLength = tarFileSize(bytes);
        break;
      default:
        imageLength = bytes.length;
        break;
    }

    var resultBytes;
    if ((imageLength != null) && (imageLength > 0) && (bytes.length > imageLength)) {
      resultBytes = bytes.sublist(0, imageLength);
      // remove result from source data
      bytes = bytes.sublist(imageLength);
    } else {
      resultBytes = bytes;
      bytes = null;
    }

    List<PlatformFile> children;
    if (fileClass(detectedFileType) == FileClass.ARCHIVE) children = await extractArchive(PlatformFile(bytes: resultBytes));

    resultBytes = trimNullBytes(resultBytes);
    if (resultBytes.length > 0) {
      var fileCounter = fileIndex + resultList.length;
      var result = PlatformFile(name: HIDDEN_FILE_IDENTIFIER + '_$fileCounter', bytes: resultBytes, children: children);

      resultList.add(result);
    }

    if (calledFromSearchMagicBytes) break;
  }

  if (!calledFromSearchMagicBytes) {
    var fileTypeList = <FileType>[FileType.JPEG, FileType.PNG, FileType.GIF, FileType.ZIP, FileType.RAR, FileType.TAR];

    resultList.asMap().forEach((index, result) {
      if (index == 0 && result.fileClass != FileClass.ARCHIVE) return;

      if ((result.children == null) || (result.children.length == 0))
        _searchMagicBytes(result, fileTypeList);
      else
        result.children.forEach((element) {
          _searchMagicBytes(element, fileTypeList);
        });
    });
  }
  return resultList;
}

_searchMagicBytes(PlatformFile data, List<FileType> fileTypeList) {
  fileTypeList.forEach((fileType) {
    var magicBytesList = magicBytes(fileType);
    magicBytesList.forEach((magicBytes) async {
      var bytes = data.bytes;
      if (bytes == null) return;

      for (int i = 1; i < bytes.length; i++) {
        if (bytes[i] == magicBytes[0] && ((i + magicBytes.length) <= bytes.length)) {
          var validMagicBytes = true;
          for (int offset = 1; offset < magicBytes.length; offset++) {
            if (bytes[i + offset] != magicBytes[offset]) {
              validMagicBytes = false;
              break;
            }
          }

          if (validMagicBytes) {
            var bytesOffset = magicBytesOffset(fileType) ?? 0;
            if (i - bytesOffset >= 0) {
              var children = await hiddenData(PlatformFile(bytes: bytes.sublist(i - bytesOffset)),
                  calledFromSearchMagicBytes: true, fileIndex: data.children.length + 1);
              if ((children != null) && (children.length > 0)) {
                if (data.children != null) data.children.addAll(children);
              }
            }
          }
        }
      }
    });
  });
}

Uint8List mergeFiles(List<dynamic> data) {
  if (data == null) return null;
  var result = <int>[];

  data.forEach((element) {
    if (element is Uint8List)
      result.addAll(trimNullBytes(element));
    else if (element is String) result.addAll(Uint8List.fromList(element.toString().codeUnits));
  });

  return trimNullBytes(Uint8List.fromList(result));
}

int jpgImageSize(Uint8List data) {
  var sum = 0;
  if (data == null) return null;
  if (getFileType(data) != FileType.JPEG) return null;

  for (int i = 0; i < data.length - 2; i++) {
    // Segment ?
    if ((data[i] == 0xFF) & (data[i + 1] == 0xD8)) {
      var offset = 0;
      sum += 2;
      do {
        offset = _jpgSegmentLength(data, sum);
        sum += offset;
      } while (offset > 0);

      sum += _jpgSosSegmentLength(data, sum);

      return sum;
    }
  }

  return sum;
}

int _jpgSegmentLength(Uint8List data, int offset) {
  // Data Segment and not SOS Segment
  if ((offset + 3 < data.length) & (data[offset] == 0xFF) & (data[offset + 1] != 0xDA))
    return 256 * data[offset + 2] + data[offset + 3] + 2;
  return 0;
}

int _jpgSosSegmentLength(Uint8List data, int offset) {
  //  SOS Segment ?
  if ((offset + 1 < data.length) & (data[offset] == 0xFF) & (data[offset + 1] == 0xDA))
    for (int i = offset + 2; i < data.length - 1; i++)
      // EOI-Segment ?
      if (data[i] == 0xFF && data[i + 1] == 0xD9) return i - offset + 2;

  return 0;
}

int pngImageSize(Uint8List data) {
  var startIndex = 0;
  var endIndex = 0;
  if (data == null) return null;
  if (getFileType(data) != FileType.PNG) return null;

  for (int i = 0; i < data.length - 3; i++) {
    // IDAT ??
    if ((data[i] == 0x49) & (data[i + 1] == 0x44) & (data[i + 2] == 0x41) & (data[i + 3] == 0x54)) {
      startIndex = i + 4;
      break;
    }
  }

  if (startIndex > 0) {
    for (int i = startIndex; i < data.length - 7; i++) {
      // IEND ??
      if ((data[i] == 0x49) &
      (data[i + 1] == 0x45) &
      (data[i + 2] == 0x4E) &
      (data[i + 3] == 0x44) &
      (data[i + 4] == 0xAE) &
      (data[i + 5] == 0x42) &
      (data[i + 6] == 0x60) &
      (data[i + 7] == 0x82)) {
        endIndex = i + 4 + 4;
        break;
      }
    }
  }

  return endIndex;
}

int gifImageSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.GIF) return null;

  var offset = "GIF89a".length; //GIF Signature
  offset += 7; //Screen Descriptor

  //Global Color Map
  offset = _gifColorMap(data, offset, -3);

  do {
    if (offset + 1 >= data.length) return data.length;

    // Application Extension, Comment Extension
    if ((data[offset] == 0x21) & ((data[offset + 1] == 0xFF) | (data[offset] == 0xFE)))
      offset = _gifExtensionBlock(data, offset);
    else {
      //Graphics Control Extension (option)
      offset = _gifExtensionBlock(data, offset);

      if (offset + 1 >= data.length) return data.length;

      if ((data[offset] == 0x21) & (data[offset + 1] == 0xFF))
        // Plain Text Extension
        offset = _gifExtensionBlock(data, offset);
      else {
        //Image Descriptor
        offset += 10;

        //Local Color Map
        offset = _gifColorMap(data, offset, -1);

        //Image Data
        offset += 1;
        while ((offset < data.length) && (data[offset] != 0)) {
          offset += 1;
          offset += data[offset - 1];
        }

        offset += 1; //Terminator 0x00
      }
    }
  } while ((offset >= data.length) || (data[offset] != 0x3B));
  offset += 1; //0x3B

  return min(offset, data.length);
}

int _gifExtensionBlock(Uint8List data, int offset) {
  if (offset >= data.length) return data.length;
  if (data[offset] == 0x21) {
    offset += 3;
    offset += data[offset - 1];
    offset += 1; //Terminator 0x00
  }
  return offset;
}

int _gifColorMap(Uint8List data, int offset, int countOffset) {
  if (offset >= data.length) return data.length;
  if ((data[offset + countOffset] & 0x80) != 0) {
    var bitsPerPixel = (data[offset + countOffset] & 0x7) + 1;
    offset += (pow(2, bitsPerPixel) * 3).toInt();
  }

  return offset;
}

int zipFileSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != '.zip') return null;

  var offset = 0;
  if (offset + 30 > data.length) return null;

  // ZIP Signature file header
  while (
  (data[offset] == 0x50) & (data[offset + 1] == 0x4B) & (data[offset + 2] == 0x03) & (data[offset + 3] == 0x04)) {
    offset += 30;

    var fileNameLength = data.buffer.asByteData(offset - 4, 2).getInt16(0, Endian.little);
    var extraFieldLength = data.buffer.asByteData(offset - 2, 2).getInt16(0, Endian.little);
    var compressedSize = data.buffer.asByteData(offset - 12, 4).getInt32(0, Endian.little);

    offset += fileNameLength + extraFieldLength + compressedSize;
  }

  bool fileHeaderFound = false;
  do {
    if (offset + 4 >= data.length) return offset;

    fileHeaderFound = false;
    // central directory file header
    if ((data[offset] == 0x50) & (data[offset + 1] == 0x4B) & (data[offset + 2] == 0x01) & (data[offset + 3] == 0x02)) {
      if (offset + 46 > data.length) return null;

      offset += 46;
      var fileNameLength = data.buffer.asByteData(offset - 18, 2).getInt16(0, Endian.little);
      var extraFieldLength = data.buffer.asByteData(offset - 16, 2).getInt16(0, Endian.little);
      var commentLength = data.buffer.asByteData(offset - 14, 2).getInt16(0, Endian.little);

      offset += fileNameLength + extraFieldLength + commentLength;
      fileHeaderFound = true;
    }

    // header end central directory
    else if ((data[offset] == 0x50) &
    (data[offset + 1] == 0x4B) &
    (data[offset + 2] == 0x05) &
    (data[offset + 3] == 0x06)) {
      if (offset + 22 > data.length) return null;

      offset += 22;
      var commentLength = data.buffer.asByteData(offset - 2, 2).getInt16(0, Endian.little);
      offset += commentLength;
    }
  } while (fileHeaderFound);

  return offset;
}

int bmpImageSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.BMP) return null;

  var offset = 0;

  return data.buffer.asByteData(offset + 2).getInt32(0, Endian.little);
}

int rarFileSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.RAR) return null;

  var offset = 0;
  bool archiveBlockFound = false;
  var fileNames = <String>[];

  // header RAR 5.0
  if ((data[offset] == 0x52) &
  (data[offset + 1] == 0x61) &
  (data[offset + 2] == 0x72) &
  (data[offset + 3] == 0x21) &
  (data[offset + 4] == 0x1A) &
  (data[offset + 5] == 0x07) &
  (data[offset + 6] == 0x01) &
  (data[offset + 7] == 0x00)) {
    offset += 8;
  } else
    return null;

  do {
    archiveBlockFound = false;

    offset += 4; // HeaderCRC32

    var dataSizeAdd = 0;
    var headerSize = _rarVint(data, offset);
    offset += headerSize.item2;
    var headerTypePos = offset;

    var headerType = _rarVint(data, offset);
    offset += headerType.item2;

    var headerFlags = _rarVint(data, offset);
    offset += headerFlags.item2;

    switch (headerType.item1) {
      case 1: // Main archive header
        archiveBlockFound = true;
        break;
      case 2: // file header
      case 3: // service header
        archiveBlockFound = true;

        if ((headerFlags.item1 & 0x01) != 0) offset += _rarVint(data, offset).item2; // Extra area size

        if ((headerFlags.item1 & 0x02) != 0) {
          var dataSize = _rarVint(data, offset); // Data size
          offset += dataSize.item2;
          dataSizeAdd = dataSize.item1;
        }

        offset += _rarVint(data, offset).item2; // File flags
        offset += _rarVint(data, offset).item2; // unpacked size
        offset += _rarVint(data, offset).item2; // attributes
        if ((headerFlags.item1 & 0x02) != 0) offset += 4; // mtime
        if ((headerFlags.item1 & 0x04) != 0) offset += 4; // data CRC32
        offset += _rarVint(data, offset).item2; // Compression information
        offset += _rarVint(data, offset).item2; // Host OS

        var nameLength = _rarVint(data, offset); // Name length
        offset += nameLength.item2;

        var nameArray = data.sublist(offset, offset + nameLength.item1);
        var name = utf8.decode(nameArray);
        if ((name != null) & (name.length > 0)) fileNames.add(name);
        offset += nameLength.item1; //Name

        break;
      case 4: // Archive encryption header
        archiveBlockFound = true;

        offset += _rarVint(data, offset).item2; // Encryption version
        offset += _rarVint(data, offset).item2; // Encryption flags
        offset += 1; // KDF count
        offset += 16; // Salt
        offset += 12; // Check value

        break;
      case 5: // End of archive header
        offset += _rarVint(data, offset).item2; // End of archive flags

        break;
    }
    offset = headerTypePos + headerSize.item1 + dataSizeAdd;
  } while (archiveBlockFound);

  return offset;
}

Tuple2<int, int> _rarVint(Uint8List data, int offset) {
  var index = 0;
  var value = 0;
  if (offset >= data.length) return Tuple2<int, int>(0, 0);

  do {
    value |= ((data[offset + index] & 0x7F) << index * 7);
    index++;
  } while (((offset + index) < data.length) & ((data[offset + index - 1] & 0x80) != 0));

  return new Tuple2<int, int>(value, index);
}

int mp3FileSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.MP3) return null;

  int offset = 0;
  bool frameFound = false;
  var bitRates = <int>[
    0,
    32000,
    40000,
    48000,
    56000,
    64000,
    80000,
    96000,
    112000,
    128000,
    160000,
    192000,
    224000,
    256000,
    320000
  ];
  var sampleRates = <int>[44100, 48000, 32000];

  do {
    frameFound = false;

    if ((offset + 4 < data.length) && (data[offset] == 0xFF) & ((data[offset + 1] & 0xE0) == 0xE0)) {
      // Frame Header

      var bitrateIndex = (data[offset + 2] & 0xF0) >> 4;
      if ((bitrateIndex <= 0) | (bitrateIndex > bitRates.length)) return null;

      var sampleRateIndex = (data[offset + 2] & 0xC) >> 2;
      if ((sampleRateIndex < 0) | (sampleRateIndex > sampleRates.length)) return null;

      var padding = (data[offset + 2] & 0x02) != 0 ? 1 : 0;

      var frameLen = ((144 * bitRates[bitrateIndex] / sampleRates[sampleRateIndex]) + padding).toInt();
      frameFound = true;
      offset += frameLen;
    } else if ((offset + 3 < data.length) &&
        (data[offset] == 0x54) & (data[offset + 1] == 0x41) & (data[offset + 2] == 0x47)) {
      //ID3v1/ ID3v1.1 TAG

      offset += 3; // TAG
      offset += 30; // title
      offset += 30; // artist
      offset += 30; // album
      offset += 4; // year
      offset += 30; // comment
      offset += 1; // genre

    } else if ((offset + 3 < data.length) &&
        (((data[offset] == 0x49) & (data[offset + 1] == 0x44) & (data[offset + 2] == 0x33)) | //  ID3v2
        ((data[offset] == 0x33) & (data[offset + 1] == 0x44) & (data[offset + 2] == 0x49)))) {
      //  ID3v2 Footer

      var footer = (data[offset] == 0x33) & (data[offset + 1] == 0x44) & (data[offset + 2] == 0x49); //  ID3v2 Footer
      offset += 10;
      var extendedHeader = ((data[offset - 5] & 0x40) != 0);
      offset += _mp3Vint(data, offset - 4); //bigEndian

      // extendedHeader
      if (extendedHeader) {
        offset += _mp3Vint(data, offset); //bigEndian
        offset += 4;
      }

      frameFound = !footer;
    }
  } while (frameFound);

  return offset;
}

int _mp3Vint(Uint8List data, int offset) {
  var value = 0;
  if (offset + 3 >= data.length) return 0;

  // big EndianFormat
  for (int i = 0; i < 4; i++) value |= ((data[offset + 3 - i] & 0x7F) << i * 7);

  return value;
}

int tarFileSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != FileType.TAR) return null;

  const int headerSize = 512;
  const int blockSize = 512;
  var magicByteOffset = magicBytesOffset(FileType.TAR) ?? 0;
  var offset = 0;
  var fileNames = <String>[];

  while (offset + headerSize < data.length) {
    // ustar
    if ((data[offset + magicByteOffset] == 0x75) &
    (data[offset + magicByteOffset + 1] == 0x73) &
    (data[offset + magicByteOffset + 2] == 0x74) &
    (data[offset + magicByteOffset + 3] == 0x61) &
    (data[offset + magicByteOffset + 4] == 0x72)) {
      //0       100 File name
      //100     8   File mode(octal)
      //108     8   Owner's numeric user ID (octal)
      //116     8   Group's numeric user ID (octal)
      //124     12  File size in bytes(octal)
      //136     12  Last modification time in numeric Unix time format(octal)
      //148     8   Checksum for header record
      //156     1   Link indicator(file type)
      //157     100     Name of linked file

      var fileSizeString =
      convertBase(utf8.decode(trimNullBytes(Uint8List.fromList(data.skip(offset + 124).take(12).toList()))), 8, 10);
      if ((fileSizeString == null) || (fileSizeString == '')) return null;
      var fileSize = int.parse(fileSizeString);
      var usedSize = (fileSize / blockSize.toDouble()).ceil() * blockSize + headerSize;
      if ((fileSize < 0) || ((offset + usedSize) > data.length)) return null;
      offset += usedSize.toInt();
      fileNames.add(utf8.decode(trimNullBytes(Uint8List.fromList(data.skip(offset + 0).take(100).toList()))));
    } else
      break;
  }

  if ((offset + 2 * blockSize) <= data.length)
    offset = data.skip(offset).take(2 * blockSize).any((element) => element == 0x0) ? offset + (2 * blockSize) : null;
  else
    offset = null;

  return offset;
}



