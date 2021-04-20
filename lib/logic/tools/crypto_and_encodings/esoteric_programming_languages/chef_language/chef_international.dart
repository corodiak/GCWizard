enum textId {
  Put,
  Ingredients,
  Cooking_time,
  Pre_heat_oven,
  Method,
  Liquefy_contents,
  Liquefy,
  Pour,
  Serves,
  Serve_with,
  Clean,
  Add,
  Combine
}

enum Type {
  Take,
  Put,
  Fold,
  Add,
  Remove,
  Combine,
  Divide,
  AddDry,
  Liquefy,
  LiquefyBowl,
  Stir,
  StirInto,
  Mix,
  Clean,
  Pour,
  Verb,
  VerbUntil,
  SetAside,
  Serve,
  Refrigerate,
  Remember,
  Invalid,
  Nehmen,
  Geben,
  Unterheben,
  Dazugeben,
  Abschoepfen,
  Kombinieren,
  Teilen,
  FestesHinzugeben,
  Schmelzen,
  SchuesselErhitzen,
  ZutatRuehren,
  SchuessselRuehren,
  Mischen,
  Saeubern,
  Ausgiessen,
  Wiederholen,
  WiederholenBis,
  BeiseiteStellen,
  Servieren,
  Gefrieren,
  Erinnern,
  Unbekannt
}

final List<RegExp> matchersENG = [
  RegExp(r'^take( the)? ([a-z0-9 ]+) from( the)? refrigerator$'),
  RegExp(r'^(put|fold)( the)? ([a-z0-9 ]+) into( the)?( (\d+)(nd|rd|th|st))? mixing bowl$'),
  RegExp(r'^add( the)? dry ingredients (to ((the )?(\d+)(nd|rd|th|st) )?mixing bowl)?$'),
  RegExp(
      r'^(add|remove|combine|divide)( the)? ([a-z0-9 ]+?)( (to|into|from)( the)?( (\d+)(nd|rd|th|st))? mixing bowl)?$'),
  RegExp(r'^liqu[ie]fy( the)? contents of the( (\d+)(nd|rd|th|st))? mixing bowl$'),
  RegExp(r'^liqu[ie]fy( the)? ([a-z0-9 ]+)$'),
  RegExp(r'^stir ((the )?((\d+)(nd|rd|th|st) )?mixing bowl )?for (\d+) minute(s)?$'),
  RegExp(r'^stir (the )?([a-z0-9 ]+) into (the )?((\d+)(nd|rd|th|st) )?mixing bowl$'),
  RegExp(r'^mix( (the )?((\d+)(nd|rd|th|st) )?mixing bowl)?( well)?$'),
  RegExp(r'^clean( the)?( (\d+)(nd|rd|th|st))? mixing bowl( well)?$'),
  RegExp(
      r'^pour( the)? contents of( the)?( (\d+)(nd|rd|th|st))? mixing bowl into( the)?( (\d+)(nd|rd|th|st))? baking dish$'),
  RegExp(r'^set aside$'),
  RegExp(r'^refrigerate( for (\d+) hour(s)?)?$'),
  RegExp(r'^serve with( the)? ([a-z0-9 ]+)$'),
  RegExp(r'^suggestion: (.*)$'),
  RegExp(r'^([a-z0-9]+)( (the )?([a-z0-9 ]+))? until ([a-z0-9]+)$'),
  RegExp(r'^([a-z0-9]+)( the)? ([a-z0-9 ]+)$')
];

