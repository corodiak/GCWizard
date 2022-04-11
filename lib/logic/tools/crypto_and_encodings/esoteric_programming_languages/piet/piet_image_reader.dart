﻿import 'dart:core';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class PietImageReader {
  List<List<int>> readImage(Uint8List image) {
    var _image = img.decodeImage(image);
    return _readImage(_image);
  }

  List<List<int>> _readImage(img.Image image) {
    var step = _estimateCodelSize(image);
    var pixels = <List<int>>[];

    int outY = 0;
    for (var y = 0; y < image.height; y += step, outY++) {
      pixels.add(<int>[]);
      for (var x = 0; x < image.width; x += step) {
        var pix = image.getPixel(x, y);
        pixels[outY].add(_toRgb(pix));
      }
    }
    return pixels;
  }

  int _toRgb(int rgb24) {
    return (rgb24 & 0x00FFFFFF); //AABBGGRR -> BGR (not RGB)
  }

  int _estimateCodelSize(img.Image image) {
    // test the first row
    int count = 1;
    int minCount = 9999999999999;

    for (var rowIndex = 0; rowIndex < image.height; rowIndex++) {
      var prevColor = _toRgb(image.getPixel(0, rowIndex));
      for (var i = 1; i < image.width; i++) {
        var currentColor = _toRgb(image.getPixel(i, rowIndex));
        if (currentColor == prevColor)
          count++;
        else {
          if (count < minCount) minCount = count;

          prevColor = currentColor;
          count = 1;
        }
      }

      if (count < minCount) minCount = count;
    }
    return minCount;
  }
}

