import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';

class ImagesAndFilesSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = Registry.toolList
        .where((element) => element.categories != null && element.categories.contains(ToolCategory.IMAGES_AND_FILES))
        .toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
