// https://archive.org/details/earlyhistoryofda0000holz/page/180/mode/2up
// https://trepo.tuni.fi/bitstream/handle/10024/102557/1513599679.pdf?sequence=1&isAllowed=y
// https://en.wikipedia.org/wiki/Telegraph_code#Edelcrantz_code

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final CODEBOOK = {
  '000' : ' ',
  '001' : '1',
  '002' : '2',
  '003' : 'A',
  '004' : '3',
  '005' : 'ab',
  '006' : 'ad',
  '007' : '<ORDFLUT>',
  '010' : '4',
  '011' : 'af',
  '012' : 'ak',
  '013' : 'al',
  '014' : 'alt',
  '015' : 'am',
  '016' : 'an',
  '017' : 'and',
  '020' : '5',
  '021' : 'ap',
  '022' : 'ar',
  '023' : 'arm',
  '024' : 'as',
  '025' : 'at',
  '026' : 'B',
  '027' : 'ba',
  '030' : 'bak',
  '031' : 'bar',
  '032' : 'be',
  '033' : 'beg',
  '034' : 'berg',
  '035' : 'bi',
  '036' : 'bl',
  '037' : 'bland',
  '040' : '6',
  '041' : 'bo',
  '042' : 'bon',
  '043' : 'bor',
  '044' : 'br',
  '045' : 'bref',
  '046' : 'bu',
  '047' : 'by',
  '050' : 'bå',
  '051' : 'bart',
  '052' : 'bä',
  '053' : 'bö',
  '054' : 'bör',
  '055' : 'D',
  '056' : 'da',
  '057' : 'dag',
  '060' : 'dan',
  '061' : 'danfk',
  '062' : 'de',
  '063' : 'del',
  '064' : 'dem',
  '065' : 'den',
  '066' : 'der',
  '067' : 'det',
  '070' : '.',
  '071' : 'di',
  '072' : 'dig',
  '073' : 'din',
  '074' : 'dit',
  '075' : 'do',
  '076' : 'dom',
  '077' : '<FORT>',
  '100' : '7',
  '101' : 'dr',
  '102' : 'dt',
  '103' : 'du',
  '104' : 'dy',
  '105' : 'då',
  '106' : 'dä',
  '107' : 'där',
  '110' : 'dö',
  '111' : 'död',
  '112' : 'E',
  '113' : 'ed',
  '114' : 'efter',
  '115' : 'el',
  '116' : 'eller',
  '117' : 'eld',
  '120' : 'em',
  '121' : 'en',
  '122' : 'er',
  '123' : 'es',
  '124' : 'et',
  '125' : 'F',
  '126' : 'fn',
  '127' : 'fal',
  '130' : 'faller',
  '131' : 'fan',
  '132' : 'far',
  '133' : 'fat',
  '134' : 'fe',
  '135' : 'fel',
  '136' : 'fi',
  '137' : 'fienden',
  '140' : 'fin',
  '141' : 'fi',
  '142' : 'flagg',
  '143' : 'fo',
  '144' : 'folk',
  '145' : 'for',
  '146' : 'fr',
  '147' : 'fram',
  '150' : 'frå',
  '151' : 'ft',
  '152' : 'full',
  '153' : 'fy',
  '154' : 'få',
  '155' : 'får',
  '156' : 'fä',
  '157' : 'fält',
  '160' : 'fö',
  '161' : 'för',
  '162' : 'G',
  '163' : 'ga',
  '164' : 'gar',
  '165' : 'ge',
  '166' : 'gen',
  '167' : 'ger',
  '170' : 'gi',
  '171' : 'gl',
  '172' : 'gn',
  '173' : 'go',
  '174' : 'god',
  '175' : 'gr',
  '176' : 'gra',
  '177' : 'gt',
  '200' : '8',
  '201' : 'gu',
  '202' : 'gul',
  '203' : 'gå',
  '204' : 'går',
  '205' : 'gä',
  '206' : 'gö',
  '207' : 'gör',
  '210' : 'H',
  '211' : 'ha',
  '212' : 'haf',
  '213' : 'hal',
  '214' : 'hamm',
  '215' : 'han',
  '216' : 'hand',
  '217' : 'har',
  '220' : 'he',
  '221' : 'hel',
  '222' : '<HJELP>',
  '223' : 'hem',
  '224' : 'her',
  '225' : 'het',
  '226' : 'hi',
  '227' : '<TAL.UP.>',
  '230' : 'hin',
  '231' : 'hit',
  '232' : 'ho',
  '233' : 'hop',
  '234' : 'hos',
  '235' : 'hu',
  '236' : 'hundra',
  '237' : 'hur',
  '240' : 'hus',
  '241' : 'hy',
  '242' : 'hå',
  '243' : 'hål',
  '244' : 'hår',
  '245' : 'hä',
  '246' : 'hän',
  '247' : 'här',
  '250' : 'hö',
  '251' : 'hög',
  '252' : 'höger',
  '253' : 'hör',
  '254' : 'I',
  '255' : 'ja',
  '256' : 'jag',
  '257' : 'if',
  '260' : 'ig',
  '261' : 'ik',
  '262' : 'il',
  '263' : 'illa',
  '264' : 'in',
  '265' : 'ing',
  '266' : 'intet',
  '267' : 'is',
  '270' : 'ju',
  '271' : 'jå',
  '272' : '<GALIT>',
  '273' : 'jåm',
  '274' : 'K',
  '275' : 'kk',
  '276' : 'ka',
  '277' : 'kal',
  '300' : 'kan',
  '301' : 'kar',
  '302' : 'ke',
  '303' : 'ki',
  '304' : 'kl',
  '305' : 'kla',
  '306' : 'kn',
  '307' : 'kna',
  '310' : 'ko',
  '311' : 'kom',
  '312' : 'kon',
  '313' : 'kor',
  '314' : 'kr',
  '315' : 'kra',
  '316' : 'ku',
  '317' : 'kv',
  '320' : 'kva',
  '321' : 'ky',
  '322' : 'kå',
  '323' : 'kä',
  '324' : 'kö',
  '325' : 'L',
  '326' : 'la',
  '327' : 'log',
  '330' : 'land',
  '331' : 'le',
  '332' : 'lek',
  '333' : 'lem',
  '334' : 'ler',
  '335' : 'let',
  '336' : 'li',
  '337' : 'lif',
  '340' : 'lig',
  '341' : 'lik',
  '342' : 'ljus',
  '343' : 'lo',
  '344' : 'lt',
  '345' : 'lu',
  '346' : 'ly',
  '347' : 'lå',
  '350' : 'låg',
  '351' : 'lång',
  '352' : 'lä',
  '353' : 'läg',
  '354' : 'läng',
  '355' : 'lär',
  '356' : 'lät',
  '357' : 'lö',
  '360' : 'lön',
  '361' : 'lös',
  '362' : 'M',
  '363' : 'ma',
  '364' : 'man',
  '365' : 'mat',
  '366' : 'me',
  '367' : 'med',
  '370' : 'mellan',
  '371' : 'mem',
  '372' : 'mer',
  '373' : 'mi',
  '374' : 'mig',
  '375' : 'mil',
  '376' : 'min',
  '377' : 'miss',
  '400' : '9',
  '401' : 'mit',
  '402' : 'mo',
  '403' : 'mor',
  '404' : 'mot',
  '405' : 'mt',
  '406' : 'mu',
  '407' : 'mur',
  '410' : 'my',
  '411' : '<MYCKE>',
  '412' : 'må',
  '413' : 'mål',
  '414' : 'mån',
  '415' : 'måt',
  '416' : 'mä',
  '417' : 'mär',
  '420' : 'mö',
  '421' : 'mör',
  '422' : 'N',
  '423' : 'na',
  '424' : 'namn',
  '425' : 'natt',
  '426' : 'nd',
  '427' : 'ne',
  '430' : 'nej',
  '431' : 'ner',
  '432' : 'ng',
  '433' : 'ni',
  '434' : 'nog',
  '435' : 'nor',
  '436' : 'na',
  '437' : 'nu',
  '440' : 'ny',
  '441' : 'nyfe',
  '442' : 'nå',
  '443' : 'nä',
  '444' : 'när',
  '445' : 'näft',
  '446' : 'nö',
  '447' : 'nöd',
  '450' : 'O',
  '451' : 'och',
  '452' : 'od',
  '453' : 'om',
  '454' : 'on',
  '455' : 'opp',
  '456' : 'or',
  '457' : 'ord',
  '460' : 'oss',
  '461' : 'ott',
  '462' : 'P',
  '463' : 'pa',
  '464' : 'par',
  '465' : 'pe',
  '466' : 'pen',
  '467' : 'per',
  '470' : 'pi',
  '471' : 'pl',
  '472' : 'po',
  '473' : 'por',
  '474' : 'post',
  '475' : 'pr',
  '476' : 'pu',
  '477' : 'på',
  '500' : 'R',
  '501' : 'ra',
  '502' : 'ran',
  '503' : 'rd',
  '504' : 're',
  '505' : 'regn',
  '506' : 'ren',
  '507' : 'ri',
  '510' : 'rikad',
  '511' : 'rin',
  '512' : 'ro',
  '513' : 'rt',
  '514' : 'ru',
  '515' : 'rum',
  '516' : 'ry',
  '517' : 'rym',
  '520' : 'rå',
  '521' : 'råd',
  '522' : 'rä',
  '523' : 'räk',
  '524' : 'rät',
  '525' : '<VÄNLE>',
  '526' : 'rö',
  '527' : 'rök',
  '530' : 'S',
  '531' : 'sa',
  '532' : 'sak',
  '533' : 'sal',
  '534' : 'sam',
  '535' : 'san',
  '536' : 'se',
  '537' : 'seg',
  '540' : 'sen',
  '541' : 'ser',
  '542' : 'sh',
  '543' : 'shiffer',
  '544' : 'sk',
  '545' : 'skall',
  '546' : 'skepp',
  '547' : 'skicka',
  '550' : 'skog',
  '551' : 'skrif',
  '552' : 'si',
  '553' : 'sig',
  '554' : 'sin',
  '555' : 'sit',
  '556' : 'sjä',
  '557' : '<UPM.UP>',
  '560' : 'sjön',
  '561' : 'sl',
  '562' : 'slut',
  '563' : 'sm',
  '564' : 'sn',
  '565' : 'so',
  '566' : 'sol',
  '567' : 'som',
  '570' : 'sor',
  '571' : 'sp',
  '572' : 'spr',
  '573' : 'st',
  '574' : 'stad',
  '575' : '',
  '576' : 'stor',
  '577' : 'str',
  '600' : 'sv',
  '601' : 'svar',
  '602' : 'svenik',
  '603' : 'sy',
  '604' : 'så',
  '605' : 'sä',
  '606' : 'sät',
  '607' : 'sö',
  '610' : 'T',
  '611' : 'ta',
  '612' : 'tan',
  '613' : 'te',
  '614' : 'telegr.',
  '615' : 'ten',
  '616' : 'ter',
  '617' : 'ti',
  '620' : 'tid',
  '621' : 'til',
  '622' : 'tim',
  '623' : 'tin',
  '624' : 'to',
  '625' : 'tor',
  '626' : 'tr',
  '627' : 'tu',
  '630' : 'tull',
  '631' : 'tusend',
  '632' : 'tv',
  '633' : 'ty',
  '634' : 'tyfk',
  '635' : 'tå',
  '636' : 'tä',
  '637' : 'tö',
  '640' : 'U',
  '641' : 'uk',
  '642' : 'ull',
  '643' : 'un',
  '644' : 'up',
  '645' : 'ur',
  '646' : 'un',
  '647' : 'ut',
  '650' : 'V',
  '651' : 'va',
  '652' : 'vad',
  '653' : 'vakt',
  '654' : 'vai',
  '655' : 'van',
  '656' : 'var',
  '657' : 'vat',
  '660' : 've',
  '661' : 'vem',
  '662' : 'ven',
  '663' : 'venster',
  '664' : 'ver',
  '665' : 'vi',
  '666' : 'vid',
  '667' : 'vig',
  '670' : 'vil',
  '671' : 'vin',
  '672' : 'vind',
  '673' : 'vit',
  '674' : 'vr',
  '675' : 'vu',
  '676' : 'vå',
  '677' : 'våld',
  '700' : '<TALFLUT>',
  '701' : 'vår',
  '702' : 'vä',
  '703' : 'väg',
  '704' : 'väl',
  '705' : 'väm',
  '706' : 'vär',
  '707' : '<REPETER>',
  '710' : 'X',
  '711' : 'Y',
  '712' : 'Z',
  '713' : 'Å',
  '714' : 'ål',
  '715' : 'ån',
  '716' : 'ång',
  '717' : 'år',
  '720' : 'åt',
  '721' : 'åter',
  '722' : '<TAL.MED.>',
  '723' : 'Ä',
  '724' : 'äkt',
  '725' : 'äg',
  '726' : 'äll',
  '727' : '<ÄNDRA>',
  '730' : 'äm',
  '731' : 'än',
  '732' : 'äng',
  '733' : 'änk',
  '734' : 'är',
  '735' : 'ät',
  '736' : 'ätt',
  '737' : 'Ö',
  '740' : 'öd',
  '741' : 'öf',
  '742' : 'öfver',
  '743' : 'ög',
  '744' : 'ögd',
  '745' : 'ök',
  '746' : 'öm',
  '747' : 'ör',
  '750' : 'öt',
  '751' : 'ött',
  '752' : '',
  '753' : '',
  '754' : '',
  '755' : '<UPM.NED>',
  '756' : '',
  '757' : '<SER >',
  '760' : '',
  '761' : '',
  '762' : '',
  '763' : '',
  '764' : '',
  '765' : '',
  '766' : '',
  '767' : '',
  '770' : '<LÄNGS.>',
  '771' : '',
  '772' : '',
  '773' : '',
  '774' : '',
  '775' : '',
  '776' : '',
  '777' : '',
  'A001': 'edelcrantz_a_messagereceived',
  'A002': 'edelcrantz_a_doyoucopy',
  'A004': 'edelcrantz_a_understood',
  'A005': 'edelcrantz_a_repeatmessage',
  'A007': 'edelcrantz_a_endcommunication',
};