final List<RegExp> matchersDEU = [
  RegExp(r'^(den |die |das )?([a-zäöüß0-9 ]+) aus (dem )?kühlschrank nehmen$'),
  RegExp(r'^(den |die |das )?([a-zäöüß0-9 ]+) in( die)?( (\d+)(te))? (rühr)?schüssel geben$'),
  RegExp(r'^(den |die |das )?([a-zäöüß0-9 ]+)( in( die)?( (\d+)(te))? (rühr)?schüssel)? unterheben$'),
  RegExp(r'^alle festen zutaten(( (zu)?(( )?de)?(r)?)?( (\d+)(ten))? (rühr)?schüssel)? hinzugeben$'),
  RegExp(
      r'^(den |die |das )?([a-zäöüß0-9 ]+?)( (zu |mit |aus |in (der |die )?)((\d+)(te(n)?) )?(rühr)?schüssel)?( )?(dazugeben|hinzufügen|abschöpfen|entfernen|kombinieren|teilen)$'),
  RegExp(
      r'^inhalt(e)? der ((\d+)(ten) )?(rühr)?schüssel( auf dem stövchen)?( erhitzen| zerlassen| schmelzen| verflüssigen)$'),
  RegExp(r'^(den |die |das )?([a-zäöüß0-9 ]+)( erhitzen| zerlassen| schmelzen| verflüssigen)$'),
  RegExp(r'^((die )?((\d+)(te ))?(rühr)?schüssel )?für (\d+) minute(n)? umrühren$'),
  RegExp(r'^(das |die |den )?([a-zäöüß0-9 ]+) (in (die )?((\d+)(te) )?(rühr)?schüssel )?unterrühren$'),
  RegExp(r'^inhalt der ((\d+)(ten ))?(rühr)?schüssel gut verrühren$'),
  RegExp(r'^((\d+)(te) )?(rühr)?schüssel (abwaschen|säubern)$'),
  RegExp(
      r'^(inhalt(e)?( der)?( (\d+)(te(n)?))? )?(rühr)?schüssel( auf| in)( die| das| den| ein(e)?(n)?)?( (\d+)(te(n)?))? (servier(schale|platte)|teller|backblech) (gießen|stürzen|schütten)$'),
  RegExp(r'^(zur seite stellen|stelle beiseite)'),
  RegExp(r'^(einfrieren|gefriere)( für (\d+) stunde(n)?)?$'),
  RegExp(r'^serviere mit (dem |einem )?([a-zäöüß0-9 ]+)$'),
  RegExp(r'^vorschlag: (.*)$'),
  RegExp(r'^solange ([a-zäöüß0-9]+) bis ((das |den |die )?([a-zäöüß0-9 ]+))? zur weiterarbeitung bereit$'),
  RegExp(r'^(das |den |die )?([a-zäöüß0-9]+) ([a-zäöüß0-9 ]+)$')
];

final RegExp MeasureType = RegExp(r'^heaped$|^level$|^gestrichen$|^gehäuft$');
final RegExp MeasureDry = RegExp(r'^g(r)?$|^kg$|^pinch(es)?$|^prise(n)$');
final RegExp MeasureLiquid = RegExp(r'^ml$|^l$|^dash(es)?$|^drop(s)?$|^spritzer$|^tropfen$');
final RegExp MeasureElse = RegExp(r'^cup(s)?$|^tasse(n)?$|^teaspoon(s)?$|^tablespoon(s)?$|^teelöffel$|^esslöffel$');

