//Fred B. Wrixon, Geheimsprachen, Könemann-Verlag, ISBN 978-3-8331-2562-1, S. 450

import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/utils/constants.dart';

final Map<String, List<String>> PASLEY = {
  ' ': [],
  '1': ['7'],
  '2': ['1'],
  '3': ['2'],
  '4': ['3'],
  '5': ['4'],
  '6': ['5'],
  '7': ['6'],
  '8': ['1', '7'],
  '9': ['2', '7'],
  '0': ['3', '5'],
  'A': ['7'],
  'B': ['1'],
  'C': ['2'],
  'D': ['3'],
  'E': ['4'],
  'F': ['5'],
  'G': ['6'],
  'H': ['1', '7'],
  'I': ['2', '7'],
  'J': ['3', '5'],
  'K': ['3', '7'],
  'L': ['4', '7'],
  'M': ['5', '7'],
  'N': ['6', '5'],
  'O': ['1', '2'],
  'P': ['1', '3'],
  'Q': ['1', '4'],
  'R': ['1', '5'],
  'S': ['1', '6'],
  'T': ['2', '3'],
  'U': ['2', '4'],
  'V': ['3', '6'],
  'W': ['4', '5'],
  'X': ['4', '6'],
  'Y': ['2', '5'],
  'Z': ['5', '6'],
};

final Map<String, List<String>> PASLEY_MODIFIER = {
  'LETTERFOLLOWS': ['3', '4'],
  'NUMBERFOLLOWS': ['2', '6'],
};

final Map<String, String> DigitToLetter = {
  '1': 'A',
  '2': 'B',
  '3': 'C',
  '4': 'D',
  '5': 'E',
  '6': 'F',
  '7': 'G',
  '8': 'H',
  '9': 'I',
  '0': 'J',
  ' ': ' '
};

final Map<String, String> LetterToDigit = {
  'A': '1',
  'B': '2',
  'C': '3',
  'D': '4',
  'E': '5',
  'F': '6',
  'G': '7',
  'H': '8',
  'I': '9',
  'J': '0',
  ' ': ' '
};

final List<String> LETTER = [
  ' ',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];
final List<String> DIGIT = [
  ' ',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
];

Segments encodePasley(String? input) {
  if (input == null || input.isEmpty) return Segments(displays: []);

  bool letter = true;

  List<String> inputs = input.toUpperCase().split('');
  List<List<String>> result = [];

  for (int i = 0; i < inputs.length; i++) {
    if (letter) if (LETTER.contains(inputs[i])) {
      result.add(PASLEY[inputs[i].toUpperCase()]!);
    } else {
      result.add(PASLEY_MODIFIER['NUMBERFOLLOWS']!);
      result.add(PASLEY[inputs[i]]!);
      letter = false;
    }
    else if (LETTER.contains(inputs[i])) {
      result.add(PASLEY_MODIFIER['LETTERFOLLOWS']!);
      result.add(PASLEY[inputs[i].toUpperCase()]!);
      letter = true;
    } else {
      result.add(PASLEY[inputs[i]]!);
    }
  }
  return Segments(displays: result);
}

SegmentsText decodeVisualPasley(List<String> inputs) {
  if (inputs.isEmpty) return SegmentsText(displays: [], text: '');

  var displays = <List<String>>[];
  var segment = <String>[];
  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
  });

  bool letter = true;

  Map<String, String> CODEBOOK = {};
  PASLEY.forEach((key, value) {
    CODEBOOK[value.join('')] = key;
  });
  CODEBOOK['26'] = 'NUMBERFOLLOWS';
  CODEBOOK['34'] = 'LETTERFOLLOWS';
  CODEBOOK[''] = ' ';

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    if (CODEBOOK[input] == null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = CODEBOOK[input]!;
      if (charH == 'LETTERFOLLOWS')
        letter = true;
      else if (charH == 'NUMBERFOLLOWS')
        letter = false;
      else
        char = char + (_decode(charH, letter) ?? '');
    }

    return char;
  }).toList();
  return SegmentsText(displays: displays, text: text.join(''));
}

List<String> _stringToSegment(String input) {
  List<String> result = [];
  for (int i = 0; i < input.length; i++) result.add(input[i]);

  return result;
}

String? _decode(String code, bool letter) {
  if (letter)
    return code;
  else
    return LetterToDigit[code];
}