List<List<String>> encodeEdelcrantz(String input) {
  if (input == null || input == '') return <List<String>>[];

  return input.split('').map((letter) {
    if (switchMapKeyValue(CODEBOOK)[letter] != null)
      return switchMapKeyValue(CODEBOOK)[letter].split('');
  }).toList();
}


Map<String, dynamic> decodeVisualEdelcrantz(List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };

  var displays = <List<String>>[];
  var segment = <String>[];
  String text = '';

  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
    if (CODEBOOK[segmentToCode(segment)] != null)
      text = text + CODEBOOK[segmentToCode(segment)];
    else
      text = text + UNKNOWN_ELEMENT;
  });

  return {'displays': displays, 'text': text};
}


Map<String, dynamic> decodeTextEdelcrantz(String inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };

  var displays = <List<String>>[];
  String text = '';

  inputs.split(' ').forEach((element) {
    if (CODEBOOK[element] != null) {
      text = text + CODEBOOK[element];
    } else {
      text = text + UNKNOWN_ELEMENT;
    }
    displays.add(_buildShutters(element));
  });
  return {'displays': displays, 'text': text};
}


List<String> _stringToSegment(String input){
  List<String> result = [];
  int j = 0;
  for (int i = 0; i < input.length /2; i++) {
    result.add(input[j] + input[j + 1]);
    j = j + 2;
  }
  return result;
}

