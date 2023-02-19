import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toolbar.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/logic/symbol_table_data.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_replacer/logic/symbol_replacer.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_container.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_table_symbol_matrix.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_replacer/widget/symbol_replacer_symboldata.dart';
import 'package:prefs/prefs.dart';

part 'package:gc_wizard/tools/symbol_tables/symbol_replacer/widget/symbol_replacer_manual_setter.dart';

class SymbolReplacerManualControl extends StatefulWidget {
  final SymbolReplacerImage symbolImage;

  const SymbolReplacerManualControl({Key? key, required this.symbolImage}) : super(key: key);

  @override
  SymbolReplacerManualControlState createState() => SymbolReplacerManualControlState();
}

class SymbolReplacerManualControlState extends State<SymbolReplacerManualControl> {
  var _symbolMap = Map<Symbol, Map<String, SymbolData>>();
  SymbolData? _selectedSymbolData;
  var _removeActiv = false;
  var _addActiv = false;

  late TextEditingController _editValueController;

  @override
  void initState() {
    super.initState();
    _editValueController = TextEditingController();
  }

  @override
  void dispose() {
    _editValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.getInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_PORTRAIT)
        : Prefs.getInt(PREFERENCE_SYMBOLTABLES_COUNTCOLUMNS_LANDSCAPE);

    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      _buildEditRow(),
      _buildMatrix(widget.symbolImage, countColumns, mediaQueryData),
    ]);
  }

  Widget _buildMatrix(SymbolReplacerImage symbolImage, int countColumns, MediaQueryData mediaQueryData) {
    symbolImage.symbols.forEach((symbol) {
      if (_symbolMap.containsKey(symbol)) {
        var _symbolData = _symbolMap[symbol];
        var _displayText = symbol.symbolGroup?.text ?? '';
        if (_symbolData?.values.first.displayName != _displayText) {
          _symbolMap[symbol] = _cloneSymbolData(_symbolData!, _displayText);
        }
      }
      // else //ToDo Mike Nullsafety
      //   _symbolMap.addAll({
      //     symbol: {null: SymbolData(bytes: symbol.getImage(), displayName: symbol?.symbolGroup?.text ?? '')}
      //   });
    });

    return Expanded(
        child: GCWSymbolTableSymbolMatrix(
      fixed: false,
      imageData: _symbolMap.values,
      countColumns: countColumns,
      mediaQueryData: mediaQueryData,
      onChanged: () => setState(() {}),
      selectable: true,
      overlayOn: true,
      onSymbolTapped: (String tappedText, SymbolData imageData) {
        setState(() {
          _selectGroupSymbols(imageData, (imageData.primarySelected || imageData.secondarySelected));
        });
      },
    ));
  }

  void _selectGroupSymbols(SymbolData imageData, bool selected) {
    if (_selectedSymbolData == null) return;
    var _symbol = _getSymbol(_symbolMap,imageData);

    if (!(_addActiv || _removeActiv))
      _selectedSymbolData = selected ? imageData : null;
    else
      selected = _symbol?.symbolGroup == _getSymbol(_symbolMap,_selectedSymbolData!)?.symbolGroup;

    if (_addActiv && !selected && _symbol != null) {
      widget.symbolImage.addToGroup(_symbol, _getSymbol(_symbolMap,_selectedSymbolData!)?.symbolGroup);
      imageData.primarySelected = true;
      _symbol = _getSymbol(_symbolMap, _selectedSymbolData!);
      selected = true;
    }

    if (_removeActiv && selected && _symbol != null) {
      if (_selectedSymbolData == imageData) {
        var symbolGroup = _getSymbol(_symbolMap,_selectedSymbolData!)?.symbolGroup;
        widget.symbolImage.removeFromGroup(_symbol);
        if (symbolGroup != null)
          _selectedSymbolData = symbolGroup.symbols.isEmpty ? null : _symbolMap[symbolGroup.symbols.first]?.values.first;
      } else
        widget.symbolImage.removeFromGroup(_symbol);
      _symbol = _getSymbol(_symbolMap,_selectedSymbolData!);
    }

    if (selected)
      // reset all selections
      _symbolMap.values.forEach((image) {
        image.values.first.primarySelected = false;
      });

    if (_symbol?.symbolGroup?.symbols != null) {
      _symbol!.symbolGroup!.symbols.forEach((symbol) {
        var image = _symbolMap[symbol];
        if (image != null) {
          image.values.first.primarySelected = selected;
          _editValueController.text = image.values.first.displayName ?? '';
        }
      });
    }
  }

  SymbolReplacerSymbolData? _getGroupSymbol(SymbolData imageData) {
    var _symbol = _getSymbol(_symbolMap,imageData);
    if (_symbol?.symbolGroup != null) return _symbol!.symbolGroup?.compareSymbol;
    return null;
  }

  Widget _buildEditRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: [
              GCWToolBar(children: <Widget>[
                GCWIconButton(
                  icon: Icons.add_circle,
                  iconColor: _selectedSymbolData == null
                      ? themeColors().inActive()
                      : _addActiv
                          ? Colors.red
                          : null,
                  onPressed: () {
                    setState(() {
                      _addActiv = !_addActiv;
                      if (_addActiv) _removeActiv = false;
                    });
                  },
                ),
                GCWIconButton(
                  icon: Icons.remove_circle,
                  iconColor: _selectedSymbolData == null
                      ? themeColors().inActive()
                      : _removeActiv
                          ? Colors.red
                          : null,
                  onPressed: () {
                    setState(() {
                      _removeActiv = !_removeActiv;
                      if (_removeActiv) _addActiv = false;
                    });
                  },
                )
              ]),
              GCWButton(
                  text: i18n(context, 'symbol_replacer_letters_manually'),
                  onPressed: () {
                    _navigateToSubPage();
                  })
            ],
          ),
          flex: 1,
        ),
        _identifiedSymbol()
      ],
    );
  }

  Widget _identifiedSymbol() {
    if (widget.symbolImage.compareSymbols == null) {
      return Expanded(
        child: Column(children: [Container()]),
        flex: 1,
      );
    }

    return Expanded(
      child: Column(children: [
        AutoSizeText(i18n(context, 'symbol_replacer_symbol'),
            textAlign: TextAlign.center,
            style: gcwTextStyle().copyWith(fontSize: defaultFontSize() - 2),
            minFontSize: AUTO_FONT_SIZE_MIN,
            maxLines: 2),
        Container(height: 3),
        Row(children: [
          Expanded(child: Container(), flex: 1),
          Container(
              height: 80,
              child: _selectedSymbolData == null || _getGroupSymbol(_selectedSymbolData!)?.bytes == null
                  ? Container(width: 80, color: Colors.white)
                  : GCWSymbolContainer(symbol: Image.memory(_getGroupSymbol(_selectedSymbolData!)!.bytes!))),
          Expanded(child: Container(), flex: 1),
        ])
      ]),
      flex: 1,
    );
  }

  void _navigateToSubPage() {
    if (_selectedSymbolData == null) return;

    var selectedSymbols = <Symbol>[];
    _symbolMap.forEach((symbol, image) {
      var symbolData = image.values.first;
      if (symbolData.primarySelected || symbolData.secondarySelected) selectedSymbols.add(symbol);
    });

    var subPageTool = GCWTool(
        autoScroll: false,
        tool: SymbolReplacerManualSetter(symbolImage: widget.symbolImage, viewSymbols: selectedSymbols),
        id: 'symbol_replacer',
        searchKeys: ['symbol_replacer']);

    Navigator.push(context, NoAnimationMaterialPageRoute(builder: (context) => subPageTool)).whenComplete(() {
      setState(() {
        var _addActivTmp = _addActiv;
        var _removeActivTmp = _removeActiv;
        _addActiv = false;
        _removeActiv = false;
        _selectGroupSymbols(_selectedSymbolData!, true);
        _addActiv = _addActivTmp;
        _removeActiv = _removeActivTmp;
      });
    });
  }
}
