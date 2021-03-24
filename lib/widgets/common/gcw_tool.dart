import 'package:flutter/material.dart';
import 'package:prefs/prefs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

enum ToolCategory {
  CRYPTOGRAPHY,
  COORDINATES,
  FORMULA_SOLVER,
  GAMES,
  GENERAL_CODEBREAKERS,
  SCIENCE_AND_TECHNOLOGY,
  SYMBOL_TABLES
}

final SearchBlackList = {
  'der',
  'die',
  'das',
  'von',
  'drei',
  'zwei'
  'the',
  'two',
  'three',
  'deux',
  'trois',
  'de'
};

class GCWToolActionButtonsEntry {
  // to be used in registry to define a buttonlist which will be displayed in the app bar
  final bool showDialog; // - true, if the button should provide a dialog
  final String url; // - url for a download or website
  final String title; // - title-string to be shown in the dialog
  final String text; // - message-text to be shown in the dialog
  final IconData icon; // - icon tto be shown in the appbar

  GCWToolActionButtonsEntry(
      this.showDialog, this.url, this.title, this.text, this.icon);
}

class GCWTool extends StatefulWidget {
  final Widget tool;
  final String i18nPrefix;
  final ToolCategory category;
  final autoScroll;
  final iconPath;
  final List<String> searchStrings;
  final bool helpButton;
  final List<GCWToolActionButtonsEntry> buttonList;

  var icon;
  var _id = '';
  var _isFavorite = false;

  var toolName;
  var description;
  var example;

  GCWTool(
      {Key key,
      this.tool,
      this.toolName,
      this.i18nPrefix,
      this.category,
      this.autoScroll: true,
      this.iconPath,
      this.searchStrings,
      this.helpButton: true,
      this.buttonList})
      : super(key: key) {
    this._id = className(tool) + '_' + (i18nPrefix ?? '');
    this._isFavorite = Prefs.getStringList('favorites').contains('$_id');

    if (iconPath != null) {
      this.icon = GCWSymbolContainer(
        symbol: Image.asset(iconPath, width: DEFAULT_LISTITEM_SIZE),
      );
    }
  }

  bool get isFavorite {
    return this._isFavorite;
  }

  void set isFavorite(bool isFavorite) {
    _isFavorite = isFavorite;

    var _favorites = Prefs.getStringList('favorites');
    if (isFavorite && !_favorites.contains(_id)) {
      _favorites.add(_id);
    } else if (!isFavorite) {
      while (_favorites.contains(_id)) _favorites.remove(_id);
    }
    Prefs.setStringList('favorites', _favorites);
  }

  @override
  _GCWToolState createState() => _GCWToolState();
}

class _GCWToolState extends State<GCWTool> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.toolName),
          actions: _buildButtons(),
        ),
        body: _buildBody());
  }

  List<Widget> _buildButtons() {
    List<Widget> buttonList = new List<Widget>();
    String url = '';

    // add button with url for searching knowledge base with toolName
    final Locale appLocale = Localizations.localeOf(context);
    if (isLocaleSupported(appLocale))
      url = 'https://blog.gcwizard.net/manual/' +
          Localizations.localeOf(context).toString() +
          '/search/' +
          widget.toolName;
    else // fallback to en if unsupported locale
      url = 'https://blog.gcwizard.net/manual/' +
          'en' +
          '/search/' +
          widget.toolName;
    SearchBlackList.forEach((element) {
      url.replaceAll(element + ' ', '');
    });
    buttonList.add(IconButton(
      icon: Icon(Icons.auto_fix_high),
      onPressed: () {
        launch(url);
      },
    ));

    // add helpButton as hard-coded in json
    if (widget.helpButton) {
      buttonList.add(IconButton(
        icon: Icon(Icons.help),
        onPressed: () {
          launch(i18n(context, widget.i18nPrefix + '_online_help_url'));
        },
      ));
    }

    // add further buttons as defined in registry
    if (widget.buttonList != null) {
      widget.buttonList.forEach((button) {
        String url = '';
        if (button.url == '') // 404-Page asking for help
          url = i18n(context,
              'common_error_url'); // https://blog.gcwizard.net/manual/uncategorized/404/
        else
          url = button.url;
        if (button.url != null && button.url.length != 0)
          buttonList.add(IconButton(
            icon: Icon(button.icon),
            onPressed: () {
              if (button.showDialog) {
                showGCWAlertDialog(
                  context,
                  i18n(context, button.title),
                  i18n(context, button.text),
                  () {
                    launch(i18n(context, url));
                  },
                );
              } else
                launch(i18n(context, url));
            },
          ));
      });
    }

    return buttonList;
  }

  Widget _buildBody() {
    if (widget.tool is GCWSelection) return widget.tool;

    if (widget.autoScroll == false) return widget.tool;

    return SingleChildScrollView(
        child: Padding(child: widget.tool, padding: EdgeInsets.all(10)));
  }
}
