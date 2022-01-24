import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_derivate.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Brainfk extends StatefulWidget {
  final Function interpret;
  final Function generate;

  const Brainfk({Key key, this.interpret, this.generate}) : super(key: key);

  @override
  BrainfkState createState() => BrainfkState();
}

class BrainfkState extends State<Brainfk> {
  var _textController;
  var _inputController;
  var _inputController_shiftRight;
  var _inputController_shiftLeft;
  var _inputController_increaseValue;
  var _inputController_decreaseValue;
  var _inputController_output;
  var _inputController_input;
  var _inputController_startLoop;
  var _inputController_endLoop;

  var _currentDerivate = BRAINFKDERIVATE_OOK;

  var _currentText = '';
  var _currentInput = '';
  var _currentInput_shiftRight;
  var _currentInput_shiftLeft;
  var _currentInput_increaseValue;
  var _currentInput_decreaseValue;
  var _currentInput_output;
  var _currentInput_input;
  var _currentInput_startLoop;
  var _currentInput_endLoop;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentOriginal = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _currentText);
    _inputController = TextEditingController(text: _currentInput);
    _inputController_shiftRight = TextEditingController(text: _currentInput_shiftRight);
    _inputController_shiftLeft = TextEditingController(text: _currentInput_shiftLeft);
    _inputController_increaseValue = TextEditingController(text: _currentInput_increaseValue);
    _inputController_decreaseValue = TextEditingController(text: _currentInput_decreaseValue);
    _inputController_output = TextEditingController(text: _currentInput_output);
    _inputController_input = TextEditingController(text: _currentInput_input);
    _inputController_startLoop = TextEditingController(text: _currentInput_startLoop);
    _inputController_endLoop = TextEditingController(text: _currentInput_endLoop);
  }

  @override
  void dispose() {
    _textController.dispose();
    _inputController.dispose();
    _inputController_shiftRight.dispose();
    _inputController_shiftLeft.dispose();
    _inputController_increaseValue.dispose();
    _inputController_decreaseValue.dispose();
    _inputController_output.dispose();
    _inputController_input.dispose();
    _inputController_startLoop.dispose();
    _inputController_endLoop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'brainfk_interpret'),
          rightValue: i18n(context, 'brainfk_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'brainfk_original'),
          rightValue: i18n(context, 'brainfk_substitition'),
          value: _currentOriginal,
          onChanged: (value) {
            setState(() {
              _currentOriginal = value;
            });
          },
        ),
        _currentOriginal == GCWSwitchPosition.left
            ? Container()
            : Column(children: <Widget>[
                GCWDropDownButton(
                  value: _currentDerivate,
                  onChanged: (value) {
                    setState(() {
                      _currentDerivate = value;
                    });
                  },
                  items: BRAINFK_DERIVATES.entries.map((mode) {
                    return GCWDropDownMenuItem(
                      value: mode.key,
                      child: mode.value,
                    );
                  }).toList(),
                ),
                _currentDerivate == BRAINFKDERIVATE_CUSTOM
                    ? Column(children: [
                        GCWTextField(
                          controller: _inputController_shiftRight,
                          hintText: i18n(context, 'brainfk_input_greater'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_shiftRight = text;
                            });
                          },
                        ),
                        GCWTextField(
                          controller: _inputController_shiftLeft,
                          hintText: i18n(context, 'brainfk_input_smaller'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_shiftLeft = text;
                            });
                          },
                        ),
                        GCWTextField(
                          controller: _inputController_increaseValue,
                          hintText: i18n(context, 'brainfk_input_plus'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_increaseValue = text;
                            });
                          },
                        ),
                        GCWTextField(
                          controller: _inputController_decreaseValue,
                          hintText: i18n(context, 'brainfk_input_minus'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_decreaseValue = text;
                            });
                          },
                        ),
                        GCWTextField(
                          controller: _inputController_output,
                          hintText: i18n(context, 'brainfk_input_dot'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_output = text;
                            });
                          },
                        ),
                        GCWTextField(
                          controller: _inputController_input,
                          hintText: i18n(context, 'brainfk_input_komma'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_input = text;
                            });
                          },
                        ),
                        GCWTextField(
                          controller: _inputController_startLoop,
                          hintText: i18n(context, 'brainfk_input_open'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_startLoop = text;
                            });
                          },
                        ),
                        GCWTextField(
                          controller: _inputController_endLoop,
                          hintText: i18n(context, 'brainfk_input_close'),
                          onChanged: (text) {
                            setState(() {
                              _currentInput_endLoop = text;
                            });
                          },
                        ),
                      ])
                    : Container(),
              ]),
        GCWTextField(
          controller: _textController,
          hintText:
              _currentMode == GCWSwitchPosition.left ? i18n(context, 'brainfk_code') : i18n(context, 'brainfk_text'),
          onChanged: (text) {
            setState(() {
              _currentText = text;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _inputController,
                hintText: i18n(context, 'brainfk_input'),
                onChanged: (text) {
                  setState(() {
                    _currentInput = text;
                  });
                },
              )
            : Container(),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentOriginal == GCWSwitchPosition.left)
        try {
          return widget.interpret == null
              ? interpretBrainfk(_currentText, input: _currentInput)
              : widget.interpret(_currentText, input: _currentInput);
        } on FormatException catch (e) {
          return printErrorMessage(context, e.message);
        }
      else {
        if (_currentDerivate == BRAINFKDERIVATE_CUSTOM)
          try {
            return BrainfkDerivate(
              pointerShiftRightInstruction: _currentInput_shiftRight,
              pointerShiftLeftInstruction: _currentInput_shiftLeft,
              increaseValueInstruction: _currentInput_increaseValue,
              decreaseValueInstruction: _currentInput_decreaseValue,
              outputInstruction: _currentInput_output,
              inputInstruction: _currentInput_input,
              startLoopInstruction: _currentInput_startLoop,
              endLoopInstruction: _currentInput_endLoop
            ).interpretBrainfkDerivat(_currentText, input: _currentInput);
          } catch (e) {
            return printErrorMessage(context, 'brainfk_error_customundefined');
          }
        else
          return _currentDerivate.interpretBrainfkDerivat(_currentText, input: _currentInput);
      }
    } else {
      if (_currentOriginal == GCWSwitchPosition.left)
        return widget.generate == null ? generateBrainfk(_currentText) : widget.generate(_currentText);
      else {
        if (_currentDerivate == BRAINFKDERIVATE_CUSTOM)
          try {
            return BrainfkDerivate(
                pointerShiftRightInstruction: _currentInput_shiftRight,
                pointerShiftLeftInstruction: _currentInput_shiftLeft,
                increaseValueInstruction: _currentInput_increaseValue,
                decreaseValueInstruction: _currentInput_decreaseValue,
                outputInstruction: _currentInput_output,
                inputInstruction: _currentInput_input,
                startLoopInstruction: _currentInput_startLoop,
                endLoopInstruction: _currentInput_endLoop
            ).generateBrainfkDerivat(_currentText);
          } catch (e) {
            return printErrorMessage(context, 'brainfk_error_customundefined');
          }
        else
          return _currentDerivate.generateBrainfkDerivat(_currentText);
      }
    }
  }
}
