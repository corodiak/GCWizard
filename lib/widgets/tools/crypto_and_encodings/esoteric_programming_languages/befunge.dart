import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/befunge.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:prefs/prefs.dart';

class Befunge extends StatefulWidget {
  @override
  BefungeState createState() => BefungeState();
}

class BefungeState extends State< Befunge > {
  var _textEncodeController;
  var _textDecodeController;
  var _inputController;
  var _scrollController = ScrollController();

  var _currentEncodeText = '';
  var _currentDecodeText = '';
  var _currentInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  var _codeController;
  var _sourceCode = '';

  @override
  void initState() {
    super.initState();
    _textEncodeController = TextEditingController(text: _currentEncodeText);
    _textDecodeController = TextEditingController(text: _currentDecodeText);
    _inputController = TextEditingController(text: _currentInput);
    _codeController = CodeController(
      text: _sourceCode,
      theme: Prefs.getString('theme_color') == ThemeType.DARK.toString()
          ? atomOneDarkTheme
          : atomOneLightTheme,
    );}

  @override
  void dispose() {
    _textEncodeController.dispose();
    _textDecodeController.dispose();
    _inputController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _codeController.text = generateBefunge (_currentEncodeText);
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'common_programming_mode_interpret'),
          rightValue: i18n(context, 'common_programming_mode_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
        ? GCWTextField(
            controller: _textDecodeController,
            hintText: i18n(context, 'common_programming_hint_sourcecode'),
            maxLines: 5,
            maxLength: MAX_LENGTH_PROGRAM,
            onChanged: (text) {
              setState(() {
                _currentDecodeText = text;
              });
            },
          )
        : GCWTextField(
            controller: _textEncodeController,
            //inputFormatters: [TextInputFormatter.allow('A-Z0-9')],
            hintText: i18n(context, 'common_programming_hint_output'),
            onChanged: (text) {
              setState(() {
                _currentEncodeText = text;
              });
            },
        ),
        _currentMode == GCWSwitchPosition.left
        ? GCWTextField(
          controller: _inputController,
          hintText: i18n(context, 'common_programming_hint_input'),
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        )
        : Container(),
        _buildOutput(),
      ]
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      BefungeOutput output = interpretBefunge(_currentDecodeText, input: _currentInput);
      String outputText = '';
      if (output.Error == '')
        outputText = output.Output;
      else
       outputText = output.Output + '\n' + i18n(context, output.Error);

      List<List<String>> columnData = <List<String>>[];
      columnData.add(['PC', 'Cmd', 'Mnemonic', 'Stack']);
      for (int i = 0; i < output.PC.length; i++) {
        columnData
            .add([output.PC[i], output.Command[i], output.Mnemonic[i], output.BefungeStack[i]]);
      }

      return Column(
        children: <Widget>[
          GCWDefaultOutput(
            child: outputText,
          ),
          GCWExpandableTextDivider(
            expanded: false,
            text: i18n(context, 'common_programming_debug'),
            child: Column(
                children: columnedMultiLineOutput(
                    context,
                    columnData,
                    flexValues: [2, 2, 3, 5],
                    suppressCopyButtons: true,
                    hasHeader: true,
                )),
          )
        ],
      );
    }

    else
      return GCWDefaultOutput(
                child:CodeField(
                  controller: _codeController,
                  textStyle: gcwMonotypeTextStyle(),
                  //textStyle: TextStyle(fontFamily: 'SourceCode'),
                ),
                trailing: Row(
                  children: <Widget>[
                    GCWIconButton(
                      iconColor: themeColors().mainFont(),
                      size: IconButtonSize.SMALL,
                      icon: Icons.content_copy,
                      onPressed: () {
                        var copyText = _codeController.text != null
                            ? _codeController.text
                            : '';
                        insertIntoGCWClipboard(context, copyText);
                      },
                    ),
                  ],
                ),
            );
  }


}
