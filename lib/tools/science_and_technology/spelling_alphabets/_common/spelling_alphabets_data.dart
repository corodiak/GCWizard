// https://en.wikipedia.org/wiki/Spelling_alphabet
// https://en.wikipedia.org/wiki/Allied_military_phonetic_spelling_alphabets
// https://en.wikipedia.org/wiki/NATO_phonetic_alphabet
// https://jumk.de/alphabete/polnisch.shtml
// https://en.wikipedia.org/wiki/Russian_spelling_alphabet
// https://en.wikipedia.org/wiki/Greek_spelling_alphabet

import 'dart:ui';

enum SPELLING {
  ICAO1947,
  NATO,
  USNAVY1908_1,
  USNAVY1908_2,
  USNAVY1920,
  USNAVY1942,
  APCO1967,
  APCO1974,
  ARRL1930,
  ARRL1936,
  ARRL1946,
  ARRL1970,
  ARRLDX,
  EPO,
  FRA,
  FRABEL,
  CHE,
  FRACAN,
  DEU1950,
  DEU2022,
  DEUDDR,
  AUT,
  NLD,
  BEL,
  ITA,
  ESP,
  BRA,
  POR,
  SWE,
  DNK,
  NOR,
  FIN,
  TUR,
  ROU,
  CZE,
  YUG,
  SRB,
  SLO,
  POL,
  SVK,
  RUS,
  RUSLAT,
  GRC,
  GRCLAT,
}

Map<SPELLING, String> SPELLING_LIST = {
  SPELLING.ICAO1947: "spelling_alphabets_language_ICAO1947",
  SPELLING.NATO: "spelling_alphabets_language_nato",
  SPELLING.USNAVY1908_1: "spelling_alphabets_language_usnavy_1908_1",
  SPELLING.USNAVY1908_2: "spelling_alphabets_language_usnavy_1908_2",
  SPELLING.USNAVY1920: "spelling_alphabets_language_usnavy_1920",
  SPELLING.USNAVY1942: "spelling_alphabets_language_usnavy_1942",
  SPELLING.APCO1967: "spelling_alphabets_language_APCO1967",
  SPELLING.APCO1974: "spelling_alphabets_language_APCO1974",
  SPELLING.ARRL1930: "spelling_alphabets_language_ARRL1930",
  SPELLING.ARRL1936: "spelling_alphabets_language_ARRL1936",
  SPELLING.ARRL1946: "spelling_alphabets_language_ARRL1946",
  SPELLING.ARRL1970: "spelling_alphabets_language_ARRL1970",
  SPELLING.ARRLDX: "spelling_alphabets_language_ARRLDX",
  SPELLING.FRA: "common_country_France",
  SPELLING.FRABEL: "common_country_Belgium",
  SPELLING.CHE: "common_country_Switzerland",
  SPELLING.FRACAN: "spelling_alphabets_language_quebec",
  SPELLING.DEU1950: "spelling_alphabets_language_deu1950",
  SPELLING.DEU2022: "spelling_alphabets_language_deu2022",
  SPELLING.AUT: "common_country_Austria",
  SPELLING.DEUDDR: "spelling_alphabets_language_gdr",
  SPELLING.NLD: "common_country_Netherlands",
  SPELLING.EPO: "spelling_alphabets_language_esperanto",
  SPELLING.BEL: "spelling_alphabets_language_belflemish",
  SPELLING.ITA: "common_country_Italy",
  SPELLING.ESP: "common_country_Spain",
  SPELLING.BRA: "common_country_Brazil",
  SPELLING.POR: "common_country_Portugal",
  SPELLING.SWE: "common_country_Sweden",
  SPELLING.DNK: "common_country_Denmark",
  SPELLING.NOR: "common_country_Norway",
  SPELLING.FIN: "common_country_Finland",
  SPELLING.TUR: "common_country_Turkey",
  SPELLING.ROU: "common_country_Romania",
  SPELLING.CZE: "common_country_CzechRepublic",
  SPELLING.YUG: "spelling_alphabets_language_yug",
  SPELLING.SRB: "common_country_Serbia",
  SPELLING.SLO: "common_country_Slovenia",
  SPELLING.POL: "common_country_Poland",
  SPELLING.RUS: "common_country_Russia",
  SPELLING.RUSLAT: "spelling_alphabets_language_ruslat",
  SPELLING.GRC: "common_country_Greece",
  SPELLING.GRCLAT: "spelling_alphabets_language_grclat",
};

