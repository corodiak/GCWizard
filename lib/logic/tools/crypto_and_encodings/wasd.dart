// https://www.geocaching.com/geocache/GC8PJEQ
//
// ASSDWW.DSAWSSDW.WWDSSA.WWA.WDSASDW   => 08078
//
// SDWSS.AWDSSA.SAWDWAS.ASSDWA.DWWASS   => 49860
//
// ss dsasd dsadsa sdwawd asdsa ssdwwa ww sswaw dwawd asdsa sdwss wwa wasdsaw wwsaw ww awdwa awdwa ss sdsww asdsa dwadwass ss sawwds
// wdddsaasasdsdwwdss wdwaaaaaaaaaaaaaaaasssa

import 'dart:math';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

class Offset{
  final int xOffset;
  final int yOffset;
  final int leftBorder;
  Offset(this.xOffset, this.yOffset, this.leftBorder);
}


enum WASD_TYPE  {WASD, IJMK, ESDF, ULDR, OLUR, VLZR, WQSE, CUSTOM}
enum _WASD_DIRECTION {UP, DOWN, LEFT, RIGHT, START}
enum _CURSOR_POSITION {LEFT, RIGHT}
final _SEGMENT_LENGTH = 5;

Map<WASD_TYPE, String> KEYBOARD_CONTROLS = {
  WASD_TYPE.WASD: 'wasd_keyboard_wasd',
  WASD_TYPE.ESDF: 'wasd_keyboard_esdf',
  WASD_TYPE.WQSE: 'wasd_keyboard_wqse',
  WASD_TYPE.IJMK: 'wasd_keyboard_ijkm',
  WASD_TYPE.ULDR: 'wasd_keyboard_uldr' ,
  WASD_TYPE.OLUR: 'wasd_keyboard_olur' ,
  WASD_TYPE.VLZR: 'wasd_keyboard_vlzr',
  WASD_TYPE.CUSTOM: 'wasd_keyboard_custom',
};

final Map<String, List<String>> WASD_ENCODE = {
  '0' : ['ASSDWW', 'SSDWWA', 'SDWWAS', 'DWWASS', 'WWASSD', 'WASSDW', 'WWDSSA', 'WDSSAW', 'DSSAWW', 'SSAWWD', 'SAWWDS', 'AWWDSS', 'DSSAWWD'],
  '1' : ['WW', 'SS'],
  '2' : ['DSASD', 'AWDWA'],
  '3' : ['DSADSA', 'DWADWA'],
  '4' : ['SDWSS', 'SDSWW', 'WWSAW', 'SSWAW'],
  '5' : ['DWAWD', 'ASDSA'],
  '6' : ['ASSDWA', 'SSDWA', 'DSAWWD', 'DSAWW', 'ASDSAW', 'SDWAWD', 'SDWAW', 'SDSAW'],
  '7' : ['WWA', 'DSS'],
  '8' : ['SDSAWDWA', 'DSASDWAW', 'WDSASDW', 'SAWDWAS', 'WASDSAW', 'SDWAWDS', 'ASDSAWDW', 'SASDWAWD', 'WDWASDSA', 'DWAWDSAS',
    'AWDWASDS', 'WAWDSASD', 'WWDSADSA', 'DWADWASS', 'WWASDASD', 'AWDAWDSS', 'SSDWADWA', 'DSASAWW', 'SSAWDAWD', 'ASDASDWW', 'DSAWSSDW'],
  '9' : ['ASDSWW', 'AWDSS', 'WASDS', 'AWDSSA', 'WASDSA', 'ASDSADWW', 'SSWAWS', 'WWASD', 'WAWDS', 'DWWASD', 'DWAWDS', 'SSADWAWD'],
  ' ' : [' '],
  '.' : ['.']
};

final Map<List<String>, String> WASD_DECODE = switchMapKeyValue(WASD_ENCODE);


String encodeWASD(String input, WASD_TYPE controls, List<String> controlSet){
  if (input == '' || input == null)
    return '';
  input = input.toUpperCase();
  Random rnd = new Random();
  List<String> result = [];
  input.split('').forEach((element) {
    if (WASD_ENCODE[element] == null)
      result.add('');
    else
      result.add(WASD_ENCODE[element][rnd.nextInt(WASD_ENCODE[element].length)].toString());
  });
  switch (controls) {
    case WASD_TYPE.IJMK : return result.join(' ').replaceAll('W', 'I').replaceAll('A', 'J').replaceAll('S', 'M').replaceAll('D', 'K');
      break;
    case WASD_TYPE.ESDF : return result.join(' ').replaceAll('W', 'E').replaceAll('D', 'F').replaceAll('S', 'D').replaceAll('A', 'S');
      break;
    case WASD_TYPE.ULDR : return result.join(' ').replaceAll('W', 'U').replaceAll('A', 'L').replaceAll('D', 'R').replaceAll('S', 'D');
      break;
    case WASD_TYPE.OLUR : return result.join(' ').replaceAll('W', 'O').replaceAll('A', 'L').replaceAll('D', 'U').replaceAll('S', 'D');
      break;
    case WASD_TYPE.VLZR : return result.join(' ').replaceAll('W', 'V').replaceAll('A', 'L').replaceAll('S', 'Z').replaceAll('D', 'R');
      break;
    case WASD_TYPE.WQSE : return result.join(' ').replaceAll('A', 'Q').replaceAll('D', 'E');
      break;
    case WASD_TYPE.CUSTOM : return result.join(' ').replaceAll('W', controlSet[0]).replaceAll('A', controlSet[1]).replaceAll('S', controlSet[2]).replaceAll('D', controlSet[3]);
      break;
    default: return result.join(' ');
  }
}

