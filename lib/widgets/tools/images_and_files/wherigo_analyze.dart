import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo_analyze.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_textviewer.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:audioplayers/audioplayers.dart';

class WherigoAnalyze extends StatefulWidget {

  @override
  WherigoAnalyzeState createState() => WherigoAnalyzeState();
}

class WherigoAnalyzeState extends State<WherigoAnalyze> {
  ScrollController _scrollControllerHex;

  Uint8List _bytes;
  WherigoCartridge _cartridge;
  var _cartridgeData = WHERIGO.HEADER;
  SplayTreeMap<String, WHERIGO> _WHERIGO_DATA;
  int _mediaFile = 1;

  @override
  void initState() {
    _scrollControllerHex = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerHex.dispose();

    super.dispose();
  }

  _setData(Uint8List bytes) {
    _bytes = bytes;
  }

  @override
  Widget build(BuildContext context) {
    _WHERIGO_DATA = SplayTreeMap.from(
        switchMapKeyValue(WHERIGO_DATA).map((key, value) => MapEntry(i18n(context, key), value)));
    return Column(
      children: <Widget>[
        GCWOpenFile(
          onLoaded: (_file) {
            if (_file == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            if (_file != null) {
              _setData(_file.bytes);

              setState(() {});
            }
          },
        ),
        GCWDropDownButton(
          value: _cartridgeData,
          onChanged: (value) {
            setState(() {
              _cartridgeData = value;
            });
          },
          items: _WHERIGO_DATA.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.value,
              child: mode.key,
            );
          }).toList(),
        ),GCWDefaultOutput(
            child: _buildOutput(),
            trailing: GCWIconButton(
              iconData: Icons.text_snippet_outlined,
              size: IconButtonSize.SMALL,
              onPressed: () {
                openInTextViewer(context, String.fromCharCodes(_bytes ?? []));
              },
            ))
      ],
    );
  }

  _buildOutput() {
    if (_bytes == null) return null;

    _cartridge = getCartridge(_bytes);
//    String _hexData = file2hexstring(bytes);
//    return GCWText(
//      text: _bytes.join(' '),
//      style: gcwMonotypeTextStyle(),
//    );
    var _output = [
      [i18n(context, 'wherigo_header_signature'), _cartridge.Signature],
      [i18n(context, 'wherigo_header_numberofobjects'), (_cartridge.NumberOfObjects - 1).toString()],
      [i18n(context, 'wherigo_header_latitude'), _cartridge.Latitude.toString()],
      [i18n(context, 'wherigo_header_longitude'), _cartridge.Longitude.toString()],
      [i18n(context, 'wherigo_header_altitude'), _cartridge.Altitude.toString()],
      [i18n(context, 'wherigo_header_typeofcartridge'), _cartridge.TypeOfCartridge],
      [i18n(context, 'wherigo_header_splashicon'), _cartridge.SplashscreenIcon],
      [i18n(context, 'wherigo_header_splashscreen'), _cartridge.Splashscreen],
      [i18n(context, 'wherigo_header_player'), _cartridge.Player],
      [i18n(context, 'wherigo_header_playerid'), _cartridge.PlayerID.toString()],
      [i18n(context, 'wherigo_header_cartridgename'), _cartridge.CartridgeName],
      [i18n(context, 'wherigo_header_cartridgeguid'), _cartridge.CartridgeGUID],
      [i18n(context, 'wherigo_header_cartridgedescription'), _cartridge.CartridgeDescription],
      [i18n(context, 'wherigo_header_startinglocation'), _cartridge.StartingLocationDescription],
      [i18n(context, 'wherigo_header_version'), _cartridge.Version],
      [i18n(context, 'wherigo_header_creationdate'), _getCreationDate(_cartridge.DateOfCreation)],
      [i18n(context, 'wherigo_header_author'), _cartridge.Author],
      [i18n(context, 'wherigo_header_company'), _cartridge.Company],
      [i18n(context, 'wherigo_header_device'), _cartridge.RecommendedDevice],
      [i18n(context, 'wherigo_header_completion'), _cartridge.CompletionCode],
    ];

        switch (_cartridgeData){
      case WHERIGO.HEADER:
        return Column(children: columnedMultiLineOutput(context, _output));
        break;
      case WHERIGO.MEDIA:
        return Column(
          children: <Widget>[
            GCWIntegerSpinner(
              min: 1,
              max: _cartridge.NumberOfObjects - 1,
              value: _mediaFile,
              onChanged: (value) {
                setState(() {
                  _mediaFile = value;
                });
              },            ),
            GCWText(
              text: OBJECTTYPE[_cartridge.MediaFilesContents[1].MediaFileType],
            ),
            if (_cartridge.MediaFilesContents[_mediaFile].MediaFileType == MEDIATYPE_TXT)
              Column(
                children: <Widget>[
                  GCWText(
                    text: _getTextFromBytelist(_cartridge.MediaFilesContents[_mediaFile].MediaFileBytes),
                  ),
                ],
              ),
            if (_cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_BMP ||
                _cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_PNG ||
                _cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_JPG ||
                _cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_GIF)
              Column(
                children: <Widget>[
                  Image.memory(_cartridge.MediaFilesContents[_mediaFile].MediaFileBytes),
                ],
              ),
            if (_cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_WAV ||
                _cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_OGG ||
                _cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_MP3 ||
                _cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_SND)
              _playLocal(_cartridge.MediaFilesContents[_mediaFile].MediaFileBytes),
            if (_cartridge.MediaFilesContents[1].MediaFileType == MEDIATYPE_FDL)
              GCWText(
                text: OBJECTTYPE[_cartridge.MediaFilesContents[1].MediaFileType],
              ),
    ],
        );
        break;
      case WHERIGO.CHARACTER:
      case WHERIGO.ITEMS:
      case WHERIGO.TASKS:
      case WHERIGO.ZONES:
      case WHERIGO.LUA:
      case WHERIGO.INPUTS:
        return Container();
    }
  }
}

String _getCreationDate(int duration){
  // Date of creation   ; Seconds since 2004-02-10 01:00:00
  return (DateTime(2004, 2, 1, 1, 0, 0, 0).add(Duration(seconds: duration))).toString();
}

String _getTextFromBytelist(Uint8List bytes){
  String result = '';
  bytes.forEach((element) {
    result = result + String.fromCharCode(element);
  });
  return result;
}

_playLocal(Uint8List byteData) async {
  AudioPlayer audioPlayer = AudioPlayer();
  int result = await audioPlayer.playBytes(byteData);
}

