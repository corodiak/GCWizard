import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne_exponents/widget/mersenne_exponents.dart';
import 'package:gc_wizard/utils/common_widget_utils.dart';

class NumberSequenceMersenneExponentsSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(NumberSequenceMersenneExponentsNthNumber()),
        className(NumberSequenceMersenneExponentsRange()),
        className(NumberSequenceMersenneExponentsDigits()),
        className(NumberSequenceMersenneExponentsCheckNumber()),
        className(NumberSequenceMersenneExponentsContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