String _normalizeDecodingInput(String input, WASD_TYPE controls, List<String> controlSet){
  input = input.toUpperCase().replaceAll('.', ' ');
  switch (controls) {
    case WASD_TYPE.WASD : return input;
    break;
    case WASD_TYPE.IJMK : return input.replaceAll('I', 'W').replaceAll('J', 'A').replaceAll('M', 'S').replaceAll('K', 'D');
    break;
    case WASD_TYPE.ESDF : return input.replaceAll('E', 'W').replaceAll('S', 'A').replaceAll('D', 'S').replaceAll('F', 'D');
    break;
    case WASD_TYPE.ULDR : return input.replaceAll('U', 'W').replaceAll('L', 'A').replaceAll('D', 'S').replaceAll('R', 'D');
    break;
    case WASD_TYPE.OLUR : return input.replaceAll('O', 'W').replaceAll('L', 'A').replaceAll('U', 'S').replaceAll('R', 'D');
    break;
    case WASD_TYPE.VLZR : return input.replaceAll('V', 'W').replaceAll('L', 'A').replaceAll('Z', 'S').replaceAll('R', 'D');
    break;
    case WASD_TYPE.WQSE : return input.replaceAll('Q', 'A').replaceAll('E', 'D');
    break;
    case WASD_TYPE.CUSTOM : return input.replaceAll( controlSet[0].toUpperCase(), 'W').replaceAll(controlSet[1].toUpperCase(), 'A').replaceAll(controlSet[2].toUpperCase(), 'S').replaceAll(controlSet[3].toUpperCase(), 'D');
    break;
  }
}

String decodeWASD(String input, WASD_TYPE controls, List<String> controlSet){
  if (input == '' || input == null)
    return '';

  List<String> resultDecode = [];
  bool found = false;
  String result;

  _normalizeDecodingInput(input, controls, controlSet).split(' ').forEach((element) {
    if (element != '') {
      WASD_DECODE.forEach((key, value) {
        if (key.contains(element)) {
          found = true;
          result = value;
        }
      });
      if (found) {
        resultDecode.add(result);
        found = false;
      }
      else
        resultDecode.add(UNKNOWN_ELEMENT);
    }
  });
  return resultDecode.join('');
}

String decodeWASDGraphic(String input, WASD_TYPE controls, List<String> controlSet){
  if (input == '' || input == null)
    return '';

  int x = 0;
  int y = 0;
  int maxLetterX = 0;
  int maxLetterY = 0;
  int minLetterX = 0;
  int minLetterY = 0;
  int xOffset = 0;
  int yOffset = 0;
  int xSentence = 0;
  int ySentence = 0;
  int maxSentenceX = 0;
  int maxSentenceY = 0;
  int minSentenceX = 0;
  int minSentenceY = 0;

  Map<String, String> sentence = new Map();

  var direction = _WASD_DIRECTION.START;
  
  _normalizeDecodingInput(input, controls, controlSet).split(' ').forEach((word) {
print(word + ' ###################################################################');
    // draw picture per letter
    // transform/normalize picture
    // align picture in world

    y = 0;
    x = 0;
    maxLetterX = 0;
    maxLetterY = 0;
    minLetterX = 0;
    minLetterY = 0;
    direction = _WASD_DIRECTION.START;

    Map<String, String> letter = new Map();

    word.split('').forEach((element) {
      switch (element){
        case 'W':  // forward, up
          switch (direction) {
            case _WASD_DIRECTION.UP:
              y--;
              break;
            case _WASD_DIRECTION.DOWN:
              y++;
              break;
            case _WASD_DIRECTION.LEFT:
              x--;
              break;
            case _WASD_DIRECTION.RIGHT:
              x++;
              break;
          }
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            y--; letter[x.toString() + '|' + (y).toString()] = '1';
          }
          direction = _WASD_DIRECTION.UP;
          if (y < minLetterY) minLetterY = y;
          if (x < minLetterX) minLetterX = x;
          if (y > maxLetterY) maxLetterY = y;
          if (x > maxLetterX) maxLetterX = x;
          break;

        case 'S':  // back, down
          switch (direction) {
            case _WASD_DIRECTION.UP:
              y--;
              break;
            case _WASD_DIRECTION.DOWN:
              y++;
              break;
            case _WASD_DIRECTION.LEFT:
              x--;
              break;
            case _WASD_DIRECTION.RIGHT:
              x++;
              break;
          }
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            y++; letter[x.toString() + '|' + (y).toString()] = '1';
          }
          direction = _WASD_DIRECTION.DOWN;
          if (y < minLetterY) minLetterY = y;
          if (x < minLetterX) minLetterX = x;
          if (y > maxLetterY) maxLetterY = y;
          if (x > maxLetterX) maxLetterX = x;
          break;

        case 'A':  // left
          switch (direction) {
            case _WASD_DIRECTION.UP:
              y--;
              break;
            case _WASD_DIRECTION.DOWN:
              y++;
              break;
            case _WASD_DIRECTION.LEFT:
              x--;
              break;
            case _WASD_DIRECTION.RIGHT:
              x++;
              break;
          }
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x--; letter[x.toString() + '|' + (y).toString()] = '1';
          }
          direction = _WASD_DIRECTION.LEFT;
          if (y < minLetterY) minLetterY = y;
          if (x < minLetterX) minLetterX = x;
          if (y > maxLetterY) maxLetterY = y;
          if (x > maxLetterX) maxLetterX = x;
          break;

        case 'D':  // right
          switch (direction) {
            case _WASD_DIRECTION.UP:
              y--;
              break;
            case _WASD_DIRECTION.DOWN:
              y++;
              break;
            case _WASD_DIRECTION.LEFT:
              x--;
              break;
            case _WASD_DIRECTION.RIGHT:
              x++;
              break;
          }
          for (int i = 0; i < _SEGMENT_LENGTH; i++) {
            x++; letter[x.toString() + '|' + (y).toString()] = '1';
          }
          direction = _WASD_DIRECTION.RIGHT;
          if (y < minLetterY) minLetterY = y;
          if (x < minLetterX) minLetterX = x;
          if (y > maxLetterY) maxLetterY = y;
          if (x > maxLetterX) maxLetterX = x;
          break;
      }
      if (maxLetterY > maxSentenceY)
        maxSentenceY = maxLetterY;
      if (minLetterY < minSentenceY)
        minSentenceY = minLetterY;
    }); // for Each letter