String segmentToCode(List<String> segment){
  int a = 0;
  int b = 0;
  int c = 0;

  String A = '';

  if (segment.contains('a1')) a = a + 1;
  if (segment.contains('a2')) a = a + 2;
  if (segment.contains('a3')) a = a + 4;
  if (segment.contains('b1')) b = b + 1;
  if (segment.contains('b2')) b = b + 2;
  if (segment.contains('b3')) b = b + 4;
  if (segment.contains('c1')) c = c + 1;
  if (segment.contains('c2')) c = c + 2;
  if (segment.contains('c3')) c = c + 4;
  if (segment.contains('t0'))
    return 'A' + a.toString() + b.toString() + c.toString();
  else
    return a.toString() + b.toString() + c.toString();
}


List<String> _buildShutters(String segments){
  List<String> resultElement = [];
  bool A = false;
  if (segments.length == 4 && segments.startsWith('A')) {
    A = true;
    segments = segments.substring(1);
    resultElement = ['t0'];
  }
  if (segments.length == 3) {
    switch (segments[0]) {
      case '1' :
        resultElement.addAll(['a1']);
        break;
      case '2' :
        resultElement.addAll(['a2']);
        break;
      case '3' :
        resultElement.addAll(['a1', 'a2']);
        break;
      case '4' :
        resultElement.addAll(['a3']);
        break;
      case '5' :
        resultElement.addAll(['a3', 'a1']);
        break;
      case '6' :
        resultElement.addAll(['a3', 'a2']);
        break;
      case '7' :
        resultElement.addAll(['a3', 'a2', 'a1']);
        break;
    }
    switch (segments[1]) {
      case '1' :
        resultElement.addAll(['b1']);
        break;
      case '2' :
        resultElement.addAll(['b2']);
        break;
      case '3' :
        resultElement.addAll(['b1', 'b2']);
        break;
      case '4' :
        resultElement.addAll(['b3']);
        break;
      case '5' :
        resultElement.addAll(['b3', 'b1']);
        break;
      case '6' :
        resultElement.addAll(['b3', 'b2']);
        break;
      case '7' :
        resultElement.addAll(['b3', 'b2', 'b1']);
        break;
    }
    switch (segments[2]) {
      case '1' :
        resultElement.addAll(['c1']);
        break;
      case '2' :
        resultElement.addAll(['c2']);
        break;
      case '3' :
        resultElement.addAll(['c1', 'c2']);
        break;
      case '4' :
        resultElement.addAll(['c3']);
        break;
      case '5' :
        resultElement.addAll(['c3', 'c1']);
        break;
      case '6' :
        resultElement.addAll(['c3', 'c2']);
        break;
      case '7' :
        resultElement.addAll(['c3', 'c2', 'c1']);
        break;
    }
  }
  return resultElement;
}