Map<String, String> _spellingARRL1930 = {
  "A": "Adams",
  "B": "Boston",
  "C": "Chicago",
  "D": "Denver",
  "E": "Edward",
  "F": "Frank",
  "G": "George",
  "H": "Henry",
  "I": "Ida",
  "J": "John",
  "K": "King",
  "L": "Lincoln",
  "M": "Mary",
  "N": "New York",
  "O": "Ocean",
  "P": "Peter",
  "Q": "Queen",
  "R": "Robert",
  "S": "Sugar",
  "T": "Thomas",
  "U": "Union",
  "V": "Victor",
  "W": "William",
  "X": "X-Ray",
  "Y": "Young",
  "Z": "Zero",
};
Map<String, String> _spellingARRL1936 = {
  "A": "Able",
  "B": "Boy",
  "C": "Cast",
  "D": "Dog",
  "E": "Easy",
  "F": "Fox",
  "G": "George",
  "H": "Have",
  "I": "Item",
  "J": "Jig",
  "K": "King",
  "L": "Love",
  "M": "Mike",
  "N": "Nan",
  "O": "Oboe",
  "P": "Pup",
  "Q": "Quack",
  "R": "Rot",
  "S": "Sail",
  "T": "Tare",
  "U": "Unit",
  "V": "Vice",
  "W": "Watch",
  "X": "X-ray",
  "Y": "Yoke",
  "Z": "Zed",
};
Map<String, String> _spellingARRL1946 = {
  "A": "ADAM",
  "B": "BAKER",
  "C": "CHARLIE",
  "D": "DAVID",
  "E": "EDWARD",
  "F": "FRANK",
  "G": "GEORGE",
  "H": "HENRY",
  "I": "IDA",
  "J": "JOHN",
  "K": "KING",
  "L": "LEWIS",
  "M": "MARY",
  "N": "NANCY",
  "O": "OTTO",
  "P": "PETER",
  "Q": "QUEEN",
  "R": "ROBERT",
  "S": "SUSAN",
  "T": "THOMAS",
  "U": "UNION",
  "V": "VICTOR",
  "W": "WILLIAM",
  "X": "X-RAY",
  "Y": "YOUNG",
  "Z": "ZEBRA",
};
Map<String, String> _spellingARRLDX = {
  "A": "America",
  "B": "Boston",
  "C": "Canada",
  "D": "Denmark",
  "E": "England",
  "F": "France",
  "G": "Germany",
  "H": "Honolulu",
  "I": "Italy",
  "J": "Japan",
  "K": "Kilowatt",
  "L": "London",
  "M": "Mexico",
  "N": "Norway",
  "O": "Ontario",
  "P": "Pacific",
  "Q": "Quebec",
  "R": "Radio",
  "S": "Santiago",
  "T": "Tokyo",
  "U": "United",
  "V": "Victoria",
  "W": "Washington",
  "X": "X-Ray",
  "Y": "Yokohama",
  "Z": "Zanzibar",
};
Map<String, String> _spellingUSNAVY1908_1 = {
  "A": "Actor",
  "B": "Baker",
  "C": "Canteen",
  "D": "Diver",
  "E": "Eagle",
  "F": "Fisher",
  "G": "Gangway",
  "H": "Halliard",
  "I": "Insect",
  "J": "Jockey",
  "K": "Knapsack",
  "L": "Lugger",
  "M": "Musket",
  "N": "Neptune",
  "O": "Oyster",
  "P": "Pistol",
  "Q": "Quadrant",
  "R": "Reefer",
  "S": "Shipmate",
  "T": "Topsail",
  "U": "Unload",
  "V": "Vessel",
  "W": "Windage",
  "X": "X-Ray",
  "Y": "Yeoman",
  "Z": "Zebra",
};
Map<String, String> _spellingUSNAVY1908_2 = {
  "A": "Ash",
  "B": "Back",
  "C": "Chain",
  "D": "Dog",
  "E": "Egg",
  "F": "Fox",
  "G": "Gig",
  "H": "Horse",
  "I": "Ice",
  "J": "Jake",
  "K": "King",
  "L": "Lash",
  "M": "Mule",
  "N": "Net",
  "O": "Oak",
  "P": "Page",
  "Q": "Quail",
  "R": "Raft",
  "S": "Scout",
  "T": "Tide",
  "U": "Use",
  "V": "Vast",
  "W": "Winch",
  "X": "X-Ray",
  "Y": "Yacht",
  "Z": "Zoo",
};
Map<String, String> _spellingUSNAVY1920 = {
  "A": "Argentine",
  "B": "Brussels",
  "C": "Canada",
  "D": "Damascus",
  "E": "Ecuador",
  "F": "France",
  "G": "Greece",
  "H": "Hanover",
  "I": "Italy",
  "J": "Japan",
  "K": "Khartoum",
  "L": "Lima",
  "M": "Madrid",
  "N": "Nancy",
  "O": "Ostend",
  "P": "Paris",
  "Q": "Quebec",
  "R": "Rome",
  "S": "Sardinia",
  "T": "Tokio",
  "U": "Uruguay",
  "V": "Victoria",
  "W": "Washington",
  "X": "Xaintrie",
  "Y": "Yokohama",
  "Z": "Zanzibar",
};
Map<String, String> _spellingUSNAVY1942 = {
  "A": "Afirm",
  "B": "Baker",
  "C": "Cast",
  "D": "Dog",
  "E": "Easy",
  "F": "Fox",
  "G": "George",
  "H": "Hypo",
  "I": "Int",
  "J": "Jig",
  "K": "King",
  "L": "Love",
  "M": "Mike",
  "N": "Negat",
  "O": "Option",
  "P": "Prep",
  "Q": "Queen",
  "R": "Roger",
  "S": "Sail",
  "T": "Tare",
  "U": "Unit",
  "V": "Victor",
  "W": "William",
  "X": "X-Ray",
  "Y": "Yoke",
  "Z": "Zed",
};
Map<String, String> _spellingICAO1947 = {
  "A": "Able",
  "B": "Baker",
  "C": "Charlie",
  "D": "Dog",
  "E": "Easy",
  "F": "Fox",
  "G": "George",
  "H": "How",
  "I": "Item",
  "J": "Jig",
  "K": "King",
  "L": "Love",
  "M": "Mike",
  "N": "Nan",
  "O": "Oboe",
  "P": "Peter",
  "Q": "Queen",
  "R": "Roger",
  "S": "Sugar",
  "T": "Tare",
  "U": "Uncle",
  "V": "Victor",
  "W": "William",
  "X": "X-Ray",
  "Y": "Yoke",
  "Z": "Zebra"
};
Map<String, String> _spellingAPCO1967 = {
  "A": "Adam",
  "B": "Boy",
  "C": "Charles",
  "D": "David",
  "E": "Edward",
  "F": "Frank",
  "G": "George",
  "H": "Henry",
  "I": "Ida",
  "J": "John",
  "K": "King",
  "L": "Lincoln",
  "M": "Mary",
  "N": "Nora",
  "O": "Ocean",
  "P": "Paul",
  "Q": "Queen",
  "R": "Robert",
  "S": "Sam",
  "T": "Tom",
  "U": "Union",
  "V": "Victor",
  "W": "William",
  "X": "X-Ray",
  "Y": "Young",
  "Z": "Zebra"
};
Map<String, String> _spellingNATO = {
  "A": "Alpha",
  "B": "Bravo",
  "C": "Charlie",
  "D": "Delta",
  "E": "Echo",
  "F": "Foxtrot",
  "G": "Golf",
  "H": "Hotel",
  "I": "India",
  "J": "Juliet",
  "K": "Kilo",
  "L": "Lima",
  "M": "Mike",
  "N": "November",
  "O": "Oscar",
  "P": "Papa",
  "Q": "Quebec",
  "R": "Romeo",
  "S": "Sierra",
  "T": "Tango",
  "U": "Uniform",
  "V": "Victor",
  "W": "Whiskey",
  "X": "X-ray",
  "Y": "Yankee",
  "Z": "Zulu"
};
Map<String, String> _spellingFRA = {
  "A": "Anatole",
  "B": "Berthe",
  "C": "Célestin",
  "D": "Désiré",
  "E": "Eugène",
  "F": "François",
  "G": "Gaston",
  "H": "Henri",
  "I": "Irma",
  "J": "Joseph",
  "K": "Kléber",
  "L": "Louis",
  "M": "Marcel",
  "N": "Nicolas",
  "O": "Oscar",
  "P": "Pierre",
  "Q": "Quintal",
  "R": "Raoul",
  "S": "Suzanne",
  "T": "Thérèse",
  "U": "Ursule",
  "V": "Victor",
  "W": "William",
  "X": "Xavier",
  "Y": "Yvonne",
  "Z": "Zoé"
};
Map<String, String> _spellingFRABEL = {
  "A": "Arthur",
  "B": "Bruxelles",
  "C": "César",
  "D": "David",
  "E": "Émile",
  "F": "Frédéric",
  "G": "Gustave",
  "H": "Henri",
  "I": "Isidor",
  "J": "Joseph",
  "K": "Kilogramme",
  "L": "Léopold",
  "M": "Marie",
  "N": "Napoléon",
  "O": "Oscar",
  "P": "Piano",
  "Q": "Quiévrain",
  "R": "Robert",
  "S": "Simon",
  "T": "Téléphone",
  "U": "Ursule",
  "V": "",
  "W": "Waterloo",
  "X": "Xantippe",
  "Y": "",
  "Z": "Zéro"
};
Map<String, String> _spellingFRACAN = {
  "A": "Alice",
  "B": "Berthe",
  "C": "Charles",
  "D": "David",
  "E": "Édouard",
  "F": "François",
  "G": "George",
  "H": "Henri",
  "I": "Isabelle",
  "J": "Jacques",
  "K": "Kilo",
  "L": "Louis",
  "M": "Marie",
  "N": "Nicolas",
  "O": "Olivier",
  "P": "Pierre",
  "Q": "Québec",
  "R": "Robert",
  "S": "Samuel",
  "T": "Thomas",
  "U": "Ursule",
  "V": "",
  "W": "William",
  "X": "Xavier",
  "Y": "",
  "Z": "Zoé"
};
Map<String, String> _spellingCHE = {
  "A": "Anna",
  "B": "Berthe",
  "C": "Cécile",
  "D": "Daniel",
  "E": "Émile",
  "F": "François",
  "G": "Gustave",
  "H": "Henri",
  "I": "Ida",
  "J": "Jeanne",
  "K": "Kilo",
  "L": "Louise",
  "M": "Marie",
  "N": "Nicolas",
  "O": "Olga",
  "P": "Paul",
  "Q": "Quittance",
  "R": "Robert",
  "S": "Suzanne",
  "T": "Thérèse",
  "U": "Ulysse",
  "V": "",
  "W": "William",
  "X": "Xavier",
  "Y": "",
  "Z": "Zurich"
};
Map<String, String> _spellingDEU1950 = {
  "A": "Anton",
  "Ä": "Ärger",
  "B": "Berta",
  "C": "Cäsar",
  "CH": "Charlotte",
  "D": "Dora",
  "E": "Emil",
  "F": "Friedrich",
  "G": "Gustav",
  "H": "Heinrich",
  "I": "Ida",
  "J": "Julius",
  "K": "Kaufmann",
  "L": "Ludwig",
  "M": "Martha",
  "N": "Nordpol",
  "O": "Otto",
  "Ö": "Ökonom",
  "P": "Paula",
  "Q": "Quelle",
  "R": "Richard",
  "S": "Samuel",
  "T": "Theodor",
  "U": "Ulrich",
  "Ü": "Übermut",
  "V": "Viktor",
  "W": "Wilhelm",
  "X": "Xanthippe",
  "Y": "Ypsilon",
  "Z": "Zacharias"
};
Map<String, String> _spellingDEU2022 = {
  "A": "Aachen",
  "B": "Berlin",
  "C": "Chemnitz",
  "D": "Düsseldorf",
  "E": "Essen",
  "F": "Frankfurt",
  "G": "Goslar",
  "H": "Hamburg",
  "I": "Ingelheim",
  "J": "Jena",
  "K": "Köln",
  "L": "Leipzig",
  "M": "München",
  "N": "Nürnberg",
  "O": "Offenbach",
  "P": "Potsdam",
  "Q": "Quickborn",
  "R": "Rostock",
  "S": "Salzwedel",
  "T": "Tübingen",
  "U": "Unna",
  "V": "Völklingen",
  "W": "Wuppertal",
  "X": "Xanten",
  "Y": "Ypsilon",
  "Z": "Zwickau"
};
Map<String, String> _spellingAUT = {
  "A": "Anton",
  "Ä": "Ärger",
  "B": "Berta",
  "C": "Cäsar",
  "CH": "Charlotte",
  "D": "Dora",
  "E": "Emil",
  "F": "Friedrich",
  "G": "Gustav",
  "H": "Heinrich",
  "I": "Ida",
  "J": "Julius",
  "K": "Konrad",
  "L": "Ludwig",
  "M": "Martha",
  "N": "Nordpol",
  "O": "Otto",
  "Ö": "Österreich",
  "P": "Paula",
  "Q": "Quelle",
  "R": "Richard",
  "S": "Siegfried",
  "T": "Theodor",
  "U": "Ulrich",
  "Ü": "Übel",
  "V": "Viktor",
  "W": "Wilhelm",
  "X": "Xaver",
  "Y": "Ypsilon",
  "Z": "Zürich"
};
Map<String, String> _spellingEPO = {
  "A": "Asfalto",
  "B": "Barbaro",
  "C": "Centimetro",
  "CH": "Charlotte",
  "D": "Doktoro",
  "E": "Elemento",
  "F": "Fabriko",
  "G": "Gumo",
  "H": "Hotelo",
  "I": "Insekto",
  "J": "Jubileo",
  "K": "Kilogramo",
  "L": "Legendo",
  "M": "Maŝino",
  "N": "Naturo",
  "O": "Omnibuso",
  "P": "Papero",
  "Q": "Kuo",
  "R": "Rekordo",
  "S": "Salato",
  "T": "Triumfo",
  "U": "Universo",
  "V": "Vulkano",
  "W": "Vo",
  "X": "Ikso",
  "Y": "Ipsilono",
  "Z": "Zinko"
};
Map<String, String> _spellingNLD = {
  //http://www.spellingsalfabet.nl/
  "A": "Anna",
  "B": "Bernhard",
  "C": "Cornelis",
  "D": "Dirk",
  "E": "Eduard",
  "F": "Ferdinand",
  "G": "Gerard",
  "H": "Hendrik",
  "I": "Izaak",
  "IJ": "IJmuiden",
  "J": "Jan",
  "K": "Karel",
  "L": "Lodewijk",
  "M": "Maria",
  "N": "Nico",
  "O": "Otto",
  "P": "Pieter",
  "Q": "Qutient",
  "R": "Rudolf",
  "S": "Simon",
  "T": "Teunis",
  "U": "Utrecht",
  "V": "Victor",
  "W": "Willem",
  "X": "Xantippe",
  "Y": "Ypsilon",
  "Z": "Zaandam",
  "IJ": "IJmuiden",
};
Map<String, String> _spellingBEL = {
  "A": "Arthur",
  "B": "Brussel",
  "C": "Carolina",
  "D": "Desiré",
  "E": "Emiel",
  "F": "Frederik",
  "G": "Gustaaf",
  "H": "Hendrik",
  "I": "Isidoor",
  "J": "Jozef",
  "K": "Kilogram",
  "L": "Leopold",
  "M": "Maria",
  "N": "Napoleon",
  "O": "Oscar",
  "P": "Piano",
  "Q": "Quotiënt",
  "R": "Robert",
  "S": "Sofie",
  "T": "Telefoon",
  "U": "Ursula",
  "V": "Victor",
  "W": "Waterloo",
  "X": "Xavier",
  "Y": "Yvonne",
  "Z": "Zola"
};
Map<String, String> _spellingITA = {
  "A": "Ancona",
  "B": "Bologna",
  "C": "Como",
  "D": "Domodossola",
  "E": "Empoli",
  "F": "Firenze",
  "G": "Genova",
  "H": "Hotel",
  "I": "Imola",
  "J": "Jolly, Juventus",
  "K": "Kappa,Kiwi",
  "L": "Livorno",
  "M": "Milano",
  "N": "Napoli",
  "O": "Otranto",
  "P": "Padova",
  "Q": "Quadro",
  "R": "Roma",
  "S": "Savona",
  "T": "Torino",
  "U": "Udine",
  "V": "Verona, Venezia",
  "W": "Whiskey, Washington",
  "X": "Ics,Xilofono",
  "Y": "York, yogurt",
  "Z": "Zara, Zorro"
};
Map<String, String> _spellingESP = {
  "A": "Antonio",
  "B": "Burgos",
  "C": "Carmen",
  "CH": "Chocolate",
  "D": "David",
  "E": "España",
  "F": "Francia",
  "G": "Granada",
  "H": "Historia",
  "I": "Inés",
  "J": "José",
  "K": "Kilo",
  "L": "Lorenzo",
  "M": "Madrid",
  "N": "Navidad",
  "O": "Oviedo",
  "P": "París",
  "Q": "Queso",
  "R": "Ramón",
  "S": "Sábado",
  "T": "Toledo",
  "U": "Ulises",
  "V": "Valencia",
  "W": "Washington",
  "X": "Xilófono",
  "Y": "Yolanda",
  "Z": "Zaragoza"
};
Map<String, String> _spellingPOR = {
  "A": "Aveiro",
  "B": "Braga",
  "C": "Coimbra",
  "D": "Dafundo",
  "E": "Évora",
  "F": "Faro",
  "G": "Guarda",
  "H": "Horta",
  "I": "Itália",
  "J": "José",
  "K": "Kodak",
  "L": "Lisboa",
  "M": "Maria",
  "N": "Nazaré",
  "O": "Ovar",
  "P": "Porto",
  "Q": "Queluz",
  "R": "Rossio",
  "S": "Setúbal",
  "T": "Tavira",
  "U": "Unidade",
  "V": "Vidago",
  "W": "Waldemar",
  "X": "Xavier",
  "Y": "York",
  "Z": "Zulmira"
};
Map<String, String> _spellingBRA = {
  "A": "Amor",
  "B": "Bandeira",
  "C": "Cobra",
  "D": "Dado",
  "E": "Estrela",
  "F": "Feira",
  "G": "Goiaba",
  "H": "Hotel",
  "I": "Índio",
  "J": "José",
  "K": "Kiwi",
  "L": "Lua",
  "M": "Maria",
  "N": "Navio",
  "O": "Ouro",
  "P": "Pipa",
  "Q": "Quilombo",
  "R": "Raiz",
  "S": "Saci",
  "T": "Tatu",
  "U": "Uva",
  "V": "Vitória",
  "W": "Wilson",
  "X": "Xadrez",
  "Y": "Yolanda",
  "Z": "Zebra"
};
Map<String, String> _spellingDNK = {
  "A": "Anna",
  "Æ": "Ægir",
  "B": "Bernhard",
  "C": "Cecilie",
  "D": "David",
  "E": "Erik",
  "F": "Frederik",
  "G": "Georg",
  "H": "Hans",
  "I": "Ida",
  "J": "Johan",
  "K": "Karen",
  "L": "Ludvig",
  "M": "Mari",
  "N": "Nikolaj",
  "O": "Odin",
  "Ø": "Øresund",
  "P": "Peter",
  "Q": "Quintus",
  "R": "Rasmus",
  "S": "Søren",
  "T": "Theodor",
  "U": "Ulla",
  "V": "Viggo",
  "W": "William",
  "X": "Xerxes",
  "Y": "Yrsa",
  "Z": "Zackarias"
};
Map<String, String> _spellingNOR = {
  "A": "Anna",
  "Æ": "Ærlig",
  "B": "Bernhard",
  "C": "Caesar",
  "D": "David",
  "E": "Edith",
  "F": "Fredrik",
  "G": "Gustav",
  "H": "Harald",
  "I": "Ivar",
  "J": "Johan",
  "K": "Karin",
  "L": "Ludvig",
  "M": "Martin",
  "N": "Nils",
  "O": "Olivia",
  "Ø": "Østen",
  "P": "Petter",
  "Q": "Quintus",
  "R": "Rikard",
  "S": "Sigrid",
  "T": "Teodor",
  "U": "Ulrik",
  "V": "Enkelt-V",
  "W": "Dobbelt-W",
  "X": "Xerxes",
  "Y": "Yngling",
  "Z": "Zakarias"
};
Map<String, String> _spellingSWE = {
  "A": "Adam",
  "B": "Bertil",
  "C": "Caesar",
  "D": "David",
  "E": "Erik",
  "F": "Filip",
  "G": "Gustav",
  "H": "Helge",
  "I": "Ivar",
  "J": "Johan",
  "K": "Kalle",
  "L": "Ludvig",
  "M": "Martin",
  "N": "Niklas",
  "O": "Olof",
  "Ö": "Östen",
  "P": "Petter",
  "Q": "Quintus",
  "R": "Rudolf",
  "S": "Sigurd",
  "T": "Tore",
  "U": "Urban",
  "V": "Viktor",
  "W": "Wilhelm",
  "X": "Xerxes",
  "Y": "Yngve",
  "Z": "Zäta"
};
Map<String, String> _spellingFIN = {
  "A": "Aarne",
  "B": "Bertta",
  "C": "Celsius",
  "D": "Daavid",
  "E": "Eemeli",
  "F": "Faarao",
  "G": "Gideon",
  "H": "Heikki",
  "I": "Iivari",
  "J": "Jussi",
  "K": "Kalle",
  "L": "Lauri",
  "M": "Matti",
  "N": "Niilo",
  "O": "Otto",
  "Ö": "Öljy",
  "P": "Paavo",
  "Q": "Kuu",
  "R": "Risto",
  "S": "Sakari",
  "T": "Tyyne",
  "U": "Urho",
  "V": "Vihtori",
  "W": "Wiski",
  "X": "Äksä",
  "Y": "Yrjö",
  "Z": "Tseta"
};
Map<String, String> _spellingTUR = {
  "A": "Adana",
  "B": "Bolu",
  "C": "Ceyhan",
  "Ç": "Çanakkale",
  "D": "Denizli",
  "E": "Edirne",
  "F": "Fatsa",
  "G": "Giresun",
  "Ğ": "Yumuşak G",
  "H": "Hatay",
  "I": "Isparta",
  "İ": "İzmir",
  "J": "Jandarma",
  "K": "Kars",
  "L": "Lüleburgaz",
  "M": "Muş",
  "N": "Niğde",
  "O": "Ordu",
  "Ö": "Ödemiş",
  "P": "Polatlı",
  "R": "Rize",
  "S": "Sinop",
  "Ş": "Şırnak",
  "T": "Tokat",
  "U": "Uşak",
  "Ü": "Ünye",
  "V": "Van",
  "Y": "Yozgat",
  "Z": "Zonguldak"
};
Map<String, String> _spellingCZE = {
  "A": "Adam",
  "B": "Božena",
  "C": "Cyril",
  "CH": "Chrudim",
  "D": "David",
  "E": "Emil",
  "F": "František",
  "G": "Gustav",
  "H": "Helena",
  "I": "Ivan",
  "J": "Josef",
  "K": "Karel",
  "L": "Ludvik",
  "M": "Marie",
  "N": "Norbert",
  "O": "Otakar",
  "P": "Petr",
  "Q": "Quido",
  "R": "Rudolf",
  "S": "Svatopluk",
  "T": "Tomáš",
  "U": "Urban",
  "V": "Václav",
  "W": "dvojité V",
  "X": "Xaver",
  "Y": "Ypsilon",
  "Z": "Zuzana"
};
Map<String, String> _spellingSLO = {
  "A": "Ankaran",
  "B": "Bled",
  "C": "Celje",
  "Č": "Čatež",
  "D": "Drava",
  "E": "Evropa",
  "F": "Fala",
  "G": "Gorica",
  "H": "Hrastnik",
  "I": "Izola",
  "J": "Jadran",
  "K": "Kamnik",
  "L": "Ljubljana",
  "M": "Maribor",
  "N": "Nanos",
  "O": "Ormož",
  "P": "Piran",
  "Q": "Queen",
  "R": "Ravne",
  "S": "Soča",
  "T": "Triglav",
  "U": "Unec",
  "V": "Velenje",
  "W": "Dvojni v",
  "X": "Iks",
  "Y": "Ipsilon",
  "Z": "Zalog"
};
Map<String, String> _spellingSRB = {
  "A": "Avala",
  "B": "Beograd",
  "C": "Cetinje",
  "Č": "Čačak",
  "Ć": "Ćuprija",
  "D": "Drina",
  "DŽ": "Džep	",
  "Đ": "Đeravica",
  "E": "Evropa",
  "F": "Futog",
  "G": "Golija",
  "H": "Heroj",
  "I": "Igalo",
  "J": "Jadran",
  "K": "Kosovo",
  "L": "Lovćen",
  "LJ": "Ljubovija",
  "M": "Morava",
  "N": "Niš",
  "NJ": "Njegoš",
  "O": "Obilić",
  "P": "Pirot",
  "Q": "Ku",
  "R": "Ruma",
  "S": "Sava",
  "T": "Timok",
  "U": "Užice",
  "V": "Valjevo",
  "W": "Duplo ve",
  "X": "Iks",
  "Y": "Ipsilon",
  "Z": "Zemun"
};
Map<String, String> _spellingYUG = {
  "A": "Avala",
  "B": "Beograd",
  "C": "Cetinje",
  "Č": "Čačak",
  "Ć": "Ćuprija",
  "D": "Dubrovnik",
  "DŽ": "Džamija",
  "Đ": "Đakovo",
  "E": "Evropa",
  "F": "Foča",
  "G": "Gorica",
  "H": "Hercegovina",
  "I": "Istra",
  "J": "Jadran",
  "K": "Kosovo",
  "L": "Lika",
  "LJ": "Ljubljana",
  "M": "Mostar",
  "N": "Niš",
  "NJ": "Njegoš",
  "O": "Osijek",
  "P": "Pirot",
  "Q": "kvadrat",
  "R": "Rijeka",
  "S": "Skopje",
  "T": "Tuzla",
  "U": "Užice",
  "V": "Valjevo",
  "W": "duplo ve",
  "X": "Iks",
  "Y": "ipsilon",
  "Z": "Zagreb"
};
Map<String, String> _spellingROU = {
  "A": "Ana",
  "B": "Barbu",
  "C": "Constantin",
  "D": "Dumitru",
  "E": "Elena",
  "F": "Florea",
  "G": "Gheorghe",
  "H": "Haralambie",
  "I": "Ion",
  "J": "Jean",
  "K": "Kilogram",
  "L": "Lazăr",
  "M": "Maria",
  "N": "Nicolae",
  "O": "Olga",
  "P": "Petre",
  "Q": "Qu (Chiu)",
  "R": "Radu",
  "S": "Sandu",
  "T": "Tudor",
  "U": "Udrea",
  "V": "Vasile",
  "W": "dublu v",
  "X": "Xenia",
  "Y": "I grec",
  "Z": "Zahăr"
};
Map<String, String> _spellingPOL = {
  'A': 'Adam',
  'O': 'Olga',
  'B': 'Barbara',
  'P': 'Paweł',
  'C': 'Celina',
  'Q': 'Quantum',
  'Ć': 'Ćma',
  'R': 'Roman',
  'D': 'Dorota',
  'S': 'Stefan',
  'E': 'Edward',
  'Ś': 'Światowid',
  'F': 'Filip',
  'T': 'Tadeusz',
  'G': 'Gustaw',
  'U': 'Urzula',
  'H': 'Henryk',
  'V': 'Wioletta',
  'I': 'Ignacy',
  'W': 'Walenty',
  'J': 'Józef',
  'X': 'Ksawery',
  'K': 'Karol',
  'Y': 'Ypsylon',
  'L': 'Ludwik',
  'Z': 'Zygmunt',
  'Ł': 'Łucja',
  'Ź': 'Źrebak',
  'M': 'Marian',
  'Ż': 'Żaba',
  'N': 'Nikodem',
};
Map<String, String> _spellingRUS = {
  "А": "Анна, Антон",
  "Б": "Борис",
  "В": "Василий",
  "Г": "Григорий, Галина",
  "Д": "Дмитрий",
  "Е": "Елена",
  "Ё": "Ёлка",
  "Ж": "Женя, жук",
  "З": "Зинаида, Зоя",
  "И": "Иван",
  "Й": "Иван краткий, йот",
  "К": "Константин, киловатт",
  "Л": "Леонид",
  "М": "Михаил, Мария",
  "Н": "Николай",
  "О": "Ольга",
  "П": "Павел",
  "Р": "Роман, радио",
  "С": "Семён, Сергей",
  "Т": "Татьяна, Тамара",
  "У": "Ульяна",
  "Ф": "Фёдор",
  "Х": "Харитон",
  "Ц": "цапля, центр",
  "Ч": "человек",
  "Ш": "Шура, щука",
  "Ъ": "твёрдый знак",
  "Ы": "еры, игрек",
  "Ь": "мягкий знак, знак",
  "Э": "эхо, Эмма",
  "Ю": "Юрий",
  "Я": "Яков",
};
Map<String, String> _spellingRUSLAT = {
  "А": "Anna, Anton",
  "Б": "Boris",
  "В": "Vasily",
  "Г": "Gregory, Galina",
  "Д": "Dmitri",
  "Е": "Yelena",
  "Ё": "Yolka",
  "Ж": "Zhenya, zhuk",
  "З": "Zinaida, Zoya",
  "И": "Ivan",
  "Й": "Ivan kratkiy, yot",
  "К": "Konstantin, kilovatt",
  "Л": "Leonid",
  "М": "Mikhail, Mariya",
  "Н": "Nikolai",
  "О": "Olga",
  "П": "Pavel",
  "Р": "Roman, radio",
  "С": "Semyon, Sergei",
  "Т": "Tatyana, Tamara",
  "У": "Ulyana",
  "Ф": "Fyodor",
  "Х": "Khariton",
  "Ц": "tsaplya, tsentr",
  "Ч": "chelovek",
  "Ш": "Shura, shchuka",
  "Ъ": "tvyordiy znak",
  "Ы": "yery, i grik",
  "Ь": "myagkiy znak, znak",
  "Э": "ekho, Emma",
  "Ю": "Yuri",
  "Я": "Yakov"
};
Map<String, String> _spellingGRC = {
  "Α,α": "αστήρ",
  "Β,β": "Βύρων",
  "Γ,γ": "γαλή",
  "Δ,δ": "δόξα",
  "Ε,ε": "Ερμής",
  "Ζ,ζ": "Ζευς",
  "Η,η": "Ηρώ",
  "Θ,θ": "θεά",
  "Ι,ι": "ίσκιος",
  "Κ,κ": "κενόν",
  "Λ,λ": "λάμα",
  "Μ,μ": "μέλι",
  "Ν,ν": "ναός",
  "Ξ,ξ": "Ξέρξης",
  "Ο,ο": "οσμή",
  "Π,π": "Πέτρος",
  "Ρ,ρ": "ρήγας",
  "Σ,σ,-ς": "σοφός",
  "Τ,τ": "τίγρης",
  "Υ,υ": "ύμνος",
  "Φ,φ": "Φωφώ",
  "Χ,χ": "χαρά",
  "Ψ,ψ": "ψυχή",
  "Ω,ω": "ωμέγα",
};
Map<String, String> _spellingGRCLAT = {
  "Α,α": "astír",
  "Β,β": "Víron",
  "Γ,γ": "galí",
  "Δ,δ": "dóxa",
  "Ε,ε": "Ermís",
  "Ζ,ζ": "Zefs",
  "Η,η": "Iró",
  "Θ,θ": "theá",
  "Ι,ι": "ískios",
  "Κ,κ": "kenón",
  "Λ,λ": "láma",
  "Μ,μ": "méli",
  "Ν,ν": "naós",
  "Ξ,ξ": "Xérxis",
  "Ο,ο": "osmí",
  "Π,π": "Pétros",
  "Ρ,ρ": "rígas",
  "Σ,σ,-ς": "sofós",
  "Τ,τ": "tígris",
  "Υ,υ": "ímnos",
  "Φ,φ": "Fofó",
  "Χ,χ": "chará",
  "Ψ,ψ": "psichí",
  "Ω,ω": "oméga",
};

