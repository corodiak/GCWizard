import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/utils/string_utils.dart';


import 'dialogs/gcw_delete_alertdialog.dart';
import 'dialogs/gcw_dialog.dart';
import 'gcw_popup_menu.dart';
import 'gcw_text_export.dart';


class GCWFormulaListEditor extends StatefulWidget {
  final GCWTool Function(String name) buildGCWTool;
  final void Function(String)? onAddEntry;
  final void Function()? onListChanged;
  final String? newEntryHintText;
  final Widget? middleWidget;
  final List<FormulaBase> formulaList;

  const GCWFormulaListEditor({
    Key? key,
    required this.buildGCWTool,
    required this.onAddEntry,
    this.onListChanged,
    this.newEntryHintText,
    this.middleWidget,
    required this.formulaList,
  }) : super(key: key);

  @override
  _GCWFormulaListEditor createState() => _GCWFormulaListEditor();
}

class _GCWFormulaListEditor extends State<GCWFormulaListEditor> {
  late TextEditingController _newEntryController;
  late TextEditingController _editEntryController;
  var _currentNewName = '';
  var _currentEditedName = '';

  int? _currentEditId;

  late FocusNode _focusNodeEditValue;

  @override
  void initState() {
    super.initState();

    _newEntryController = TextEditingController(text: _currentNewName);
    _editEntryController = TextEditingController(text: _currentEditedName);

    _focusNodeEditValue = FocusNode();
  }

  @override
  void dispose() {
    _newEntryController.dispose();
    _editEntryController.dispose();

    _focusNodeEditValue.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[_buildInput(), _buildMiddleWidget(), _buildList()]);
  }

  Widget _buildInput() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 2,
            ),
            child: GCWTextField(
              hintText: widget.newEntryHintText,
              controller: _newEntryController,
              onChanged: (text) {
                setState(() {
                  _currentNewName = text;
                });
              },
            ),
          ),
        ),
        GCWIconButton(
          icon: Icons.add,
          onPressed: () {
            _addEntry(_currentNewName);
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _buildMiddleWidget() {
    return widget.middleWidget ?? Container();
  }

  Widget _buildList() {
    var odd = false;

    var rows = widget.formulaList.map((entry) {
      odd = !odd;
      return _buildRow(entry, odd);
    }).toList();

    return Column(children: rows);
  }

  Widget _buildRow(FormulaBase entry, bool odd) {
    var formulaTool = widget.buildGCWTool(entry.name);

    Future<void> _navigateToSubPage(BuildContext context) async {
      Navigator.push(context, NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => formulaTool)).whenComplete(() {
        setState(() {});
      });
    }

    Widget output;

    var row = InkWell(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _currentEditId == entry.id
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: 2,
                      ),
                      child: GCWTextField(
                        controller: _editEntryController,
                        autofocus: true,
                        onChanged: (text) {
                          setState(() {
                            _currentEditedName = text;
                          });
                        },
                      ),
                    )
                  : IgnorePointer(
                      child: Column(
                        children: <Widget>[
                          GCWText(text: entry.name),
                          (entry.subFormulaCount >= 0)
                            ? Container(
                                padding: const EdgeInsets.only(left: DEFAULT_DESCRIPTION_MARGIN),
                                child: GCWText(
                                  text: '${entry.subFormulaCount} ' +
                                      i18n(context,
                                          entry.subFormulaCount == 1 ? 'formulasolver_formula' : 'formulasolver_formulas'),
                                  style: gcwDescriptionTextStyle(),
                                ),
                              )
                            : Container(),
                        ],
                      )
                    ),
            ),
            _currentEditId == entry.id
                ? GCWIconButton(
                    icon: Icons.check,
                    onPressed: () {
                      _updateEntry(_currentEditId!, _currentEditedName);

                      setState(() {
                        _currentEditId = null;
                        _editEntryController.clear();
                      });
                    }
                  )
                : Container(),
            GCWPopupMenu(
                iconData: Icons.settings,
                menuItemBuilder: (context) => [
                  GCWPopupMenuItem(
                      child: iconedGCWPopupMenuItem(context, Icons.edit, 'formulasolver_groups_editgroup'),
                      action: (index) => setState(() {
                        _currentEditId = entry.id;
                        _currentEditedName = entry.name;
                        _editEntryController.text = entry.name;
                      })),
                  GCWPopupMenuItem(
                      child: iconedGCWPopupMenuItem(context, Icons.delete, 'formulasolver_groups_removegroup'),
                      action: (index) => showDeleteAlertDialog(context, entry.name, () {
                        if (entry.id != null) _removeEntry(entry.id!);
                        setState(() {});
                      })),
                  GCWPopupMenuItem(
                      child: iconedGCWPopupMenuItem(context, Icons.forward, 'formulasolver_groups_exportgroup'),
                      action: (index) => _exportGroup(entry)),
                ])
          ],
        ),
        onTap: () {
          _navigateToSubPage(context);
        });

    if (odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }
    odd = !odd;

    return output;
  }

  void _addEntry(String name) {
    if (widget.onAddEntry != null) {
      widget.onAddEntry!(name);
    }
  }

  void _updateEntry(int id, String name) {
    var entry = widget.formulaList.firstWhereOrNull((formula) => formula.id == id);
    if (entry != null) {
      entry.name = name;
      _listChanged();
    }
  }
  void _removeEntry(int id) {
    var entry = widget.formulaList.firstWhereOrNull((formula) => formula.id == id);
    if (entry != null) {
      widget.formulaList.remove(entry);
      _listChanged();
    }
  }

  void _listChanged() {
    if (widget.onListChanged != null) {
      widget.onListChanged!();
    }
  }

  void _exportGroup(FormulaBase entry) {
    var mode = TextExportMode.QR;
    String text = jsonEncode(entry.toMap()).toString();
    text = normalizeCharacters(text);

    var contentWidget = GCWTextExport(
      text: text,
      onModeChanged: (value) {
        mode = value;
      },
    );
    showGCWDialog(
        context,
        i18n(context, 'formulasolver_groups_exportgroup'),
        contentWidget,
        [
          GCWDialogButton(
            text: i18n(context, 'common_exportfile_saveoutput'),
            onPressed: () {
              exportFile(text, mode, context);
            },
          ),
          const GCWDialogButton(
            text: 'OK',
          )
        ],
        cancelButton: false);
  }
}
