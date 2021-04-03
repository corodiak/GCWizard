import 'package:diacritic/diacritic.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';

final AZToVanity = {
  'A': '2',
  'B': '22',
  'C': '222',
  'D': '3',
  'E': '33',
  'F': '333',
  'G': '4',
  'H': '44',
  'I': '444',
  'J': '5',
  'K': '55',
  'L': '555',
  'M': '6',
  'N': '66',
  'O': '666',
  'P': '7',
  'Q': '77',
  'R': '777',
  'S': '7777',
  'T': '8',
  'U': '88',
  'V': '888',
  'W': '9',
  'X': '99',
  'Y': '999',
  'Z': '9999',
  '1': '1',
  '2': '2222',
  '3': '3333',
  '4': '4444',
  '5': '5555',
  '6': '6666',
  '7': '77777',
  '8': '8888',
  '9': '99999',
  '0': '0'
};

final VanityToAZ = switchMapKeyValue(AZToVanity);

final VanityToDEU = {
  '6855' : 'NULL',
  '3467' : 'EINS',
  '9934' : 'ZWEI',
  '996' : 'ZWO',
  '7334' : 'DREI',
  '8437' : 'VIER',
  '38363' : 'FUENF',
  '73247' : 'SECHS',
  '743236' : 'SIEBEN',
  '2248' : 'ACHT',
  '6386' : 'NEUN',
};
final VanityToENG = {
  '9376' : 'ZERO',
  '663' : 'ONE',
  '896' : 'TWO',
  '84733' : 'THREE',
  '3687' : 'FOUR',
  '3483' : 'FIVE',
  '749' : 'SIX',
  '73836' : 'SEVEN',
  '34448' : 'EIGHT',
  '6386' : 'NINE',
};
final VanityToFRA = {
  '9376' : 'ZÉRO',
  '86' : 'UN',
  '3389' : 'DEUX',
  '8764' : 'TROIS',
  '782873' : 'QUATRE',
  '2467' : 'CINQ',
  '749' : 'SIX',
  '7378' : 'SEPT',
  '4848' : 'HUIT',
  '6386' : 'NEUF',
};
final VanityToITA = {
  '9376':'ZERO',
  '866':'UNO',
  '383':'DUE',
  '873':'TRE',
  '7828876':'QUATTRO',
  '346783':'CINQUE',
  '734':'SEI',
  '73883':'SETTE',
  '6886':'OTTO',
  '6683':'NOVE',
};
final VanityToDNK = {
  '685' : 'NUL',
  '36' : 'EN',
  '86' : 'TO',
  '873' : 'TRE',
  '3473' : 'FIRE',
  '336' : 'FEM',
  '7253' : 'SEKS',
  '7983' : 'SYVE',
  '6883' : 'OTTE',
  '64' : 'NI',
};
final VanityToESP = {
  '2376':'CERO',
  '876':'UNO',
  '872':'UNA',
  '367':'DOS',
  '8737':'TRES',
  '282876':'CUATRO',
  '24626':'CINCO',
  '7347':'SEIS',
  '74383':'SIETE',
  '6246':'OCHO',
  '68383':'NUEVE',
};
final VanityToNLD = {
  '685': 'NUL',
  '336': 'EEN',
  '9933': 'ZWEE',
  '8743': 'TRIE',
  '8437': 'VIER',
  '8453': 'VIJF',
  '937': 'ZES',
  '93836': 'ZEVEN',
  '2248': 'ACHT',
  '6343': 'NEGEN',
};
final VanityToNOR = {
  '685':'NUL',
  '36':'EN',
  '388':'ETT',
  '86':'TO',
  '873':'TRE',
  '3473':'FIRE',
  '336':'FEM',
  '7357':'SEKS',
  '758':'SJU',
  '798':'SYV',
  '2883':'ÅTTE',
  '64':'NI',
};
final VanityToPOL = {
  '9376':'ZERO',
  '53336':'JEDEN',
  '53362':'JEDNA',
  '53366':'JEDNO',
  '392':'DWA',
  '3943':'DWIE',
  '8779':'TRZY',
  '298379':'CZTERY',
  '7342':'PIĘĆ',
  '79372':'SZEŚĆ',
  '743336':'SIEDEM',
  '67436':'OSIEM',
  '39439432':'DZIEWIĘĆ',
};
final VanityToPOR = {
  '9376':'ZERO',
  '86':'UM',
  '3647':'DOIS',
  '3827':'DUAS',
  '8737':'TRES',
  '72876':'QUATRO',
  '24626':'CINCO',
  '7347':'SEIS',
  '7393':'SETE',
  '6886':'OITO',
  '6683':'NOVE',
};
final VanityToSWE = {
  '8655' : 'NOLL',
  '36' : 'EN',
  '388':'ETT',
  '882':'TVÅ',
  '873':'TRE',
  '3972':'FYRA',
  '336':'FEM',
  '739':'SEX',
  '758':'SJU',
  '2882':'ÅTTA',
  '646':'NIO',
};
final VanityToRUS = {
  '665':'NOL',
  '685':'NUL',
  '2363':'ADNA',
  '2366':'ADNO',
  '2346':'ADIN',
  '392':'DWA',
  '3953':'DWJE',
  '874':'TRI',
  '2389743':'ČETÝRIE',
  '7528':'PJAT',
  '7378':'ŠEST',
  '736':'SEM',
  '86736':'VOSEM',
  '3538528':'DJEVJAT',
};
final VanityToVOL = {
  '737':'SER',
  '225':'BAL',
  '835':'TEL',
  '545':'KIL',
  '365':'FOL',
  '585':'LUL',
  '6235':'MAEL',
  '935':'VEL',
  '5635':'JOEL',
  '9835':'ZUEL',
};
final VanityToEPO = {
  '6856':'NULO',
  '868':'UNU',
  '38':'DU',
  '874':'TRI',
  '5927':'KVAR',
  '5946':'KVIN',
  '737':'SES',
  '737':'SEP',
  '65':'OK',
  '628':'NAǓ',
};
final VanityToSOL = {
  '765':'SOLDO',
  '733636':'REDODO',
  '736464':'REMIMI',
  '733232':'REFAFA',
  '73765765':'RESOLSOL',
  '735252':'RELALA',
  '737474':'RESISI',
  '646436':'MIMIDO',
  '646473':'MIMIRE',
  '646432':'MIMIFA',
};
final VanityToLAT = {
  '93786' : 'ZERUM',
  '685586': 'NULLUM',
  '8687' : 'UNUS',
  '386' : 'DUO',
  '8742' : 'TRIA',
  '8737' : 'TRES',
  '78288867' : 'QUATTUOR',
  '7846783' : 'QUINQUE',
  '43927' : 'HEXAS',
  '739' : 'SEX',
  '737836' : 'SEPTEM',
  '6286' : 'OCTO',
  '66836' : 'NOVEM',
};

