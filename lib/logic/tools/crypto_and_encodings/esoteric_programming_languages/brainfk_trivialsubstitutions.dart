// https://esolangs.org/wiki/Trivial_brainfuck_substitution

import 'package:gc_wizard/utils/common_utils.dart';

enum BrainfkTrivial {
  ALPHK,
  BINARYFK,
  BLUB,
  BTJZXGQUARTFRQIFJLV,
  COLONOSCOPY,
  COW,
  DETAILEDFK,
  FLUFFLEPUFF,
  FUCKBEES,
  GERMAN,
  KENNYSPEAK,
  KONFK,
  MORSEFK,
  NAK,
  OMAM,
  OOK,
  PSSCRIPT,
  PIKALANG,
  REVERSEFK,
  REVOLUTION9,
  ROADRUNNER,
  SCREAMCODE,
  TERNARY,
  TRIPLET,
  UWU,
  ZZZ,
  CUSTOM
}

Map brainfkTrivialSubstitutions = {
//  '' : {'>' : '', '<' : '', '+' : '', '-' : '', '.' : '', ',' : '', '[' : '', ']' : ''},
  'Omam': {
    '>': 'hold your horses now',
    '<': 'sleep until the sun goes down',
    '+': 'through the woods we ran',
    '-': 'deep into the mountain sound',
    '.': 'don' + "'" + 't listen to a word i say',
    ',': 'the screams all sound the same',
    '[': '	though the truth may vary',
    ']': 'this ship will carry'
  },
  'Revolution 9': {
    '>': 'It' + "'" + 's alright',
    '<': 'turn me on, dead man',
    '+': 'Number 9',
    '-': 'if you become naked',
    '.': 'The Beatles',
    ',': 'Paul is dead',
    '[': 'Revolution 1',
    ']': 'Revolution 9'
  },
  'DetailedF**k': {
    '>': 'MOVE THE MEMORY POINTER ONE CELL TO THE RIGHT',
    '<': 'MOVE THE MEMORY POINTER ONE CELL TO THE LEFT',
    '+': 'INCREMENT THE CELL UNDER THE MEMORY POINTER BY ONE',
    '-': 'DECREMENT THE CELL UNDER THE MEMORY POINTER BY ONE',
    '.': 'REPLACE THE CELL UNDER THE MEMORY POINTER' + "'" + 'S VALUE WITH THE ASCII CHARACTER CODE OF USER INPUT',
    ',': 'PRINT THE CELL UNDER THE MEMORY POINTER' + "'" + 'S VALUE AS AN ASCII CHARACTER',
    '[': 'IF THE CELL UNDER THE MEMORY POINTER' +
        "'" +
        'S VALUE IS ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE ] COMMAND IN BRAINFUCK',
    ']': 'IF THE CELL UNDER THE MEMORY POINTER' +
        "'" +
        'S VALUE IS NOT ZERO INSTEAD OF READING THE NEXT COMMAND IN THE PROGRAM JUMP TO THE CORRESPONDING COMMAND EQUIVALENT TO THE [ COMMAND IN BRAINFUCK'
  },
  'German': {
    '>': 'Links',
    '<': 'Rechts',
    '+': 'Addition',
    '-': 'Subtraktion',
    '.': 'Eingabe',
    ',': 'Ausgabe',
    '[': 'Schleifenanfang',
    ']': 'Schleifenende'
  },
  'Colonoscopy': {'>': ';};', '<': ';{;', '+': ';;};', '-': ';;{;', '.': ';;;};', ',': ';;;{;', '[': '{{;', ']': '}};'},
  'K-on F**k': {
    '>': 'うんうんうん',
    '<': 'うんうんたん',
    '+': 'うんたんうん',
    '-': 'うんたんたん',
    '.': 'たんうんうん',
    ',': 'たんうんたん',
    '[': 'たんたんうん',
    ']': 'たんたんたん'
  },
  'fuckbeEs': {'>': 'f', '<': 'u', '+': 'c', '-': 'k', '.': 'b', ',': 'e', '[': 'E', ']': 's'},
  'PsScript': {
    '>': '8=D',
    '<': '8==D',
    '+': '8===D',
    '-': '8====D',
    '.': '8=====D',
    ',': '8======D',
    '[': '8=======D',
    ']': '8========D'
  },
  'Alph**k': {'>': 'a', '<': 'c', '+': 'e', '-': 'i', '.': 'j', ',': 'o', '[': 'p', ']': 's'},
  'ReverseF**k': {'>': '<', '<': '>', '+': '-', '-': '+', '.': ',', ',': '.', '[': ']', ']': '['},
  'Btjzxgquartfrqifjlv': {'>': 'f', '<': 'rqi', '+': 'qua', '-': 'rtf', '.': 'lv', ',': 'j', '[': 'btj', ']': 'zxg'},
  'BinaryF**k': {'>': '010', '<': '011', '+': '000', '-': '001', '.': '100', ',': '101', '[': '110', ']': '111'},
  'Ternary': {'>': '01', '<': '00', '+': '11', '-': '10', '.': '20', ',': '21', '[': '02', ']': '12'},
  'Kenny Speak': {'>': 'mmp', '<': 'mmm', '+': 'mpp', '-': 'pmm', '.': 'fmm', ',': 'fpm', '[': 'mmf', ']': 'mpf'},
  'MorseF**k': {'>': '.--', '<': '--.', '+': '..-', '-': '-..', '.': '-.-', ',': '.-.', '[': '---', ']': '...'},
  'Blub': {
    '>': 'Blub. Blub?',
    '<': 'Blub? Blub.',
    '+': 'Blub. Blub.',
    '-': 'Blub! Blub!',
    '.': 'Blub! Blub.',
    ',': 'Blub. Blub!',
    '[': 'Blub! Blub?',
    ']': 'Blub? Blub!'
  },
  'Ook': {
    '>': 'Ook. Ook?',
    '<': 'Ook? Ook.',
    '+': 'Ook. Ook.',
    '-': 'Ook! Ook!',
    '.': 'Ook! Ook.',
    ',': 'Ook. Ook!',
    '[': 'Ook! Ook?',
    ']': 'Ook? Ook!'
  },
  'Nak': {
    '>': 'Nak. Nak?',
    '<': 'Nak? Nak.',
    '+': 'Nak. Nak.',
    '-': 'Nak! Nak!',
    '.': 'Nak! Nak.',
    ',': 'Nak. Nak!',
    '[': 'Nak! Nak?',
    ']': 'Nak? Nak!'
  },
  'PikaLang': {'>': 'pipi', '<': 'pichu', '+': 'pi', '-': 'ka', '.': 'pikachu', ',': 'pikapi', '[': 'pika', ']': 'chu'},
  'Roadrunner': {
    '>': 'meeP',
    '<': 'Meep',
    '+': 'mEEp',
    '-': 'MeeP',
    '.': 'MEEP',
    ',': 'meep',
    '[': 'mEEP',
    ']': 'MEEp'
  },
  'ZZZ': {'>': 'zz', '<': '-zz', '+': 'z', '-': '-z', '.': 'zzz', ',': '-zzz', '[': 'z+z', ']': 'z-z'},
  'ScreamCode': {
    '>': 'AAAH',
    '<': 'AAAAGH',
    '+': 'F*CK',
    '-': 'SHIT',
    '.': '!!!!!!',
    ',': 'WHAT?',
    '[': 'OW',
    ']': 'OWIE'
  },
  'Fluffle Puff': {'>': 'b', '<': 't', '+': 'pf', '-': 'bl', '.': '!', ',': '?', '[': '*gasp*', ']': '*pomf*'},
  'Triplet': {'>': '001', '<': '100', '+': '111', '-': '000', '.': '010', ',': '101', '[': '110', ']': '011'},
  'UwU': {'>': 'OwO', '<': '°w°', '+': 'UwU', '-': 'QwQ', '.': '@w@', ',': '>w<', '[': '~w~', ']': '-w-'},
  'Custom': {'>': '', '<': '', '+': '', '-': '', '.': '', ',': '', '[': '', ']': ''},
};