final Map Messages = {
  'DEU': {
    "chef_error_structure_recipe": "chef_error_structure_recipe",
    "chef_error_structure_subrecipe": "chef_error_structure_subrecipe",
    "chef_error_structure_recipe_title": "chef_error_structure_recipe_title_de",
    "chef_error_structure_recipe_missing_title": "chef_error_structure_recipe_missing_title",
    "chef_error_structure_recipe_missing_output": "chef_error_structure_recipe_missing_output",
    "chef_error_structure_recipe_comments": "chef_error_structure_recipe_comments_de",
    "chef_error_structure_recipe_ingredient_list": "chef_error_structure_recipe_ingredient_list_de",
    "chef_error_structure_recipe_cooking_time": "chef_error_structure_recipe_cooking_time_de",
    "chef_error_structure_recipe_oven_temperature": "chef_error_structure_recipe_oven_temperature_de",
    "chef_error_structure_recipe_methods": "chef_error_structure_recipe_methods_de",
    "chef_error_structure_recipe_serve_amount": "chef_error_structure_recipe_serve_amount_de",
    "chef_error_structure_recipe_read_unexpected": "chef_error_structure_recipe_read_unexpected",
    "chef_error_structure_recipe_read_unexpected_comments_title":
        "chef_error_structure_recipe_read_unexpected_comments_title",
    "chef_error_structure_recipe_expecting": "chef_error_structure_recipe_expecting",
    "chef_error_structure_recipe_empty_missing_title": "chef_error_structure_recipe_empty_missing_title",
    "chef_error_structure_recipe_empty_ingredients": "chef_error_structure_recipe_empty_ingredients_de",
    "chef_error_structure_recipe_empty_methods": "chef_error_structure_recipe_empty_methods_de",
    "chef_error_structure_recipe_empty_serves": "chef_error_structure_recipe_empty_serves_de",
    "chef_error_syntax": "chef_error_syntax",
    "chef_error_syntax_ingredient": "chef_error_syntax_ingredient",
    "chef_error_syntax_ingredient_name": "chef_error_syntax_ingredient_name",
    "chef_error_syntax_method": "chef_error_syntax_method",
    "chef_error_syntax_method_unsupported": "chef_error_syntax_method_unsupported",
    "chef_error_syntax_serves": "chef_error_syntax_serves",
    "chef_error_syntax_serves_without_number": "chef_error_syntax_serves_without_number",
    "chef_error_syntax_cooking_time": "chef_error_syntax_cooking_time_de",
    "chef_error_syntax_oven_temperature": "chef_error_syntax_oven_temperature_de",
    "chef_error_runtime": "chef_error_runtime",
    "chef_error_runtime_exception": "chef_error_runtime_exception",
    "chef_error_runtime_serving_aux": "chef_error_runtime_serving_aux",
    "chef_error_runtime_invalid_input": "chef_error_runtime_invalid_input",
    "chef_error_runtime_ingredient_not_found": "chef_error_runtime_ingredient_not_found",
    "chef_error_runtime_method_step": "chef_error_runtime_method_step",
    "chef_error_runtime_missing_input": "chef_error_runtime_missing_input",
    "chef_error_runtime_folded_from_empty_mixing_bowl": "chef_error_runtime_folded_from_empty_mixing_bowl",
    "chef_error_runtime_method_loop": "chef_error_runtime_method_loop",
    "chef_error_runtime_method_loop_end": "chef_error_runtime_method_loop_end",
    "chef_error_runtime_method_loop_aside": "chef_error_runtime_method_loop_aside",
    "chef_error_runtime_method_aux_recipe": "chef_error_runtime_method_aux_recipe",
    "chef_error_runtime_method_aux_recipe_return": "chef_error_runtime_method_aux_recipe_return",
    "chef_error_runtime_add_to_empty_mixing_bowl": "chef_error_runtime_add_to_empty_mixing_bowl",
    "chef_error_runtime_remove_from_empty_mixing_bowl": "chef_error_runtime_remove_from_empty_mixing_bowl",
    "chef_error_runtime_combine_with_empty_mixing_bowl": "chef_error_runtime_combine_with_empty_mixing_bowl",
    "chef_error_runtime_divide_from_empty_mixing_bowl": "chef_error_runtime_divide_from_empty_mixing_bowl",
    "chef_error_runtime_stir_empty_mixing_bowl": "chef_error_runtime_stir_empty_mixing_bowl",
    "chef_error_runtime_stir_in_empty_mixing_bowl": "chef_error_runtime_stir_in_empty_mixing_bowl",
    "chef_error_runtime_mix_empty_mixing_bowl": "chef_error_runtime_mix_empty_mixing_bowl",
    "chef_hint_recipe_hint": "chef_hint_recipe_hint",
    "chef_hint_recipe_ingredients": "chef_hint_recipe_ingredients_de",
    "chef_hint_recipe_methods": "chef_hint_recipe_methods_de",
    "chef_hint_recipe_oven_temperature": "chef_hint_recipe_oven_temperature",
    "chef_hint_no_hint_available": "chef_hint_no_hint_available",
  },
  'ENG': {
    "chef_error_structure_recipe": "chef_error_structure_recipe",
    "chef_error_structure_subrecipe": "chef_error_structure_subrecipe",
    "chef_error_structure_recipe_title": "chef_error_structure_recipe_title_en",
    "chef_error_structure_recipe_missing_title": "chef_error_structure_recipe_missing_title",
    "chef_error_structure_recipe_missing_output": "chef_error_structure_recipe_missing_output",
    "chef_error_structure_recipe_comments": "chef_error_structure_recipe_comments_en",
    "chef_error_structure_recipe_ingredient_list": "chef_error_structure_recipe_ingredient_list_en",
    "chef_error_structure_recipe_cooking_time": "chef_error_structure_recipe_cooking_time_en",
    "chef_error_structure_recipe_oven_temperature": "chef_error_structure_recipe_oven_temperature_en",
    "chef_error_structure_recipe_methods": "chef_error_structure_recipe_methods_en",
    "chef_error_structure_recipe_serve_amount": "chef_error_structure_recipe_serve_amount_en",
    "chef_error_structure_recipe_read_unexpected": "chef_error_structure_recipe_read_unexpected",
    "chef_error_structure_recipe_read_unexpected_comments_title":
        "chef_error_structure_recipe_read_unexpected_comments_title",
    "chef_error_structure_recipe_expecting": "chef_error_structure_recipe_expecting",
    "chef_error_structure_recipe_empty_missing_title": "chef_error_structure_recipe_empty_missing_title",
    "chef_error_structure_recipe_empty_ingredients": "chef_error_structure_recipe_empty_ingredients_en",
    "chef_error_structure_recipe_empty_methods": "chef_error_structure_recipe_empty_methods_en",
    "chef_error_structure_recipe_empty_serves": "chef_error_structure_recipe_empty_serves_en",
    "chef_error_syntax": "chef_error_syntax",
    "chef_error_syntax_ingredient": "chef_error_syntax_ingredient",
    "chef_error_syntax_ingredient_name": "chef_error_syntax_ingredient_name",
    "chef_error_syntax_method": "chef_error_syntax_method",
    "chef_error_syntax_method_unsupported": "chef_error_syntax_method_unsupported",
    "chef_error_syntax_serves": "chef_error_syntax_serves",
    "chef_error_syntax_serves_without_number": "chef_error_syntax_serves_without_number",
    "chef_error_syntax_cooking_time": "chef_error_syntax_cooking_time_en",
    "chef_error_syntax_oven_temperature": "chef_error_syntax_oven_temperature_en",
    "chef_error_runtime": "chef_error_runtime",
    "chef_error_runtime_exception": "chef_error_runtime_exception",
    "chef_error_runtime_serving_aux": "chef_error_runtime_serving_aux",
    "chef_error_runtime_invalid_input": "chef_error_runtime_invalid_input",
    "chef_error_runtime_ingredient_not_found": "chef_error_runtime_ingredient_not_found",
    "chef_error_runtime_method_step": "chef_error_runtime_method_step",
    "chef_error_runtime_missing_input": "chef_error_runtime_missing_input",
    "chef_error_runtime_folded_from_empty_mixing_bowl": "chef_error_runtime_folded_from_empty_mixing_bowl",
    "chef_error_runtime_method_loop": "chef_error_runtime_method_loop",
    "chef_error_runtime_method_loop_end": "chef_error_runtime_method_loop_end",
    "chef_error_runtime_method_loop_aside": "chef_error_runtime_method_loop_aside",
    "chef_error_runtime_method_aux_recipe": "chef_error_runtime_method_aux_recipe",
    "chef_error_runtime_method_aux_recipe_return": "chef_error_runtime_method_aux_recipe_return",
    "chef_error_runtime_add_to_empty_mixing_bowl": "chef_error_runtime_add_to_empty_mixing_bowl",
    "chef_error_runtime_remove_from_empty_mixing_bowl": "chef_error_runtime_remove_from_empty_mixing_bowl",
    "chef_error_runtime_combine_with_empty_mixing_bowl": "chef_error_runtime_combine_with_empty_mixing_bowl",
    "chef_error_runtime_divide_from_empty_mixing_bowl": "chef_error_runtime_divide_from_empty_mixing_bowl",
    "chef_error_runtime_stir_empty_mixing_bowl": "chef_error_runtime_stir_empty_mixing_bowl",
    "chef_error_runtime_stir_in_empty_mixing_bowl": "chef_error_runtime_stir_in_empty_mixing_bowl",
    "chef_error_runtime_mix_empty_mixing_bowl": "chef_error_runtime_mix_empty_mixing_bowl",
    "chef_hint_recipe_hint": "chef_hint_recipe_hint",
    "chef_hint_recipe_ingredients": "chef_hint_recipe_ingredients_en",
    "chef_hint_recipe_methods": "chef_hint_recipe_methods_en",
    "chef_hint_recipe_oven_temperature": "chef_hint_recipe_oven_temperature",
    "chef_hint_no_hint_available": "chef_hint_no_hint_available",
  }
};

