import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GeneralCodebreakersSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools
        .where(
            (element) => element.categories != null && element.categories.contains(ToolCategory.GENERAL_CODEBREAKERS))
        .toList();
    _toolList.sort((a, b) => sortToolListAlphabetically(a, b));

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
