import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/games/game_of_life.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/tools/games/game_of_life/game_of_life_board.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';

class GameOfLife extends StatefulWidget {
  @override
  GameOfLifeState createState() => GameOfLifeState();
}

const _KEY_CUSTOM_RULES = 'gameoflife_custom';

class GameOfLifeState extends State<GameOfLife> {
  List<List<List<bool>>> _boards;
  List<List<bool>> _currentBoard;
  var _currentStep = 0;

  var _currentSize = 12;
  var _currentWrapWorld = false;
  var _currentRules = 'gameoflife_conway';
  Map<String, GameOfLifeRules> _allRules;
  var _currentCustomSurvive = '';
  TextEditingController _currentCustomSurviveController;
  var _currentCustomBirth = '';
  TextEditingController _currentCustomBirthController;
  var _currentCustomInverse = false;

  var _maskInputFormatter = WrapperForMaskTextInputFormatter(
      mask: '*********',
      filter: {"*": RegExp(r'[012345678]')});

  @override
  void initState() {
    super.initState();

    _currentCustomSurviveController = TextEditingController(text: _currentCustomSurvive);
    _currentCustomBirthController = TextEditingController(text: _currentCustomBirth);

    _generateBoard();

    _allRules = DEFAULT_GAME_OF_LIFE_RULES;
    _allRules.putIfAbsent(_KEY_CUSTOM_RULES, () => null);
  }


  @override
  void dispose() {
    _currentCustomSurviveController.dispose();
    _currentCustomBirthController.dispose();

    super.dispose();
  }

  _generateBoard() {
    var _newBoard = List<List<bool>>.generate(_currentSize, (index) => List<bool>.generate(_currentSize, (index) => false));

    if (_currentBoard != null) {
      var limit = min(_currentSize, _currentBoard.length);

      for (int i = 0; i < limit; i++) {
        for (int j = 0; j < limit; j++) {
          _newBoard[i][j] = _currentBoard[i][j];
        }
      }
    }

    _boards = <List<List<bool>>>[];
    _boards.add(_newBoard);

    _currentBoard = List.from(_newBoard);
    _currentStep = 0;
  }

