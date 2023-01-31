import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/superperfect_numbers/widget/superperfect_numbers.dart';
import 'package:gc_wizard/utils/common_widget_utils.dart';

class NumberSequenceSuperPerfectNumbersSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(NumberSequenceSuperPerfectNumbersNthNumber()),
        className(NumberSequenceSuperPerfectNumbersRange()),
        className(NumberSequenceSuperPerfectNumbersDigits()),
        className(NumberSequenceSuperPerfectNumbersCheckNumber()),
        className(NumberSequenceSuperPerfectNumbersContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