Map<SPELLING, Map<String, String>> SPELLING_ALPHABETS = {
  SPELLING.ICAO1947: _spellingICAO1947,
  SPELLING.NATO: _spellingNATO,
  SPELLING.USNAVY1908_1: _spellingUSNAVY1908_1,
  SPELLING.USNAVY1908_2: _spellingUSNAVY1908_2,
  SPELLING.USNAVY1920: _spellingUSNAVY1920,
  SPELLING.USNAVY1942: _spellingUSNAVY1942,
  SPELLING.APCO1967: _spellingAPCO1967,
  SPELLING.APCO1974: _spellingNATO,
  SPELLING.ARRL1930: _spellingARRL1930,
  SPELLING.ARRL1936: _spellingARRL1936,
  SPELLING.ARRL1946: _spellingARRL1946,
  SPELLING.ARRL1970: _spellingNATO,
  SPELLING.ARRLDX: _spellingARRLDX,
  SPELLING.EPO: _spellingEPO,
  SPELLING.FRA: _spellingFRA,
  SPELLING.FRABEL: _spellingFRABEL,
  SPELLING.CHE: _spellingCHE,
  SPELLING.FRACAN: _spellingFRACAN,
  SPELLING.DEU1950: _spellingDEU1950,
  SPELLING.DEUDDR: _spellingDEU1950,
  SPELLING.DEU2022: _spellingDEU2022,
  SPELLING.AUT: _spellingAUT,
  SPELLING.NLD: _spellingNLD,
  SPELLING.BEL: _spellingBEL,
  SPELLING.ITA: _spellingITA,
  SPELLING.ESP: _spellingESP,
  SPELLING.BRA: _spellingBRA,
  SPELLING.POR: _spellingPOR,
  SPELLING.SWE: _spellingSWE,
  SPELLING.DNK: _spellingDNK,
  SPELLING.NOR: _spellingNOR,
  SPELLING.FIN: _spellingFIN,
  SPELLING.TUR: _spellingTUR,
  SPELLING.ROU: _spellingROU,
  SPELLING.CZE: _spellingCZE,
  SPELLING.YUG: _spellingYUG,
  SPELLING.SRB: _spellingSRB,
  SPELLING.SLO: _spellingSLO,
  SPELLING.POL: _spellingPOL,
  SPELLING.RUS: _spellingRUS,
  SPELLING.RUSLAT: _spellingRUSLAT,
  SPELLING.GRC: _spellingGRC,
  SPELLING.GRCLAT: _spellingGRCLAT,
};

final Map<Locale, SPELLING> SUPPORTED_SPELLING_LOCALES = {
  const Locale('cz'): SPELLING.CZE,
  const Locale('da'): SPELLING.DNK,
  const Locale('de'): SPELLING.DEU2022,
  const Locale('el'): SPELLING.GRC,
  const Locale('en'): SPELLING.NATO,
  const Locale('es'): SPELLING.ESP,
  const Locale('fi'): SPELLING.FIN,
  const Locale('fr'): SPELLING.FRA,
  const Locale('it'): SPELLING.ITA,
  const Locale('nl'): SPELLING.NLD,
  const Locale('pl'): SPELLING.POL,
  const Locale('pt'): SPELLING.POR,
  const Locale('ru'): SPELLING.RUS,
  const Locale('sv'): SPELLING.SWE,
  const Locale('tr'): SPELLING.TUR,
};