import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard/logic/keyboard.dart';

class KeyboardLayout extends StatefulWidget {
  @override
  KeyboardLayoutState createState() => KeyboardLayoutState();
}

class KeyboardLayoutState extends State<KeyboardLayout> {
  var _inputController;

  String _currentInput = '';

  var _currentKeyboardFrom = KeyboardType.QWERTZ_T1;
  var _currentKeyboardTo = KeyboardType.QWERTY_US_INT;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    GCWTextDivider(text: i18n(context, 'keyboard_from')),
                    GCWDropDown(
                      value: _currentKeyboardFrom,
                      onChanged: (value) {
                        setState(() {
                          _currentKeyboardFrom = value;
                        });
                      },
                      items: allKeyboards.map((keyboard) {
                        return GCWDropDownMenuItem(
                            value: keyboard.type, child: i18n(context, keyboard.name), subtitle: keyboard.example);
                      }).toList(),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(right: DEFAULT_MARGIN),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    GCWTextDivider(text: i18n(context, 'keyboard_to')),
                    GCWDropDown(
                      value: _currentKeyboardTo,
                      onChanged: (value) {
                        setState(() {
                          _currentKeyboardTo = value;
                        });
                      },
                      items: allKeyboards.map((keyboard) {
                        return GCWDropDownMenuItem(
                            value: keyboard.type, child: i18n(context, keyboard.name), subtitle: keyboard.example);
                      }).toList(),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: DEFAULT_MARGIN),
              ),
            ),
          ],
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    return GCWDefaultOutput(
        child: GCWOutputText(
      text: encodeKeyboard(_currentInput, _currentKeyboardFrom, _currentKeyboardTo),
    ));
  }
}
