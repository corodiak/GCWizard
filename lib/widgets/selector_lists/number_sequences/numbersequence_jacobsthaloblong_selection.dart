import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/jacobsthal_oblong.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceJacobsthalOblongSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(NumberSequenceJacobsthalOblongNthNumber()),
        className(NumberSequenceJacobsthalOblongRange()),
        className(NumberSequenceJacobsthalOblongDigits()),
        className(NumberSequenceJacobsthalOblongCheckNumber()),
        className(NumberSequenceJacobsthalOblongContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
