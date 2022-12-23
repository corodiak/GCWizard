import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_iso_codes/widget/countries_iso_codes.dart';

class CountriesISOCodesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'countries_isocode';

  @override
  List<String> searchKeys = [
    'countries',
    'countries_isocodes',
  ];

  @override
  Widget tool = CountriesISOCodes();
}