  _reset({List<List<bool>> board}) {
    _boards = <List<List<bool>>>[];
    _boards.add(board ?? List.from(_currentBoard));

    _currentStep = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          title: i18n(context, 'gameoflife_size'),
          min: 2,
          value: _currentSize,
          onChanged: (value) {
            setState(() {
              _currentSize = value;
              _generateBoard();
              _reset();
            });
          },
        ),
        GCWDropDownButton(
          title: i18n(context, 'gameoflife_rules'),
          value: _currentRules,
          items: _allRules.keys.map((rules) {
            if (rules == _KEY_CUSTOM_RULES)
              return GCWDropDownMenuItem(
                value: rules,
                child: i18n(context, rules)
              );

            return GCWDropDownMenuItem(
              value: rules,
              child: i18n(context, rules),
              subtitle: '${i18n(context, 'gameoflife_survive')}: ${_getSurvive(_allRules[rules])} / ${i18n(context, 'gameoflife_birth')}: ${_getBirth(_allRules[rules])}'
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentRules = value;
              if (_currentRules == _KEY_CUSTOM_RULES) {
                _currentWrapWorld = _currentCustomInverse;
              } else if (_allRules[_currentRules].isInverse) {
                _currentWrapWorld = true;
              }
              _reset();
            });
          },
        ),
        _currentRules == _KEY_CUSTOM_RULES
          ? Column(
              children: [
                GCWTextField(
                  title: i18n(context, 'gameoflife_survive'),
                  controller: _currentCustomSurviveController,
                  inputFormatters: [_maskInputFormatter],
                  onChanged: (text) {
                    setState(() {
                      _currentCustomSurvive = text;
                      _reset();
                    });
                  },
                ),
                GCWTextField(
                  title: i18n(context, 'gameoflife_birth'),
                  controller: _currentCustomBirthController,
                  inputFormatters: [_maskInputFormatter],
                  onChanged: (text) {
                    setState(() {
                      _currentCustomBirth = text;
                      _reset();
                    });
                  },
                ),
                GCWOnOffSwitch(
                  title: i18n(context, 'gameoflife_inverse'),
                  value: _currentCustomInverse,
                  onChanged: (value) {
                    setState(() {
                      _currentCustomInverse = value;
                      _reset();
                    });
                  },
                )
              ],
            )
          : Container(),
        GCWOnOffSwitch(
          title: i18n(context, 'gameoflife_wrapworld'),
          value: _currentWrapWorld,
          onChanged: (value) {
            setState(() {
              _currentWrapWorld = value;
              _reset();
            });
          },
        ),
        Container(
          constraints: BoxConstraints(maxWidth: min(500, MediaQuery.of(context).size.height * 0.8)),
          child: GameOfLifeBoard(
            state: _currentBoard,
            size: _currentSize,
            onChanged: (newBoard) {
              setState(() {
                _reset(board: newBoard);
              });
            },
          ),
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ),
        Row(
          children: [
            GCWIconButton(
              iconData: Icons.double_arrow,
              rotateDegrees: 180.0,
              onPressed: () {
                setState(() {
                  for (int i = 0; i < 10; i++)
                    _backwards();
                });
              },
            ),
            GCWIconButton(
              iconData: Icons.arrow_back_ios,
              onPressed: () {
                setState(() {
                  _backwards();
                });
              },
            ),
            Expanded(
              child: GCWText(
                align: Alignment.center,
                text: '${i18n(context, 'gameoflife_step')}: $_currentStep\n${i18n(context, 'gameoflife_livingcells', parameters: [_countCells()])}'
              ),
            ),
            GCWIconButton(
              iconData: Icons.arrow_forward_ios,
              onPressed: () {
                setState(() {
                  _forward();
                });
              },
            ),
            GCWIconButton(
              iconData: Icons.double_arrow,
              onPressed: () {
                setState(() {
                  for (int i = 0; i < 10; i++) {
                    _forward();
                  }
                });
              },
            ),
          ],
        ),
        GCWButton(
          text: _currentRules == _KEY_CUSTOM_RULES
              ? (_currentCustomInverse ? i18n(context, 'gameoflife_fillall') : i18n(context, 'gameoflife_clearall'))
              : (_allRules[_currentRules].isInverse ? i18n(context, 'gameoflife_fillall') : i18n(context, 'gameoflife_clearall')),
          onPressed: () {
            setState(() {
              var isInverse = (_currentRules == _KEY_CUSTOM_RULES && _currentCustomInverse) || (_currentRules != _KEY_CUSTOM_RULES && _allRules[_currentRules].isInverse);
              _currentBoard = List<List<bool>>.generate(_currentSize, (index) => List<bool>.generate(_currentSize, (index) => isInverse));

              _reset();
            });
          },
        )
      ],
    );
  }

  _forward() {
    _currentStep++;

    _calculateStep();
  }

  _backwards() {
    if (_currentStep > 0)
      _currentStep--;

    _calculateStep();
  }

  String _getSurvive(GameOfLifeRules rules) {
    GameOfLifeRules _rules;
    if (rules.isInverse) {
      _rules = rules.inverseRules();
    } else {
      _rules = rules;
    }

    var survivals = _rules.survivals.toList();
    survivals.sort();

    var out = survivals.join(',');
    if (out.isEmpty)
      return '-';
    return out;
  }

  String _getBirth(GameOfLifeRules rules) {
    GameOfLifeRules _rules;
    if (rules.isInverse) {
      _rules = rules.inverseRules();
    } else {
      _rules = rules;
    }

    var births = _rules.births.toList();
    births.sort();

    var out = births.join(',');
    if (out.isEmpty)
      return '-';
    return out;
  }

  _countCells() {
    var counter = 0;
    for (int i = 0; i < _currentSize; i++) {
      for (int j = 0; j < _currentSize; j++) {
        if (_currentBoard[i][j])
          counter++;
      }
    }

    return counter;
  }

  Set<int> _toSet(String input) {
    input = input.replaceAll(RegExp(r'[^0-8]'), '');
    return input.split('').map((e) => int.tryParse(e)).toSet();
  }

  _calculateStep() {
    if (_currentStep < _boards.length) {
      _currentBoard = List.from(_boards[_currentStep]);
      return;
    }

    var rules;
    if (_currentRules == _KEY_CUSTOM_RULES) {
      rules = GameOfLifeRules(survivals: _toSet(_currentCustomSurvive), births: _toSet(_currentCustomBirth), isInverse: _currentCustomInverse);
    } else {
      rules = _allRules[_currentRules];
    }

    _boards.add(calculateGameOfLifeStep(_currentBoard, rules, isWrapWorld: _currentWrapWorld));
    _currentBoard = List.from(_boards.last);
  }
}
