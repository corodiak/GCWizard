import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';

class CryptographySelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools
        .where((element) => element.categories.contains(ToolCategory.CRYPTOGRAPHY))
        .toList();
    _toolList.sort((a, b) => sortToolList(a, b));

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