final List<String> liquidMeasuresDEU = ['ml', 'l', 'Spritzer', 'Tropfen'];

final List<String> liquidMeasuresENG = ['ml', 'l', 'dashes', 'drops'];

final List<String> dryMeasuresDEU = ['g', 'kg', 'Prisen'];

final List<String> dryMeasuresENG = ['g', 'kg', 'pinches'];

final List<String> measuresDEU = ['Teelöffel', 'Esslöffel', 'Tasse'];

final List<String> measuresENG = ['teaspoons', 'tablespoons', 'cups'];

final List<String> itemListLiquidENG = [
  'milk',
  'water',
  'oil',
  'liquid vanilla',
  'lemon juice',
  'lime juice',
  'orange juice',
  'egg white',
  'soda',
  'bitter lemon',
  'amaretto',
  'espresso',
  'cream',
  'aquavit',
  'white wine',
  'red wine',
  'tabasco',
  'sour cream',
  'beer',
  'sake',
  'vodka',
  'calvados',
  'whisky',
  'grand marnier',
  'grenadine',
  'gin',
  'rum',
  'tonic',
  'raki',
  'beaten eggs',
  'ouzo',
  'fruit brandy',
  'cider',
  'tequila',
  'cointreau',
  'agave nectar',
  'white vermouth',
  'red vermouth',
  'angustora',
  'blue curacao',
  'white rum',
  'tomato juice',
  'limoncello',
  'honey syrup',
  'syrup',
  'ginger beer',
  'brandy',
  'grappa',
  'port',
  'sherry',
  'bourbon',
  'scotch',
  'lillet'
];

