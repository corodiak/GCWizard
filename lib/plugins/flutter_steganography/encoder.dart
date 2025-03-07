import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as crypto;
import 'package:flutter/foundation.dart';
import 'package:gc_wizard/plugins/flutter_steganography/requests/encode_request.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:image/image.dart';

import 'pad_key.dart';

int _encodeOnePixel(int pixel, int msg) {
  if (msg != 1 && msg != 0) {
    throw FlutterError('msg_encode_bit_more_than_1_bit');
  }
  int lastBitMask = 254;
  int encoded = (pixel & lastBitMask) | msg;
  return encoded;
}

Uint8List encodeMessageIntoImage(EncodeRequest req) {
  Image origin = decodeImage(req.imageData);
  Uint8List img = origin.getBytes();
  String msg = req.message;
  String token = req.key;
  if (req.canEncrypt()) {
    crypto.Key key = crypto.Key.fromUtf8(padKey(token));
    crypto.IV iv = crypto.IV.fromLength(16);
    crypto.Encrypter encrypter = crypto.Encrypter(crypto.AES(key));
    crypto.Encrypted encrypted = encrypter.encrypt(msg, iv: iv);
    msg = encrypted.base64;
  }

  if (img.length < msg.length * 8) {
    throw FlutterError('image_capacity_not_enough');
  }

  // 8 - 1 byte = 8 bit
  Uint8List byteData = Uint8List.fromList(msg.codeUnits);
  Uint8List expanded = Uint8List(msg.length * 8);
  for (int i = 0; i < msg.length; ++i) {
    int msgByte = byteData[i];
    for (int j = 0; j < 8; ++j) {
      int lastBit = msgByte & 1;
      expanded[i * 8 + (8 - j - 1)] = lastBit;
      msgByte = msgByte >> 1;
    }
  }

  Uint8List encodedImg = img;
  for (int i = 0; i < img.length; ++i) {
    if (i < expanded.length) {
      encodedImg[i] = _encodeOnePixel(img[i], expanded[i]);
    } else {
      int lastBitMask = 254;
      encodedImg[i] = img[i] & lastBitMask;
    }
  }
  Image editableImage = Image.fromBytes(origin.width, origin.height, encodedImg.toList());
  Uint8List data = Uint8List.fromList(encodeTrimmedPng(editableImage));
  return data;
}

Future<Uint8List> encodeMessageIntoImageAsync(EncodeRequest req) async {
  final Uint8List res = await compute(encodeMessageIntoImage, req);
  return res;
}