print('[x|y] '+'['+minLetterX.toString()+'...'+maxLetterX.toString()+'|'+minLetterY.toString()+'...'+maxLetterY.toString()+'] => '+'['+(maxLetterX-minLetterX).toString()+'|'+(maxLetterY-minLetterY).toString()+']');
print('letter            '+letter.toString());

    // transform/normalize letter
    xOffset = 0;
    yOffset = 0;
    if (maxLetterY - minLetterY == 0) {
        yOffset = 0;
    } else if (maxLetterY - minLetterY == 5) {
      if (maxLetterY == 5)
        yOffset = -5;
    } else if (maxLetterY - minLetterY == 6) {
      if (maxLetterY == 6)
        yOffset = -6;
    } else if (maxLetterY - minLetterY == 10) {
      if (maxLetterY == 10)
        yOffset = -10;
    } else if (maxLetterY - minLetterY == 11) {
      if (maxLetterY == 11)
        yOffset = -11;
    } else if (maxLetterY - minLetterY == 12) {
      if (maxLetterY == 12)
        yOffset = -12;
    } else if (maxLetterY - minLetterY == 18) {
    if (maxLetterY == 5)
      yOffset = -5;
    } else
      yOffset = 13 + minLetterY;

    xOffset = 0 - minLetterX;
print('offset (x,y) '+xOffset.toString()+' '+yOffset.toString());

    Map<String, String> transformedLetter = new Map();
    letter.forEach((key, value) {
      transformedLetter[(int.parse(key.split('|')[0]) + xOffset).toString() + '|' + (int.parse(key.split('|')[1]) - yOffset).toString()] = value;
    });

print('transformedLetter '+transformedLetter.toString());
    // add letter to sentence
    transformedLetter.forEach((key, value) {
      sentence[(int.parse(key.split('|')[0]) + maxSentenceX).toString() + '|' + (int.parse(key.split('|')[1])).toString()] = value;
    });

    maxSentenceX = maxSentenceX + 7 + 2;
print('sentence          '+sentence.toString());
  }); // forEach word

  // build bitmap
  print('world [x|y] '+'['+maxSentenceX.toString()+'|'+minSentenceY.toString()+'...'+maxSentenceY.toString()+']');
  var binaryWorld = List.generate(maxSentenceX + 3, (y) => List(maxSentenceY - minSentenceY + 3), growable: false);
  sentence.forEach((key, value) {
    print('      [x|y] '+'['+key.split('|')[0]+'|'+key.split('|')[1]+']');
    x = int.parse(key.split('|')[0]);
    y = int.parse(key.split('|')[1]) - minSentenceY;
    binaryWorld[x][y] = value;
  });

  // build output
  String outputLine = '##';
  List<String> output = new List();
  output.add(outputLine.padRight(maxSentenceX + 1, '#'));
  for (y = 0; y < maxSentenceY - minSentenceY + 1; y++) {
    outputLine = '##';
    for (x = 0; x < maxSentenceX - minSentenceX + 1; x++) {
      if (binaryWorld[x][y] == null)
        outputLine = outputLine + '#';
      else
        outputLine = outputLine + binaryWorld[x][y];
    }
    output.add(outputLine);
  }


  return output.join('\n');
}
