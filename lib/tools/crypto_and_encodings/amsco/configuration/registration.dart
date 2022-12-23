import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/amsco/widget/amsco.dart';

class AmscoRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'amsco';

  @override
  List<String> searchKeys = [
    'amsco',
  ];

  @override
  Widget tool = Amsco();
}