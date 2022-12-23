import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal_lucas/widget/jacobsthal_lucas.dart';

class NumberSequenceJacobsthalLucasCheckNumberRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'numbersequence_check';

  @override
  List<String> searchKeys = [
    'numbersequence_jacobsthallucasselection',
  ];

  @override
  Widget tool = NumberSequenceJacobsthalLucasCheckNumber();
}