Map VanWords = {
  NumeralWordsLanguage.DEU: VanityToDEU,
  NumeralWordsLanguage.ENG: VanityToENG,
  NumeralWordsLanguage.FRA: VanityToFRA,
  NumeralWordsLanguage.ITA: VanityToITA,
  NumeralWordsLanguage.DNK: VanityToDNK,
  NumeralWordsLanguage.ESP: VanityToESP,
  NumeralWordsLanguage.NLD: VanityToNLD,
  NumeralWordsLanguage.NOR: VanityToNOR,
  NumeralWordsLanguage.POL: VanityToPOL,
  NumeralWordsLanguage.POR: VanityToPOR,
  NumeralWordsLanguage.SWE: VanityToSWE,
  NumeralWordsLanguage.RUS: VanityToRUS,
  NumeralWordsLanguage.VOL: VanityToVOL,
  NumeralWordsLanguage.EPO: VanityToEPO,
  NumeralWordsLanguage.SOL: VanityToSOL,
  NumeralWordsLanguage.LAT: VanityToLAT
};

Map<NumeralWordsLanguage, String> VANITYWORDS_LANGUAGES = {
  NumeralWordsLanguage.DEU: 'common_language_german',
  NumeralWordsLanguage.ENG: 'common_language_english',
  NumeralWordsLanguage.FRA: 'common_language_french',
  NumeralWordsLanguage.ITA: 'common_language_italian',
  NumeralWordsLanguage.DNK: 'common_language_danish',
  NumeralWordsLanguage.ESP: 'common_language_spanish',
  NumeralWordsLanguage.NLD: 'common_language_dutch',
  NumeralWordsLanguage.NOR: 'common_language_norwegian',
  NumeralWordsLanguage.POL: 'common_language_polish',
  NumeralWordsLanguage.POR: 'common_language_portuguese',
  NumeralWordsLanguage.SWE: 'common_language_swedish',
  NumeralWordsLanguage.RUS: 'common_language_russian',
  NumeralWordsLanguage.VOL: 'common_language_volapuek',
  NumeralWordsLanguage.EPO: 'common_language_esperanto',
  NumeralWordsLanguage.SOL: 'common_language_solresol',
  NumeralWordsLanguage.LAT: 'common_language_latin'
};

