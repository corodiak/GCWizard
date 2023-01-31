import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/happy_numbers/widget/happy_numbers.dart';
import 'package:gc_wizard/utils/common_widget_utils.dart';

class NumberSequenceHappyNumbersSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(NumberSequenceHappyNumbersNthNumber()),
        className(NumberSequenceHappyNumbersRange()),
        className(NumberSequenceHappyNumbersDigits()),
        className(NumberSequenceHappyNumbersCheckNumber()),
        className(NumberSequenceHappyNumbersContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
