//source: https://github.com/sebbeobe/piet_message_generator

import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_blocker_builder.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';


Future<Uint8List> generatePiet(String input) async {
  List<List<int>> result;
  var i = 0;
  input
    .split('')
    .forEach((char) {
      var block = _drawBlock(char.runes.first, i);
        i++;
        if (result == null)
          result = block;
        else
          for (var x=0; x < result.length; x++)
            result[x].addAll(block[x]);
    });
  var block = _drawEnd(i);
  if (result == null)
    result = block;
  else
    for (var x=0; x < result.length; x++)
      result[x].addAll(block[x]);

  var lines = <String>[];
  var colorMap = Map<String, Color>();
  var colorMapSwitched = Map<Color, String>();
  var mapList = switchMapKeyValue(alphabet_AZ);

  for (var i = 0; i < knownColors.length; i++) {
    colorMap.addAll({mapList[i]: Color(knownColors[i])});
  };
  colorMapSwitched = switchMapKeyValue(colorMap);

  result.forEach((line) {
    var row ='';
    line.forEach((color) {
      row += colorMapSwitched[color];
    });
    lines.add(row);
  });

  return input2Image(lines, colors: colorMap, bounds:0, pointSize: 1);
}

class _colorStack {
  var _color_table = {1 ,0}.toList();

  int RGB() {
    if (_color_table[1] == 0) {
      //Red
      if (_color_table[0] == 0)
        //Light
        return knownColors[0];
      else if (_color_table[0] == 1)
        //Normal
        return knownColors[1];
      else if (_color_table[0] == 2)
        //Dark
        return knownColors[2];
    } else if (_color_table[1] == 1) {
      //Yellow
      if (_color_table[0] == 0)
        //Light
        return knownColors[3];
      else if (_color_table[0] == 1)
        //Normal
        return knownColors[4];
      else if (_color_table[0] == 2)
        //Dark
        return knownColors[5];
    } else if (_color_table[1] == 2) {
      //Green
      if (_color_table[0] == 0)
        //Light
        return knownColors[6];
      else if (_color_table[0] == 1)
        //Normal
        return knownColors[7];
      else if (_color_table[0] == 2)
        //Dark
        return knownColors[8];
    } else if (_color_table[1] == 3) {
      //Cyan
      if (_color_table[0] == 0)
        //Light
        return knownColors[9];
      else if (_color_table[0] == 1)
        //Normal
        return knownColors[10];
      else if (_color_table[0] == 2)
        //Dark
        return knownColors[11];
    } else if (_color_table[1] == 4) {
      //Blue
      if (_color_table[0] == 0)
        //Light
        return knownColors[12];
      else if (_color_table[0] == 1)
        //Normal
        return knownColors[13];
      else if (_color_table[0] == 2)
        //Dark
        return knownColors[14];
    } else if (_color_table[1] == 5) {
      //Magenta
      if (_color_table[0] == 0)
        //Light
        return knownColors[15];
      else if (_color_table[0] == 1)
        //Normal
        return knownColors[16];
      else if (_color_table[0] == 2)
        //Dark
        return knownColors[17];
    }
  }

  int push_color() {
    _color_table[0] = (_color_table[0] + 1) % 3;
    return RGB();
  }

  int write_color() {
    _color_table[0] = (_color_table[0] + 2) % 3;
    _color_table[1] = (_color_table[1] + 5) % 6;
    return RGB();
  }
}

var _currentColor = _colorStack();

final _blockHeight = 12;

List<List<int>>  _drawBlock(int size, int num) {
  final blockWidth = 12;
  var block = List.filled(_blockHeight * blockWidth, knownColors[19]); // black
  if (num != 0) {
    var old_push_color = _currentColor.push_color();
    _currentColor.write_color();
    block[0] = old_push_color;
    size = size + 1;
  } else
    block[0] = _currentColor.RGB();

  block.fillRange(1, _calcIndex((size / blockWidth).ceil(), blockWidth, blockWidth), _currentColor.RGB());
  var pixLft = size; //144 - size;
  var div = (pixLft / 12).toInt();
  var rem = pixLft % 12;
  if (rem != 0)
    block.fillRange(_calcIndex(div , 0, blockWidth), _calcIndex(div, rem, blockWidth), knownColors[19]);

  var lines = <List<int>>[];
  for (var i = 0; i < _blockHeight; i++)
    lines.add(block.sublist(i * blockWidth, (i + 1) * blockWidth));
  return lines;
}


List<List<int>> _drawEnd(int num) {
  final blockWidth = 5;
  var block = List.filled(_blockHeight * blockWidth, knownColors[18]); // white
  var oldPushColor = _currentColor.push_color();

  block[_calcIndex(0, 0, blockWidth)] = oldPushColor;
  block[_calcIndex(0, 1, 5)] = _currentColor.write_color();
  block[_calcIndex(0, 3, blockWidth)] = knownColors[19];
  block[_calcIndex(1, 1, blockWidth)] = knownColors[19];
  block[_calcIndex(1, 3, blockWidth)] = knownColors[19];
  block[_calcIndex(2, 0, blockWidth)] = knownColors[19];
  block.fillRange(_calcIndex(2, 1, blockWidth), _calcIndex(2, 4, blockWidth), _currentColor.write_color());
  block[_calcIndex(2, 4, blockWidth)] = knownColors[19];
  block.fillRange(_calcIndex(3, 1, blockWidth), _calcIndex(3, 4, blockWidth), knownColors[19]);

  var lines = <List<int>>[];
  for (var i = 0; i < _blockHeight; i++)
    lines.add(block.sublist(i * blockWidth, (i + 1) * blockWidth));

  return lines;
}

int _calcIndex(int row, int column, int width) {
  return row * width + column;
}