const DEFAULT_NUMBER_FOR_SPACE = '1';

List<NumeralWordsDecodeOutput> decodeVanityWords(String text, NumeralWordsLanguage language){
  List<NumeralWordsDecodeOutput> output = new List<NumeralWordsDecodeOutput>();
  if (text == null || text == '') {
    output.add(NumeralWordsDecodeOutput('', '', 'numeralwords_language_empty'));
    return output;
  }

  // build map to identify numeral words
  Map searchLanguages = new Map();
    Map sValue = new Map();
    VanWords[language].forEach((key, value) {
      sValue[removeAccents(key)] = value;
    });
    searchLanguages[language] = sValue;

  // start decoding text with searchlanguages
  bool found = false;
  var decodingTable;
  text = text.replaceAll(' ', '');
  while (text.length > 0) {
    searchLanguages.forEach((key, value) {
      decodingTable = value;
      decodingTable.forEach((digits, word) {
        if (!found)
          if (text.startsWith(digits)) {
            output.add(NumeralWordsDecodeOutput(digits, word, NumWords[key][word.toString().toLowerCase()]));
            found = true;
            text = text.substring(digits.length - 1);
          }
      });
    });
    if (!found) output.add(NumeralWordsDecodeOutput('?', '', ''));
    found = false;

    if (text.length > 0) text = text.substring(1);
    //
  }
  return output;
}

String encryptVanitySingleNumbers(String input, {numberForSpace: DEFAULT_NUMBER_FOR_SPACE}) {
  return _encodeVanityMultipleNumbers(input, numberForSpace: numberForSpace).map((code) => code[0]).join();
}

_encodeVanityMultipleNumbers(String input, {numberForSpace: DEFAULT_NUMBER_FOR_SPACE}) {
  if (input == null || input == '') return [];

  input = removeDiacritics(input).toUpperCase();

  return input.split('').map((character) {
    if (character == ' ' && numberForSpace != null && numberForSpace.length > 0) return numberForSpace;

    var code = AZToVanity[character];
    if (code == null) return character;

    return code;
  }).toList();
}

String encodeVanityMultipleNumbers(String input, {numberForSpace: DEFAULT_NUMBER_FOR_SPACE}) {
  return _encodeVanityMultipleNumbers(input, numberForSpace: numberForSpace).join(' ');
}

String decodeVanityMultipleNumbers(List<int> input) {
  if (input == null) return '';

  return input.map((code) {
    var character = VanityToAZ[code.toString()];

    if (character == null) return UNKNOWN_ELEMENT;

    return character;
  }).join();
}
