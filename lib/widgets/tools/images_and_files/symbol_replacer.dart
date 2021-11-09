import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/symbol_replacer.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_tool.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;


class SymbolReplacer extends StatefulWidget {
  final local.PlatformFile platformFile;

  const SymbolReplacer({Key key, this.platformFile}) : super(key: key);

  @override
  SymbolReplacerState createState() => SymbolReplacerState();
}

class SymbolReplacerState extends State<SymbolReplacer> {
  SymbolImage _symbolImage;
  local.PlatformFile _platformFile;
  double _blackLevel = 50.0;
  double _similarityLevel = 100.0;
  double _similarityCompareLevel = 80.0;
  var _currentSimpleMode = GCWSwitchPosition.left;
  List<GCWDropDownMenuItem> compareSymbolItems;
  GCWTool _currentCompareSymbolTableTool;
  SymbolTableData _currentSymbolTableData;

  ItemScrollController _scrollController;
  var _editValueController = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    _scrollController = ItemScrollController();

    List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(SymbolTable()),
      ].contains(className(element.tool));
    }).toList();

    var textStyle = gcwTextStyle();
    var descriptionTextStyle = gcwDescriptionTextStyle();

    compareSymbolItems =_toolList.map((tool) {
      return GCWDropDownMenuItem(
          value: tool,
          child: Row( children: [
            Container(
              child: tool.icon,
              margin: EdgeInsets.only(left: 2, top:2, bottom: 2, right: 10),
            ),
            Expanded(child:
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( tool.toolName,
                      style: textStyle),
                    Text(tool.description == null ? '': tool.description,
                        style: descriptionTextStyle),
              ])
            )
          ])
      );
    }).toList();
    compareSymbolItems.insert(0, GCWDropDownMenuItem(value:null, child: GCWText(text: 'no Symbol Table')));
  }

  @override
  void dispose() {
    _editValueController.forEach((element) {element.dispose();});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.platformFile != null) {
      _platformFile = widget.platformFile;
      _replaceSymbols();
    }

    return Column(children: <Widget>[
      GCWOpenFile(
        supportedFileTypes: SUPPORTED_IMAGE_TYPES,
        onLoaded: (_file) {
          if (_file == null) {
            showToast(i18n(context, 'common_loadfile_exception_notloaded'));
            return;
          }

          if (_file != null) {
            setState(() {
              _platformFile = _file;
              _symbolImage = null;
              _replaceSymbols();
            });
          }
        },
      ),
      GCWTwoOptionsSwitch(
        value: _currentSimpleMode,
        leftValue: i18n(context, 'common_mode_simple'),
        rightValue: i18n(context, 'common_mode_advanced'),
        onChanged: (value) {
          setState(() {
            _currentSimpleMode = value;
          });
        },
      ),
      _currentSimpleMode == GCWSwitchPosition.left ? Container() : _buildAdvancedModeControl(context),
      GCWDefaultOutput(
          child: _buildList(),
           trailing: Row(children: <Widget>[
             GCWIconButton(
               size: IconButtonSize.SMALL,
               iconData: Icons.zoom_in,
               onPressed: () {
                 setState(() {
                   // int newCountColumn = max(countColumns - 1, 1);
                   // mediaQueryData.orientation == Orientation.portrait
                   //     ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                   //     : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                 });
               },
             ),
             GCWIconButton(
               size: IconButtonSize.SMALL,
               iconData: Icons.zoom_out,
               onPressed: () {
                 setState(() {
                   // int newCountColumn = countColumns + 1;
                   // mediaQueryData.orientation == Orientation.portrait
                   //     ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                   //     : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                 });
               },
             ),
           ])
      ),
      _buildOutput()
    ]);
  }


  _replaceSymbols()  {
    _symbolImage = replaceSymbols(
        _platformFile.bytes,
        _blackLevel.toInt(),
        _similarityLevel,
        symbolImage: _symbolImage,
        compareSymbols: _currentSymbolTableData.images
    );
  }

  Widget _buildAdvancedModeControl(BuildContext context) {
    return Column(children: <Widget>[
      GCWSlider(
        title: 'Similarity Level',
        value: _similarityLevel,
        min: 0,
        max: 100,
        onChanged: (value) {
          setState(() {
            _similarityLevel = value;
          });
        }
      ),
      GCWSlider(
        title: 'Black Level',
        value: _blackLevel,
        min: 0,
        max: 100,
        onChanged: (value) {
          setState(() {
            _blackLevel = value;
          });
        }
      ),
      _buildSymbolTableDropDown(),
    ]);
  }

  Widget _buildSymbolTableDropDown() {
    return Column(children: <Widget>[
      GCWTextDivider(text: 'Symbol Table'),
      GCWDropDownButton(
        value: _currentCompareSymbolTableTool,
        onChanged: (value) {
          setState(() async {
            _currentCompareSymbolTableTool = value;
            _currentSymbolTableData = null;
            if (_currentCompareSymbolTableTool is GCWSymbolTableTool) {
              _currentSymbolTableData = SymbolTableData(context, (_currentCompareSymbolTableTool as GCWSymbolTableTool).symbolKey);
              await _currentSymbolTableData.initialize();
            }
            _replaceSymbols();
          });
        },
        items: compareSymbolItems,
      ),
      GCWSlider(
        title: 'Similarity Level',
        value: _similarityCompareLevel,
        min: 0,
        max: 100,
        onChanged: (value) {
          setState(() {
            _similarityCompareLevel = value;
          });
        }
      ),
    ]);
  }


  Widget _buildList() {
    if (_symbolImage == null)
      return Container();

    var odd = false;
    var index = 0;

    var rows = _symbolImage.symbolGroups.map((entry) {
      odd = !odd;
      TextEditingController controller;
      if (index <= _editValueController.length) {
        controller = TextEditingController();
        _editValueController.add(controller);
      } else
        controller = _editValueController[index];
      controller.text = entry.text;

      index ++;
      return _buildRow(entry, controller, odd);
    }).toList();

    return Column(children: rows);
  }

  Widget _buildRow(SymbolGroup entry, TextEditingController textEditingController, bool odd) {
    Widget output;

    var row = Container(
        child: Column(children: <Widget>[
          Row(
          children: <Widget>[
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration( border: Border.all(color: themeColors().mainFont()), borderRadius: BorderRadius.circular(4)),
                child: Image.memory(entry.getImage(),
                    height: 80
                  )
                ),
              flex: 2,
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
                child: Column(children: <Widget>[
                    GCWTextField(
                      controller: TextEditingController(text: entry.text),
                      autofocus: true,
                      onChanged: (text) {
                        setState(() {
                          entry.text = text;
                          _replaceSymbols();
                        });
                      },
                    ),

                    Row(children: <Widget>[
                        Expanded(child:
                          Text(entry.symbols.length.toString() +' Symbol(s)')
                        ),
                      GCWIconButton(
                        iconData: entry.viewGroupImage ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        onPressed: () {
                          setState(() {
                            entry.viewGroupImage = !entry.viewGroupImage;
                            //if (widget.onRemoveEntry != null) widget.onRemoveEntry(getEntryId(entry), context);
                          });
                        },
                      )
                    ],
                    ),
                ]),
                flex: 3),
            ],
          ),
          (entry.viewGroupImage != true)
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: entry.symbols.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    child: Image.memory(entry.symbols[index].getImage()),
                  )
                ),
              )
          ]),
        );

    if (odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }

    return output;
  }

  Widget _buildOutput() {
    if (_symbolImage == null)
      return Container();

    replaceSymbols(_platformFile.bytes, 50, 90, symbolImage: _symbolImage);
    var imageData = GCWImageViewData(local.PlatformFile(bytes: _symbolImage.getImage()));
    return Column(children: <Widget>[
      GCWDefaultOutput(child: GCWImageView(imageData: imageData)),
      GCWDefaultOutput(child: _symbolImage.getTextOutput())
    ]);
  }

  _exportFiles(BuildContext context, String fileName, List<Uint8List> data) async {
    createZipFile(fileName, '.' + fileExtension(FileType.PNG), data).then((bytes) async {
      var fileType = FileType.ZIP;
      var value = await saveByteDataToFile(context, bytes,
          'anim_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.' + fileExtension(fileType));

      if (value != null) showExportedFileDialog(context, fileType: fileType);
    });
  }
}

