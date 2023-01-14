import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_colorcodecalculator/widget/resistor_colorcodecalculator.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_eia96/widget/resistor_eia96.dart';
import 'package:gc_wizard/tools/symbol_tables/widget/symbol_table.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';

class ResistorSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(SymbolTable()) && (element.tool as SymbolTable).symbolKey == 'resistor')
        return true;

      return [
        className(ResistorColorCodeCalculator()),
        className(ResistorEIA96()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
