import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_tool/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist/gcw_toollist.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base122/widget/base122.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base16/widget/base16.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base32/widget/base32.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base58/widget/base58.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base64/widget/base64.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base85/widget/base85.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base91/widget/base91.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';

class BaseSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(Base16()),
        className(Base32()),
        className(Base58()),
        className(Base64()),
        className(Base85()),
        className(Base91()),
        className(Base122()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
