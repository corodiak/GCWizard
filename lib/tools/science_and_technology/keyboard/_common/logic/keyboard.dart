// ignore_for_file: equal_keys_in_map

import 'package:collection/collection.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

// Add keyboard layouts
// 1. adapt enum KeyboardType
// 2. add Map xxxToNormal
// 3. adapt List<KeyboardData> allKeyboards
// 4. adapt buildConvertingMap

enum _ConvertDirection { toNormal, fromNormal }

enum KEYBOARD_TYPE {
  QWERTZ_T1,
  QWERTY_US_INT,
  DVORAK,
  DVORAK_I_DEU1,
  DVORAK_I_DEU2,
  DVORAK_I_DEU3,
  DVORAK_II_DEU,
  RISTOME,
  NEO,
  BONE,
  COLEMAK,
  FRA_AZERTY,
  FRA_BEPO
}

const Map<String, String> _QWERTZ_T1NumberToSymbol = {
  '1': '!',
  '2': '"',
  '3': '§',
  '4': '\$',
  '5': '%',
  '6': '&',
  '7': '/',
  '8': '(',
  '9': ')',
  '0': '=',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _AZERTYNumberToSymbol = {
  '1': '&',
  '2': 'é',
  '3': '"',
  '4': "'",
  '5': '(',
  '6': '-',
  '7': 'è',
  '8': '_',
  '9': 'ç',
  '0': 'à',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _BEPONumberToSymbol = {
  '1': '"',
  '2': '«',
  '3': '»',
  '4': "(",
  '5': ')',
  '6': '@',
  '7': '+',
  '8': '-',
  '9': '/',
  '0': '*',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _NeoNumberToSymbol = {
  '1': '°',
  '2': '§',
  '3': 'ℓ',
  '4': '»',
  '5': '«',
  '6': '\$',
  '7': '€',
  '8': '„',
  '9': '“',
  '0': '”',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _Neo3NumberToSymbol = {
  '1': '¹',
  '2': '²',
  '3': '³',
  '4': '›',
  '5': '‹',
  '6': '₵',
  '7': '¥',
  '8': '‚',
  '9': '‘',
  '0': '’',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _Neo5NumberToSymbol = {
  '1': '¹',
  '2': '²',
  '3': '³',
  '4': '♀',
  '5': '♂',
  '6': '⚥',
  '7': '𝛘',
  '8': '〈',
  '9': '〉',
  '0': '𝛐',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _Neo6NumberToSymbol = {
  '1': '¬',
  '2': '∨',
  '3': '∧',
  '4': '⊥',
  '5': '∡',
  '6': '∥',
  '7': '→',
  '8': '∞',
  '9': '∝',
  '0': '∅',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _QWERTY_USNumberToSymbol = {
  '1': '!',
  '2': '@',
  '3': '#',
  '4': '\$',
  '5': '%',
  '6': '^',
  '7': '&',
  '8': '*',
  '9': '(',
  '0': ')',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _SymbolToQWERTZ_T1Number = {
  '!': '1',
  '"': '2',
  '§': '3',
  '\$': '4',
  '%': '5',
  '&': '6',
  '/': '7',
  '(': '8',
  ')': '9',
  '=': '0',
  '²': '2',
  '³': '3',
  '{': '7',
  '[': '8',
  ']': '9',
  '}': '0',
  ' ': ' ',
  '.': '.'
};

const Map<String, String> _SymbolToAZERTYNumber = {
  '&': '1',
  'é': '2',
  '"': '3',
  "'": '4',
  '(': '5',
  '-': '6',
  'è': '7',
  '_': '8',
  'ç': '9',
  'à': '0',
  '~': '2',
  '#': '3',
  '{': '4',
  '[': '5',
  '|': '6',
  '`': '7',
  '\\': '8',
  '^': '9',
  '@': '0',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _SymbolToBEPONumber = {
  '"': '1',
  '«': '2',
  '»': '3',
  "(": '4',
  ')': '5',
  '@': '6',
  '+': '7',
  '-': '8',
  '/': '9',
  '*': '0',
  '_': '1',
  '<': '2',
  '>': '3',
  '[': '4',
  ']': '5',
  '^': '6',
  '±': '7',
  '÷': '9',
  '×': '0',
  ' ': ' ',
  '.': '.'
};

const Map<String, String> _SymbolToNeoNumber = {
  '°': '1',
  '§': '2',
  'ℓ': '3',
  '»': '4',
  '«': '5',
  '\$': '6',
  '/': '7',
  '„': '8',
  '“': '9',
  '”': '0',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _SymbolToNeo3Number = {
  '¹': '1',
  '²': '2',
  '³': '3',
  '›': '4',
  '‹': '5',
  '₵': '6',
  '¥': '7',
  '‚': '8',
  '‘': '9',
  '’': '0',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _SymbolToNeo5Number = {
  '¹': '1',
  '²': '2',
  '³': '3',
  '♀': '4',
  '♂': '5',
  '⚥': '6',
  '𝛘': '7',
  '〈': '8',
  '〉': '9',
  '𝛐': '0',
  ' ': ' ',
  '.': '.'
};
const Map<String, String> _SymbolToNeo6Number = {
  '¬': '1',
  '∨': '2',
  '∧': '3',
  '⊥': '4',
  '∡': '5',
  '∥': '6',
  '→': '7',
  '∞': '8',
  '∝': '9',
  '∅': '0',
  ' ': ' ',
  '.': '.'
};
final Map<String, String> _SymbolToQWERTY_USNumber = switchMapKeyValue(_QWERTY_USNumberToSymbol);
final Map<String, String> _SymbolToDvorakNumber = _SymbolToQWERTY_USNumber;

const Map<String, String> _QWERTZ_T1toNormal = {
  '°': '100o',
  '!': '101o',
  '"': '102o',
  '§': '103o',
  '\$': '104o',
  '%': '105o',
  '&': '106o',
  '/': '107o',
  '(': '108o',
  ')': '109o',
  '=': '110o',
  '?': '111o',
  '`': '112o',
  '^': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  'ß': '111u',
  '´': '112u',
  'Q': '201o',
  'W': '202o',
  'E': '203o',
  'R': '204o',
  'T': '205o',
  'Z': '206o',
  'U': '207o',
  'I': '208o',
  'O': '209o',
  'P': '210o',
  'Ü': '211o',
  '*': '212o',
  'q': '201u',
  'w': '202u',
  'e': '203u',
  'r': '204u',
  't': '205u',
  'z': '206u',
  'u': '207u',
  'i': '208u',
  'o': '209u',
  'p': '210u',
  'ü': '211u',
  '+': '212u',
  'A': '301o',
  'S': '302o',
  'D': '303o',
  'F': '304o',
  'G': '305o',
  'H': '306o',
  'J': '307o',
  'K': '308o',
  'L': '309o',
  'Ö': '310o',
  'Ä': '311o',
  "'": '312o',
  'a': '301u',
  's': '302u',
  'd': '303u',
  'f': '304u',
  'g': '305u',
  'h': '306u',
  'j': '307u',
  'k': '308u',
  'l': '309u',
  'ö': '310u',
  'ä': '311u',
  '#': '312u',
  '>': '401o',
  'Y': '402o',
  'X': '403o',
  'C': '404o',
  'V': '405o',
  'B': '406o',
  'N': '407o',
  'M': '408o',
  ';': '409o',
  ':': '410o',
  '_': '411o',
  '<': '401u',
  'y': '402u',
  'x': '403u',
  'c': '404u',
  'v': '405u',
  'b': '406u',
  'n': '407u',
  'm': '408u',
  ',': '409u',
  '.': '410u',
  '-': '411u',
  ' ': '501',
  '²': '102a',
  '³': '103a',
  '\\': '111a',
  '@': '201a',
  '€': '203a',
  '|': '401a',
  'µ': '212a',
  '': '',
};
final Map<String, String> _Dvorak_II_DEUtoNormal = {
  // https://web.archive.org/web/20170117021436/http://www.go-dvorak.com/media/img/dvorak-tastatur-detailansicht.jpg
  '°': '100o',
  '!': '101o',
  '"': '102o',
  '§': '103o',
  '\$': '104o',
  '%': '105o',
  '&': '106o',
  '/': '107o',
  '(': '108o',
  ')': '109o',
  '=': '110o',
  '*': '111o',
  '>': '112o',
  '^': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '+': '111u',
  '<': '112u',
  'Ü': '201o',
  ';': '202o',
  ':': '203o',
  'P': '204o',
  'Y': '205o',
  'F': '206o',
  'G': '207o',
  'C': '208o',
  'T': '209o',
  'Z': '210o',
  'ß': '211o',
  '\\': '212o',
  'ü': '201u',
  ',': '202u',
  '.': '203u',
  'p': '204u',
  'y': '205u',
  'f': '206u',
  'g': '207u',
  'c': '208u',
  't': '209u',
  'z': '210u',
  '?': '211u',
  '/': '212u',
  'A': '301o',
  'O': '302o',
  'E': '303o',
  'I': '304o',
  'U': '305o',
  'H': '306o',
  'D': '307o',
  'R': '308o',
  'N': '309o',
  'S': '310o',
  'L': '311o',
  "_'": '312o',
  'a': '301u',
  'o': '302u',
  'e': '303u',
  'i': '304u',
  'u': '305u',
  'h': '306u',
  'd': '307u',
  'r': '308u',
  'n': '309u',
  's': '310u',
  'l': '311u',
  '-': '312u',
  'Ä': '401o',
  'Ö': '402o',
  'Q': '403o',
  'J': '404o',
  'K': '405o',
  'X': '406o',
  'B': '407o',
  'M': '408o',
  'W': '409o',
  'V': '410o',
  '#': '411o',
  'ä': '401u',
  'ö': '402u',
  'q': '403u',
  'j': '404u',
  'k': '405u',
  'x': '406u',
  'b': '407u',
  'm': '408u',
  'w': '409u',
  'v': '410u',
  "'": '411u',
  ' ': '501',
  '@': '403a',
  'µ': '408a',
  '€': '303a',
  '²': '102a',
  '³': '103a',
  '|': '105a',
  '{': '107a',
  '[': '108a',
  ']': '109a',
  '}': '110a',
  '~': '111a',
  '`': '112a',
  '´': '212a'
};
final Map<String, String> _Dvorak_I_DEU1toNormal = {
  '°': '100o',
  '!': '101o',
  '"': '102o',
  '§': '103o',
  '\$': '104o',
  '%': '105o',
  '&': '106o',
  '/': '107o', //double entry ??
  '(': '108o',
  ')': '109o',
  '=': '110o',
  '*': '111o',
  '>': '112o',
  '^': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '+': '111u',
  '<': '112u',
  'Ä': '201o',
  ';': '202o',
  ':': '203o',
  'P': '204o',
  'Y': '205o',
  'F': '206o',
  'G': '207o',
  'C': '208o',
  'R': '209o',
  'L': '210o',
  'Q': '211o',
  '/': '212o',
  'ä': '201u',
  ',': '202u',
  '.': '203u',
  'p': '204u',
  'y': '205u',
  'f': '206u',
  'g': '207u',
  'c': '208u',
  'r': '209u',
  'l': '210u',
  'q': '211u',
  '\\': '212u',
  'A': '301o',
  'O': '302o',
  'E': '303o',
  'U': '304o',
  'I': '305o',
  'D': '306o',
  'H': '307o',
  'T': '308o',
  'N': '309o',
  'S': '310o',
  '?': '311o',
  "_'": '312o',
  'a': '301u',
  'o': '302u',
  'e': '303u',
  'u': '304u',
  'i': '305u',
  'd': '306u',
  'h': '307u',
  't': '308u',
  'n': '309u',
  's': '310u',
  'ß': '311u',
  '-': '312u',
  'Ö': '401o',
  'Ü': '402o',
  'J': '403o',
  'K': '404o',
  'X': '405o',
  'B': '406o',
  'M': '407o',
  'W': '408o',
  'V': '409o',
  'Z': '410o',
  'ö': '401u',
  'ü': '402u',
  'j': '403u',
  'k': '404u',
  'x': '405u',
  'b': '406u',
  'm': '407u',
  'w': '408u',
  'v': '409u',
  "z": '410u',
  ' ': '501',
  '': ''
};
final Map<String, String> _Dvorak_I_DEU2toNormal = {
  '°': '100o',
  '!': '101o',
  '"': '102o',
  '§': '103o',
  '\$': '104o',
  '%': '105o',
  '&': '106o',
  '/': '107o', //double entry ??
  '(': '108o',
  ')': '109o',
  '=': '110o',
  '*': '111o',
  '>': '112o',
  '^': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '+': '111u',
  '<': '112u',
  'Ö': '201o',
  'Ü': '202o',
  'Ä': '203o',
  'P': '204o',
  'Y': '205o',
  'F': '206o',
  'G': '207o',
  'C': '208o',
  'R': '209o',
  'L': '210o',
  'Q': '211o',
  '/': '212o',
  'ö': '201u',
  'ü': '202u',
  'ä': '203u',
  'p': '204u',
  'y': '205u',
  'f': '206u',
  'g': '207u',
  'c': '208u',
  'r': '209u',
  'l': '210u',
  'q': '211u', //double entry ??
  '\\': '212u',
  'A': '301o',
  'O': '302o',
  'E': '303o',
  'U': '304o',
  'I': '305o',
  'D': '306o',
  'H': '307o',
  'T': '308o',
  'N': '309o',
  'S': '310o',
  '?': '311o',
  "Q'": '312o',
  'a': '301u',
  'o': '302u',
  'e': '303u',
  'u': '304u',
  'i': '305u',
  'd': '306u',
  'h': '307u',
  't': '308u',
  'n': '309u',
  's': '310u',
  'ß': '311u',
  'q': '312u',
  ':': '401o',
  ';': '402o',
  'J': '403o',
  'K': '404o',
  'X': '405o',
  'B': '406o',
  'M': '407o',
  'W': '408o',
  'V': '409o',
  'Z': '410o',
  '.': '401u',
  ',': '402u',
  'j': '403u',
  'k': '404u',
  'x': '405u',
  'b': '406u',
  'm': '407u',
  'w': '408u',
  'v': '409u',
  "z": '410u',
  ' ': '501',
  '': ''
};
final Map<String, String> _Dvorak_I_DEU3toNormal = {
  '°': '100o',
  '!': '101o',
  '"': '102o',
  '§': '103o',
  '\$': '104o',
  '%': '105o',
  '&': '106o',
  '/': '107o', //double entry ??
  '(': '108o',
  ')': '109o',
  '=': '110o',
  '*': '111o',
  '>': '112o',
  '^': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '+': '111u',
  '<': '112u',
  'Ä': '201o',
  'Ö': '202o',
  'Ü': '203o',
  'P': '204o',
  'Y': '205o',
  'F': '206o',
  'G': '207o',
  'C': '208o',
  'R': '209o',
  'L': '210o',
  'Q': '211o',
  '/': '212o',
  'ä': '201u',
  'ö': '202u',
  'ü': '203u',
  'p': '204u',
  'y': '205u',
  'f': '206u',
  'g': '207u',
  'c': '208u',
  'r': '209u',
  'l': '210u',
  'q': '211u', //double entry ??
  '\\': '212u',
  'A': '301o',
  'O': '302o',
  'E': '303o',
  'U': '304o',
  'I': '305o',
  'D': '306o',
  'H': '307o',
  'T': '308o',
  'N': '309o',
  'S': '310o',
  '?': '311o',
  "Q'": '312o',
  'a': '301u',
  'o': '302u',
  'e': '303u',
  'u': '304u',
  'i': '305u',
  'd': '306u',
  'h': '307u',
  't': '308u',
  'n': '309u',
  's': '310u',
  'ß': '311u',
  'q': '312u',
  ':': '401o',
  ';': '402o',
  'J': '403o',
  'K': '404o',
  'X': '405o',
  'B': '406o',
  'M': '407o',
  'W': '408o',
  'V': '409o',
  'Z': '410o',
  '.': '401u',
  ',': '402u',
  'j': '403u',
  'k': '404u',
  'x': '405u',
  'b': '406u',
  'm': '407u',
  'w': '408u',
  'v': '409u',
  "z": '410u',
  ' ': '501',
  '': ''
};
final Map<String, String> _NeoToNormal = {
  'ˇ': '100o',
  '°': '101o',
  '§': '102o',
  'ℓ': '103o',
  '»': '104o',
  '«': '105o',
  '\$': '106o',
  '€': '107o',
  '„': '108o',
  '“': '109o',
  '”': '110o',
  '—': '111o',
  '¸': '112o',
  '^': '100o',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '-': '111u', //double entry ??
  '`': '112u',
  'X': '201o',
  'V': '202o',
  'L': '203o',
  'C': '204o',
  'W': '205o',
  'K': '206o',
  'H': '207o',
  'G': '208o',
  'F': '209o',
  'Q': '210o',
  'ẞ': '211o',
  '˜': '212o',
  'x': '201u',
  'v': '202u',
  'l': '203u',
  'c': '204u',
  'w': '205u',
  'k': '206u',
  'h': '207u',
  'g': '208u',
  'f': '209u',
  'q': '210u',
  'ß': '211u',
  '´': '212u',
  'U': '301o',
  'I': '302o',
  'A': '303o',
  'E': '304o',
  'O': '305o',
  'S': '306o',
  'N': '307o',
  'R': '308o',
  'T': '309o',
  'D': '310o',
  'Y': '311o',
  'u': '301u',
  'i': '302u',
  'a': '303u',
  'e': '304u',
  'o': '305u',
  's': '306u',
  'n': '307u',
  'r': '308u',
  't': '309u',
  'd': '310u',
  'y': '311u',
  'Ü': '402o',
  'Ö': '403o',
  'Ä': '404o',
  'P': '405o',
  'Z': '406o',
  'B': '407o',
  'M': '408o',
  '-': '409o',
  '·': '410o',
  'J': '411o',
  'ü': '402u',
  'ö': '403u',
  'ä': '404u',
  'p': '405u',
  'z': '406u',
  'b': '407u',
  'm': '408u',
  ',': '409u',
  '.': '410u',
  'j': '411u',
  ' ': '501',
  '': ''
};
final Map<String, String> _BoneToNormal = {
  'ˇ': '100o',
  '°': '101o',
  '§': '102o',
  'ℓ': '103o',
  '»': '104o',
  '«': '105o',
  '\$': '106o',
  '€': '107o',
  '„': '108o',
  '“': '109o',
  '”': '110o',
  '—': '111o',
  '¸': '112o',
  '^': '100o',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '-': '111u', //double entry ??
  '`': '112u',
  'J': '201o',
  'D': '202o',
  'U': '203o',
  'A': '204o',
  'X': '205o',
  'P': '206o',
  'H': '207o',
  'L': '208o',
  'M': '209o',
  'W': '210o',
  'ẞ': '211o',
  '˜': '212o',
  'j': '201u',
  'd': '202u',
  'u': '203u',
  'a': '204u',
  'x': '205u',
  'p': '206u',
  'h': '207u',
  'l': '208u',
  'm': '209u',
  'w': '210u',
  'ß': '211u',
  '´': '212u',
  'C': '301o',
  'T': '302o',
  'I': '303o',
  'E': '304o',
  'O': '305o',
  'B': '306o',
  'N': '307o',
  'R': '308o',
  'S': '309o',
  'G': '310o',
  'Q': '311o',
  'c': '301u',
  't': '302u',
  'i': '303u',
  'e': '304u',
  'o': '305u',
  'b': '306u',
  'n': '307u',
  'r': '308u',
  's': '309u',
  'g': '310u',
  'q': '311u',
  'F': '402o',
  'V': '403o',
  'Ü': '404o',
  'Ä': '405o',
  'Ö': '406o',
  'Y': '407o',
  'Z': '408o',
  '-': '409o',
  '·': '410o',
  'K': '411o',
  'f': '402u',
  'v': '403u',
  'ü': '404u',
  'ä': '405u',
  'ö': '406u',
  'y': '407u',
  'z': '408u',
  ',': '409u',
  '.': '410u',
  'k': '411u',
  ' ': '501',
  '': ''
};
const Map<String, String> _RistomeToNormal = {
  '°': '100o',
  '!': '101o',
  '"': '102o',
  '§': '103o',
  '\$': '104o',
  '%': '105o',
  '&': '106o',
  '/': '107o',
  '(': '108o',
  ')': '109o',
  '=': '110o',
  '_': '111o',
  '`': '112o',
  '^': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '-': '111u',
  '´': '112u',
  'Q': '201o',
  'P': '202o',
  'R': '203o',
  'O': '204o',
  'C': '205o',
  'B': '206o',
  'T': '207o',
  'D': '208o',
  'W': '209o',
  'J': '210o',
  'Ö': '211o',
  '*': '212o',
  'q': '201u',
  'p': '202u',
  'r': '203u',
  'o': '204u',
  'c': '205u',
  'b': '206u',
  't': '207u',
  'd': '208u',
  'w': '209u',
  'j': '210u',
  'ö': '211u',
  '+': '212u',
  'Z': '301o',
  'L': '302o',
  'A': '303o',
  'N': '304o',
  'I': '305o',
  'U': '306o',
  'E': '307o',
  'H': '308o',
  'S': '309o',
  'F': '310o',
  'Y': '311o',
  "'": '312o',
  'z': '301u',
  'l': '302u',
  'a': '303u',
  'n': '304u',
  'i': '305u',
  'u': '306u',
  'e': '307u',
  'h': '308u',
  's': '309u',
  'f': '310u',
  'y': '311u',
  '#': '312u',
  '>': '401o',
  'X': '402o',
  'V': '403o',
  'G': '404o',
  'M': '405o',
  'K': '406o',
  'Ä': '407o',
  'Ü': '408o',
  '?': '409o',
  ';': '410o',
  ':': '411o',
  '<': '401u',
  'x': '402u',
  'v': '403u',
  'g': '404u',
  'm': '405u',
  'k': '406u',
  'ä': '407u',
  'ü': '408u',
  'ß': '409u',
  ',': '410u',
  '.': '411u',
  ' ': '501',
  '': ''
};
const Map<String, String> _QWERTY_US_INTtoNormal = {
  '~': '100o',
  '!': '101o',
  '@': '102o',
  '#': '103o',
  '\$': '104o',
  '%': '105o',
  '^': '106o',
  '&': '107o',
  '*': '108o',
  '(': '109o',
  ')': '110o',
  '_': '111o',
  '+': '112o',
  '`': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '-': '111u',
  '=': '112u',
  'Q': '201o',
  'W': '202o',
  'E': '203o',
  'R': '204o',
  'T': '205o',
  'Y': '206o',
  'U': '207o',
  'I': '208o',
  'O': '209o',
  'P': '210o',
  '{': '211o',
  '}': '212o',
  '|': '213o',
  'q': '201u',
  'w': '202u',
  'e': '203u',
  'r': '204u',
  't': '205u',
  'y': '206u',
  'u': '207u',
  'i': '208u',
  'o': '209u',
  'p': '210u',
  '[': '211u',
  ']': '212u',
  '\\': '213u',
  'A': '301o',
  'S': '302o',
  'D': '303o',
  'F': '304o',
  'G': '305o',
  'H': '306o',
  'J': '307o',
  'K': '308o',
  'L': '309o',
  ':': '310o',
  '"': '311o',
  'a': '301u',
  's': '302u',
  'd': '303u',
  'f': '304u',
  'g': '305u',
  'h': '306u',
  'j': '307u',
  'k': '308u',
  'l': '309u',
  ';': '310u',
  "'": '311u',
  'Z': '402o',
  'X': '403o',
  'C': '404o',
  'V': '405o',
  'B': '406o',
  'N': '407o',
  'M': '408o',
  '<': '409o',
  '>': '410o',
  '?': '411o',
  'z': '402u',
  'x': '403u',
  'c': '404u',
  'v': '405u',
  'b': '406u',
  'n': '407u',
  'm': '408u',
  ',': '409u',
  '.': '410u',
  '/': '411u',
  ' ': '501',
  '': ''
};
const Map<String, String> _DvoraktoNormal = {
  '~': '101o',
  '!': '102o',
  '@': '103o',
  '#': '104o',
  '\$': '105o',
  '%': '106o',
  '^': '107o',
  '&': '108o',
  '*': '109o',
  '(': '110o',
  ')': '111o',
  '{': '112o',
  '}': '113o',
  '`': '101u',
  '1': '102u',
  '2': '103u',
  '3': '104u',
  '4': '105u',
  '5': '106u',
  '6': '107u',
  '7': '108u',
  '8': '109u',
  '9': '110u',
  '0': '111u',
  '[': '112u',
  ']': '113u',
  '"': '201o',
  '<': '202o',
  '>': '203o',
  'P': '204o',
  'Y': '205o',
  'F': '206o',
  'G': '207o',
  'C': '208o',
  'R': '209o',
  'L': '210o',
  '?': '211o',
  '+': '212o',
  '|': '213o',
  "'": '201u',
  ',': '202u',
  '.': '203u',
  'p': '204u',
  'y': '205u',
  'f': '206u',
  'g': '207u',
  'c': '208u',
  'r': '209u',
  'l': '210u',
  '/': '211u',
  '=': '212u',
  '\\': '213u',
  'A': '301o',
  'O': '302o',
  'E': '303o',
  'U': '304o',
  'I': '305o',
  'D': '306o',
  'H': '307o',
  'T': '308o',
  'N': '309o',
  'S': '310o',
  '_': '311o',
  'a': '301u',
  'o': '302u',
  'e': '303u',
  'u': '304u',
  'i': '305u',
  'd': '306u',
  'h': '307u',
  't': '308u',
  'n': '309u',
  's': '310u',
  "-": '311u',
  ':': '402o',
  'Q': '403o',
  'J': '404o',
  'K': '405o',
  'X': '406o',
  'B': '407o',
  'M': '408o',
  'W': '409o',
  'V': '410o',
  'Z': '411o',
  ';': '402u',
  'q': '403u',
  'j': '404u',
  'k': '405u',
  'x': '406u',
  'b': '407u',
  'm': '408u',
  'w': '409u',
  'v': '410u',
  'z': '411u',
  ' ': '501',
  '': ''
};
const Map<String, String> _ColemakToNormal = {
  '~': '100o',
  '!': '101o',
  '@': '102o',
  '#': '103o',
  '\$': '104o',
  '%': '105o',
  '^': '106o',
  '&': '107o',
  '*': '108o',
  '(': '109o',
  ')': '110o',
  '_': '111o',
  '+': '112o',
  '`': '100u',
  '1': '101u',
  '2': '102u',
  '3': '103u',
  '4': '104u',
  '5': '105u',
  '6': '106u',
  '7': '107u',
  '8': '108u',
  '9': '109u',
  '0': '110u',
  '-': '111u',
  '=': '112u',
  'Q': '201o',
  'W': '202o',
  'F': '203o',
  'P': '204o',
  'G': '205o',
  'J': '206o',
  'L': '207o',
  'U': '208o',
  'Y': '209o',
  ':': '210o',
  '{': '211o',
  '}': '212o',
  '|': '213o',
  "q": '201u',
  'w': '202u',
  'f': '203u',
  'p': '204u',
  'g': '205u',
  'j': '206u',
  'l': '207u',
  'u': '208u',
  'y': '209u',
  ';': '210u',
  '[': '211u',
  ']': '212u',
  '\\': '213u',
  'A': '301o',
  'R': '302o',
  'S': '303o',
  'T': '304o',
  'D': '305o',
  'H': '306o',
  'N': '307o',
  'E': '308o',
  'I': '309o',
  'O': '310o',
  '"': '311o',
  'a': '301u',
  'r': '302u',
  's': '303u',
  't': '304u',
  'd': '305u',
  'h': '306u',
  'n': '307u',
  'e': '308u',
  'i': '309u',
  'o': '310u',
  "'": '311u',
  'Z': '402o',
  'X': '403o',
  'C': '404o',
  'V': '405o',
  'B': '406o',
  'K': '407o',
  'M': '408o',
  '<': '409o',
  '>': '410o',
  '?': '411o',
  'z': '402u',
  'x': '403u',
  'c': '404u',
  'v': '405u',
  'b': '406u',
  'k': '407u',
  'm': '408u',
  ',': '409u',
  '.': '410u',
  '/': '411u',
  ' ': '501',
  '': ''
};
const Map<String, String> _AZERTYToNormal = {
  '#': '100o',
  '1': '101o',
  '2': '102o',
  '3': '103o',
  '4': '104o',
  '5': '105o',
  '6': '106o',
  '7': '107o',
  '8': '108o',
  '9': '109o',
  '0': '110o',
  '"': '111o',
  '¨': '112o',
  '@': '100u',
  'à': '101u',
  'é': '102u',
  'è': '103u',
  'ê': '104u',
  '(': '105u',
  ')': '106u',
  '\u07F5': '107u',
  '\u07F4': '108u',
  '«': '109u',
  '»': '110u',
  "'": '111u',
  '^': '112u',
  'A': '201o',
  'Z': '202o',
  'E': '203o',
  'R': '204o',
  'T': '205o',
  'Y': '206o',
  'U': '207o',
  'I': '208o',
  'O': '209o',
  'P': '210o',
  '_': '211o',
  '±': '212o',
  'a': '201u',
  'z': '202u',
  'e': '203u',
  'r': '204u',
  't': '205u',
  'y': '206u',
  'u': '207u',
  'i': '208u',
  'o': '209u',
  'p': '210u',
  '-': '211u',
  '+': '212u',
  'Q': '301o',
  'S': '302o',
  'D': '303o',
  'F': '304o',
  'G': '305o',
  'H': '306o',
  'J': '307o',
  'K': '308o',
  'L': '309o',
  'M': '310o',
  '\\': '311o',
  '½': '312o',
  'q': '301u',
  's': '302u',
  'd': '303u',
  'f': '304u',
  'g': '305u',
  'h': '306u',
  'j': '307u',
  'k': '308u',
  'l': '309u',
  'm': '310u',
  '/': '311u',
  '*': '312u',
  '>': '401o',
  'W': '402o',
  'X': '403o',
  'C': '404o',
  'V': '405o',
  'B': '406o',
  'N': '407o',
  '?': '408o',
  '!': '409o',
  '…': '410o',
  '=': '411o',
  '<': '401u',
  'w': '402u',
  'x': '403u',
  'c': '404u',
  'v': '405u',
  'b': '406u',
  'n': '407u',
  '.': '408u',
  ',': '409u',
  ':': '410u',
  ';': '411u',
  ' ': '501',
  '': ''
};
const Map<String, String> _BEPOToNormal = {
  // https://en.wikipedia.org/wiki/B%C3%89PO#/media/File:KB_French_Dvorak_b%C3%A9po_simplifi%C3%A9.svg
  '#': '100o',
  '1': '101o',
  '2': '102o',
  '3': '103o',
  '4': '104o',
  '5': '105o',
  '6': '106o',
  '7': '107o',
  '8': '108o',
  '9': '109o',
  '0': '110o',
  '°': '111o',
  '`': '112o',
  '\$': '100u',
  '"': '101u',
  '«': '102u',
  '»': '103u',
  '(': '104u',
  ')': '105u',
  '@': '106u',
  "+": '107u',
  "-": '108u',
  "/": '109u',
  "*": '110u',
  "=": '111u',
  "%": '112u',
  'B': '201o',
  'É': '202o',
  'P': '203o',
  'O': '204o',
  'È': '205o',
  '!': '206o',
  'V': '207o',
  'D': '208o',
  'L': '209o',
  'J': '210o',
  'Z': '211o',
  'W': '212o',
  'b': '201u',
  'é': '202u',
  'p': '203u',
  'o': '204u',
  'è': '205u',
  '^': '206u',
  'v': '207u',
  'd': '208u',
  'l': '209u',
  'j': '210u',
  'z': '211u',
  'w': '212u',
  'A': '301o',
  'U': '302o',
  'I': '303o',
  'E': '304o',
  ';': '305o',
  'C': '306o',
  'T': '307o',
  'S': '308o',
  'R': '309o',
  'N': '310o',
  'M': '311o',
  'Ç': '312o',
  'a': '301u',
  'u': '302u',
  'i': '303u',
  'e': '304u',
  ',': '305u',
  'c': '306u',
  't': '307u',
  's': '308u',
  'r': '309u',
  'n': '310u',
  'm': '311u',
  'ç': '312u',
  'Ê': '401o',
  'À': '402o',
  'Y': '403o',
  'X': '404o',
  ':': '405o',
  'K': '406o',
  '?': '407o',
  'Q': '408o',
  'G': '409o',
  'H': '410o',
  'F': '411o',
  'ê': '401u',
  'à': '402u',
  'y': '403u',
  'x': '404u',
  '.': '405u',
  'k': '406u',
  "'": '407u',
  "q": '408u',
  'g': '409u',
  'h': '410u',
  'f': '411u',
  ' ': '501',
  '': ''
};

class KeyboardData {
  final KEYBOARD_TYPE type;
  String name;
  String example;

  KeyboardData(this.type, this.name, this.example);
}

List<KeyboardData> allKeyboards = [
  KeyboardData(KEYBOARD_TYPE.QWERTY_US_INT, 'keyboard_mode_qwerty_us_int', 'QWERTY'),
  KeyboardData(KEYBOARD_TYPE.QWERTZ_T1, 'keyboard_mode_qwertz_t1', 'QWERTZ'),
  KeyboardData(KEYBOARD_TYPE.FRA_AZERTY, 'keyboard_mode_fra_azerty', 'AZERTY'),
  KeyboardData(KEYBOARD_TYPE.DVORAK, 'keyboard_mode_dvorak', '"<>PYF'),
  KeyboardData(KEYBOARD_TYPE.DVORAK_I_DEU1, 'keyboard_mode_dvorak_I1', 'Ä;:PYF'),
  KeyboardData(KEYBOARD_TYPE.DVORAK_I_DEU2, 'keyboard_mode_dvorak_I2', 'ÖÜÄPYF'),
  KeyboardData(KEYBOARD_TYPE.DVORAK_I_DEU3, 'keyboard_mode_dvorak_I3', 'ÄÖÜPYF'),
  KeyboardData(KEYBOARD_TYPE.DVORAK_II_DEU, 'keyboard_mode_dvorak_II', 'Ü;:PYF'),
  KeyboardData(KEYBOARD_TYPE.RISTOME, 'keyboard_mode_ristome', 'QPROCB'),
  KeyboardData(KEYBOARD_TYPE.NEO, 'keyboard_mode_neo', 'XVLCWK'),
  KeyboardData(KEYBOARD_TYPE.BONE, 'keyboard_mode_bone', 'JDUAXP'),
  KeyboardData(KEYBOARD_TYPE.COLEMAK, 'keyboard_mode_colemak', 'QWFPGJ'),
  KeyboardData(KEYBOARD_TYPE.FRA_BEPO, 'keyboard_mode_fra_bepo', 'BÉPOÈ!'),
];

KeyboardData? getKeyboardByType(KEYBOARD_TYPE type) {
  return allKeyboards.firstWhereOrNull((element) => element.type == type);
}

KEYBOARD_TYPE? getKeyboardTypeByName(String name) {
  return allKeyboards.firstWhereOrNull((element) => element.name == name)?.type;
}

Map<String, String> _buildConvertingMap(KEYBOARD_TYPE type, _ConvertDirection direction) {
  Map<String, String> keyboardMap;
  switch (type) {
    case KEYBOARD_TYPE.QWERTZ_T1:
      keyboardMap = _QWERTZ_T1toNormal;
      break;
    case KEYBOARD_TYPE.RISTOME:
      keyboardMap = _RistomeToNormal;
      break;
    case KEYBOARD_TYPE.NEO:
      keyboardMap = _NeoToNormal;
      break;
    case KEYBOARD_TYPE.BONE:
      keyboardMap = _BoneToNormal;
      break;
    case KEYBOARD_TYPE.DVORAK_I_DEU1:
      keyboardMap = _Dvorak_I_DEU1toNormal;
      break;
    case KEYBOARD_TYPE.DVORAK_I_DEU2:
      keyboardMap = _Dvorak_I_DEU2toNormal;
      break;
    case KEYBOARD_TYPE.DVORAK_I_DEU3:
      keyboardMap = _Dvorak_I_DEU3toNormal;
      break;
    case KEYBOARD_TYPE.DVORAK_II_DEU:
      keyboardMap = _Dvorak_II_DEUtoNormal;
      break;
    case KEYBOARD_TYPE.FRA_AZERTY:
      keyboardMap = _AZERTYToNormal;
      break;
    case KEYBOARD_TYPE.FRA_BEPO:
      keyboardMap = _BEPOToNormal;
      break;
    case KEYBOARD_TYPE.QWERTY_US_INT:
      keyboardMap = _QWERTY_US_INTtoNormal;
      break;
    case KEYBOARD_TYPE.DVORAK:
      keyboardMap = _DvoraktoNormal;
      break;
    case KEYBOARD_TYPE.COLEMAK:
      keyboardMap = _ColemakToNormal;
      break;
  }
  if (direction == _ConvertDirection.toNormal) {
    return keyboardMap;
  } else {
    return switchMapKeyValue(keyboardMap);
  }
}

String encodeKeyboard(String input, KEYBOARD_TYPE keyboardFrom, KEYBOARD_TYPE keyboardTo) {
  Map<String, String> mapSourceToNormal = <String, String>{};
  Map<String, String> mapNormalToTarget = <String, String>{};

  if (input.isEmpty) return '';

  mapSourceToNormal = _buildConvertingMap(keyboardFrom, _ConvertDirection.toNormal);
  mapNormalToTarget = _buildConvertingMap(keyboardTo, _ConvertDirection.fromNormal);

  return input.split('').map((character) {
    var normal = mapSourceToNormal[character];
    if (normal != null) {
      var target = mapNormalToTarget[normal];
      if (target != null) {
        return target;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }).join('');
}

String _convert(String input, Map<String, String> layout) {
  return input.split('').map((character) {
    if (character == ' ') {
      return ' ';
    } else if (character == '.') {
      return '.';
    } else if (layout[character] == null) {
      return ' ';
    } else {
      return layout[character];
    }
  }).join('');
}

List<List<String>> encodeKeyboardNumbers(String input) {
  List<List<String>> output = <List<String>>[];
  output.add(['keyboard_mode_qwertz_ristome_dvorak', _convert(input, _QWERTZ_T1NumberToSymbol)]);
  output.add(['keyboard_mode_neo', _convert(input, _NeoNumberToSymbol)]);
  output.add(['keyboard_mode_neo_3', _convert(input, _Neo3NumberToSymbol)]);
  output.add(['keyboard_mode_neo_5', _convert(input, _Neo5NumberToSymbol)]);
  output.add(['keyboard_mode_neo_6', _convert(input, _Neo6NumberToSymbol)]);
  output.add(['keyboard_mode_fra_azerty', _convert(input, _AZERTYNumberToSymbol)]);
  output.add(['keyboard_mode_fra_bepo', _convert(input, _BEPONumberToSymbol)]);
  output.add(['keyboard_mode_qwerty_us_int_colemak_dvorak', _convert(input, _QWERTY_USNumberToSymbol)]);

  return output;
}

final Map<String, String Function(String)> keyboardNumbersByName = {
  'keyboard_mode_qwertz_ristome_dvorak': (String input) => _convert(input, _SymbolToQWERTZ_T1Number),
  'keyboard_mode_neo': (String input) => _convert(input, _SymbolToNeoNumber),
  'keyboard_mode_neo_3': (String input) => _convert(input, _SymbolToNeo3Number),
  'keyboard_mode_neo_5': (String input) => _convert(input, _SymbolToNeo5Number),
  'keyboard_mode_neo_6': (String input) => _convert(input, _SymbolToNeo6Number),
  'keyboard_mode_fra_azerty': (String input) => _convert(input, _SymbolToAZERTYNumber),
  'keyboard_mode_fra_bepo': (String input) => _convert(input, _SymbolToBEPONumber),
  'keyboard_mode_qwerty_us_int_colemak_dvorak': (String input) => _convert(input, _SymbolToDvorakNumber),
};

List<List<String>> decodeKeyboardNumbers(String input) {
  List<List<String>> output = <List<String>>[];
  keyboardNumbersByName.forEach((name, function) {
    output.add([name, function(input)]);
  });

  return output;
}