final List<String> itemListLiquidDEU = [
  'Milch',
  'Wasser',
  'Öl',
  'flüssige Vanille',
  'Zitronensaft',
  'Orangensaft',
  'Limettensaft',
  'Eiweiß',
  'Soda',
  'Bitter Lemon',
  'Amaretto',
  'Espresso',
  'Sahne',
  'Aquavit',
  'Weißwein',
  'Rotwein',
  'Tabasco',
  'Schmand',
  'Bier',
  'Sake',
  'Wodka' 'Calvados',
  'Whisky',
  'Grand Marnier',
  'Grenadine',
  'Gin',
  'Rum',
  'Tonic',
  'Raki',
  'geschlagene Eier',
  'Ouzo',
  'Obstler',
  'Cidre',
  'Tequila',
  'Cointreau',
  'Agavensaft',
  'weißer Wermut',
  'roter Wermut',
  'Angustora',
  'Blue Curacao',
  'weißer Rum',
  'Tomatensaft',
  'Limoncello',
  'Honigsirup',
  'Zuckersirup',
  'Ginger Ale',
  'Weinbrand',
  'Grappa',
  'Portwein',
  'Sherry',
  'Bourbon Whisky',
  'Scotch Whisky',
  'Lillet'
];

final List<String> itemListDryENG = [
  'flour',
  'white sugar',
  'salt',
  'baking soda',
  'butter',
  'vanilla bean',
  'brown sugar',
  'pepper',
  'haricot beans',
  'red salmon',
  'lemon juice',
  'powdered sugar',
  'almonds',
  'onions',
  'garlic cloves',
  'cinnamon',
  'kummel',
  'aniseed',
  'cream cheese',
  'cheese',
  'pumpkin',
  'cucumber',
  'potatoes',
  'sweet potatoes',
  'eggs',
  'apple pieces',
  'shrimps',
  'guacamole',
  'wholemeal flour',
  'tofu',
  'chili',
  'curry',
  'mustard',
  'jam',
  'mixed fruits',
  'egg yolk',
  'zucchini',
  'lard',
  'corn starch',
  'bread',
  'bacon',
  'dark chocolate',
  'milk chocolate',
  'double cream',
  'cocoa powder',
  'peas',
  'carrots',
  'raisins',
  'mexican spices',
  'banana chips'
];

