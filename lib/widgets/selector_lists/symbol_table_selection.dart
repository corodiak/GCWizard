import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_tool/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist/gcw_toollist.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_replacer/widget/symbol_replacer.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_tables_examples_select/widget/symbol_tables_examples_select.dart';
import 'package:gc_wizard/tools/symbol_tables/widget/symbol_table.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';

class SymbolTableSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(SymbolTable()),
      ].contains(className(element.tool));
    }).toList();

    _toolList.sort((a, b) => sortToolList(a, b));

    _toolList.insert(0, registeredTools.firstWhere((element) {
      return [
        className(SymbolReplacer()),
      ].contains(className(element.tool));
    }));

    _toolList.insert(0, registeredTools.firstWhere((element) {
      return [
        className(SymbolTableExamplesSelect()),
      ].contains(className(element.tool));
    }));

    return Container(child: GCWToolList(toolList: _toolList));
  }
}

String symboltablesDownloadLink(BuildContext context) {
  final _SUPPORTED_LANGUAGES = ['de', 'en', 'fr', 'ko', 'nl', 'sv', 'se'];
  var locale = Localizations.localeOf(context).languageCode;

  var usedLocale = 'en';
  if (_SUPPORTED_LANGUAGES.contains(locale)) usedLocale = locale;

  return 'https://misc.gcwizard.net/symboltables_$usedLocale.pdf';
}
