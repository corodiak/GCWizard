import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/pell_lucas.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequencePellLucasSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(NumberSequencePellLucasNthNumber()),
        className(NumberSequencePellLucasRange()),
        className(NumberSequencePellLucasDigits()),
        className(NumberSequencePellLucasCheckNumber()),
        className(NumberSequencePellLucasContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
