import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gronsfeld/widget/gronsfeld.dart';

class GronsfeldRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'gronsfeld';

  @override
  List<String> searchKeys = [
    'vigenere',
    'rotation',
    'gronsfeld',
  ];

  @override
  Widget tool = Gronsfeld();
}