final List<String> itemListDryDEU = [
  'Mehl',
  'weißer Zucker',
  'Salz',
  'Backsoda',
  'Butter',
  'Vanilleschote',
  'brauner Zucker',
  'Pfeffer',
  'Bohnen',
  'roter Lachs',
  'Eigelb',
  'Puderzucker',
  'Mandeln',
  'Zwiebeln',
  'gehackter Knoblauch',
  'Zimt',
  'Kümmel',
  'Anis',
  'Frischkäse',
  'Käse',
  'Kürbis',
  'Gurke',
  'Kartoffeln',
  'Süßkartoffeln',
  'Apfelstücke',
  'Garnelen',
  'Guacamole',
  'Vollkornmehl',
  'Tofu',
  'Chili',
  'Curry',
  'Senf',
  'Marmelade',
  'gemischte Früchte',
  'Zucchini',
  'Schmalz',
  'Eier',
  'Maisstärke',
  'Brot',
  'Speck',
  'dunkle Schokolade',
  'Milchschokolade',
  'Kakaopulver',
  'Erbsen',
  'Karotten',
  'Rosinen',
  'mexikanische Gewürze',
  'Bananenchips'
];

final List<List<String>> itemListAuxiliaryDEU = [
  ['fluffige ', 'leichte ', 'cremige ', 'schwere ', 'luftige '],
  ['bittere ', 'sauere ', 'süße ', 'scharfe ', 'salzige '],
  ['Honig', 'Senf', 'Ketchup', 'Curry', 'Preiselbeeren'],
  ['soße', 'dressings', 'toppings', 'chips', 'relish']
];

final List<List<String>> itemListAuxiliaryENG = [
  ['fluffy ', 'light ', 'creamy ', 'heavy ', 'uncongested '],
  ['bitter ', 'sour ', 'sweet ', 'hot ', 'salty '],
  ['honey', 'mustard', 'ketchup', 'curry', 'cranberry'],
  ['sauce', 'dressing', 'topping', 'chips', 'relish']
];

String getText(textId id, String parameter, language) {
  var text = '';
  switch (id) {
    case textId.Put:
      if (language == 'ENG')
        text = 'Put %1 into the mixing bowl.';
      else
        text = '%1 in die Schüssel geben.';
      break;
    case textId.Add:
      if (language == 'ENG')
        text = 'Add %1 into the mixing bowl.';
      else
        text = '%1 dazugeben.';
      break;
    case textId.Combine:
      if (language == 'ENG')
        text = 'Combine %1 into mixing bowl.';
      else
        text = '%1 kombinieren.';
      break;
    case textId.Ingredients:
      if (language == 'ENG')
        text = 'Ingredients.';
      else
        text = 'Zutaten:';
      break;
    case textId.Cooking_time:
      if (language == 'ENG')
        text = 'Cooking time: %1 minutes.';
      else
        text = 'Garzeit: %1 Minuten.';
      break;
    case textId.Pre_heat_oven:
      if (language == 'ENG')
        text = 'Pre-heat oven to %1 degrees Celsius.';
      else
        text = 'Ofen auf %1 Grad Celsius vorheizen.';
      break;
    case textId.Method:
      if (language == 'ENG')
        text = 'Method.';
      else
        text = 'Zubereitung:';
      break;
    case textId.Liquefy:
      if (language == 'ENG')
        text = 'Liquefy %1.';
      else
        text = '%1 zerlassen.';
      break;
    case textId.Liquefy_contents:
      if (language == 'ENG')
        text = 'Liquefy contents of the mixing bowl.';
      else
        text = 'Inhalt der Schüssel auf dem Stövchen erhitzen.';
      break;
    case textId.Pour:
      if (language == 'ENG')
        text = 'Pour contents of the mixing bowl into the baking dish.';
      else
        text = 'Schüssel in eine Servierschale stürzen.';
      break;
    case textId.Serves:
      if (language == 'ENG')
        text = 'Serves 1.';
      else
        text = 'Portionen: 1.';
      break;
    case textId.Serve_with:
      if (language == 'ENG')
        text = 'Serve with %1.';
      else
        text = 'Serviere mit %1.';
      break;
      break;
    case textId.Clean:
      if (language == 'ENG')
        text = 'Clean %1 mixing bowl.';
      else
        text = '%1 Schüssel abwaschen.';
      break;
      break;
  }

  return text.replaceAll('%1', parameter);
}
