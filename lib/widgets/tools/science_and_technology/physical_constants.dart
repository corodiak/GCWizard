import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/physical_constants.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class PhysicalConstants extends StatefulWidget {
  @override
  PhysicalConstantsState createState() => PhysicalConstantsState();
}

class PhysicalConstantsState extends State<PhysicalConstants> {
  var _currentConstant = PHYSICAL_CONSTANTS.entries.first.key;

  List<String> _constants;

  @override
  Widget build(BuildContext context) {
    if (_constants == null) {
      _constants = [];

      List<String> _temp = PHYSICAL_CONSTANTS.keys.map((constant) => i18n(context, constant)).toList();
      _temp.sort();

      for (String constant in _temp) {
        _constants.add(PHYSICAL_CONSTANTS.keys.firstWhere((c) => i18n(context, c) == constant));
      }

      _currentConstant = _constants.first;
    }

    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentConstant,
          onChanged: (value) {
            setState(() {
              _currentConstant = value;
            });
          },
          items: _constants.map((constant) {
            return GCWDropDownMenuItem(
              value: constant,
              child: i18n(context, constant)
            );
          }).toList(),
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    Map<String, dynamic> constantData = PHYSICAL_CONSTANTS[_currentConstant];

    var data = [
      constantData['symbol'] != null ? [i18n(context, 'physical_constants_symbol'), constantData['symbol']] : null,
      constantData['value'] != null ? [i18n(context, 'physical_constants_value'), constantData['value'] + (
          constantData['exponent'] != null ? ' × 10' + stringToSuperscript(constantData['exponent'].toString()) : ''
      )] : null,
      constantData['standard_uncertainty'] != null ? [i18n(context, 'physical_constants_standard_uncertainty'), constantData['standard_uncertainty'] + (
          constantData['exponent'] != null ? ' × 10' + stringToSuperscript(constantData['exponent'].toString()) : ''
      )] : null,
      constantData['unit'] != null ? [i18n(context, 'physical_constants_unit'), constantData['unit']] : null
    ];

    return Column(
      children: columnedMultiLineOutput(
        context,
        data,
        flexValues: [1, 2]
      ),
    );
  }
}