Map<BrainfkTrivial, String> BRAINFK_TRIVIAL_LIST = {
  BrainfkTrivial.ALPHK: 'Alph**k',
  BrainfkTrivial.BINARYFK: 'BinaryFuck',
  BrainfkTrivial.BLUB: 'Blub',
  BrainfkTrivial.BTJZXGQUARTFRQIFJLV: 'Btjzxgquartfrqifjlv',
  BrainfkTrivial.COLONOSCOPY: 'Colonoscopy',
  BrainfkTrivial.DETAILEDFK: 'DetailedF**k',
  BrainfkTrivial.FLUFFLEPUFF: 'Fluffle Puff',
  BrainfkTrivial.FUCKBEES: 'FuckbeEs',
  BrainfkTrivial.GERMAN: 'German',
  //BrainfkTrivial.HOHOHO: 'Hohoho!',
  BrainfkTrivial.KENNYSPEAK: 'Kenny Speak',
  BrainfkTrivial.KONFK: 'K-on F**k',
  BrainfkTrivial.MORSEFK: 'MorseF**k',
  BrainfkTrivial.NAK: 'Nak',
  BrainfkTrivial.OMAM: 'Omam',
  BrainfkTrivial.OOK: 'Ook',
  BrainfkTrivial.PSSCRIPT: 'P***sScript',
  BrainfkTrivial.PIKALANG: 'PikaLang',
  BrainfkTrivial.REVERSEFK: 'ReverseF**k',
  BrainfkTrivial.REVOLUTION9: 'Revolution 9',
  BrainfkTrivial.ROADRUNNER: 'Roadrunner',
  BrainfkTrivial.SCREAMCODE: 'ScreamCode',
  BrainfkTrivial.TERNARY: 'Ternary',
  BrainfkTrivial.TRIPLET: 'Triplet',
  BrainfkTrivial.UWU: 'UwU',
  BrainfkTrivial.ZZZ: 'ZZZ',
  BrainfkTrivial.CUSTOM: 'Custom',
};
final BrainFkTrivial = switchMapKeyValue(BRAINFK_TRIVIAL_LIST);
