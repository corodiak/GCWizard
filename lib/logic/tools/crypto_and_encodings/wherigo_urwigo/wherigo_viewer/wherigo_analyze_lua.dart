import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'dart:async';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


String _answerVariable = '';

bool isInvalidLUASourcecode(String header) {
  return (!header.replaceAll('(', ' ').replaceAll(')', '').startsWith('require "Wherigo"'));
}

Future<Map<String, dynamic>> getCartridgeLUA(Uint8List byteListLUA, bool online, {SendPort sendAsyncPort}) async {
// if offline == true byteListLUA is already the source code
// if offline == false then byteListLUA has to be decompiled
  var out = Map<String, dynamic>();

  String _httpCode = '';
  String _httpMessage = '';
  String _LUAFile = '';

  if (online) {
    // https://medium.com/nerd-for-tech/multipartrequest-in-http-for-sending-images-videos-via-post-request-in-flutter-e689a46471ab

    String address = 'http://sdklmfoqdd5qrtha.myfritz.net:7323/GCW_Unluac/';
    try {
      var uri = Uri.parse(address);
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromBytes('file', byteListLUA,
            contentType: MediaType('application', 'octet-stream')));
      var response = await request.send();

      _httpCode = response.statusCode.toString();
      _httpMessage = response.reasonPhrase;
      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        _LUAFile = responseData.body;
      } else {
        out.addAll({
          'WherigoCartridgeLUA': WherigoCartridgeLUA(
              LUAFile: _LUAFile,
              Characters: [],
              Items: [],
              Tasks: [],
              Inputs: [],
              Zones: [],
              Timers: [],
              Media: [],
              Messages: [],
              Answers: [],
              Variables: [],
              NameToObject: {},
              ResultStatus: ANALYSE_RESULT_STATUS.ERROR_HTTP,
              ResultsLUA: ['wherigo_http_code_http', HTTP_STATUS[_httpCode]],
              httpCode: _httpCode,
              httpMessage: _httpMessage)
        });
        return out;
      }
    } catch (exception) {
      //SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 192.168.178.93, port = 57582
      _httpCode = '503';
      _httpMessage = exception.toString();
      out.addAll({
        'WherigoCartridgeLUA': WherigoCartridgeLUA(
            LUAFile: _LUAFile,
            Characters: [],
            Items: [],
            Tasks: [],
            Inputs: [],
            Zones: [],
            Timers: [],
            Media: [],
            Messages: [],
            Answers: [],
            Variables: [],
            NameToObject: {},
            ResultStatus: ANALYSE_RESULT_STATUS.ERROR_HTTP,
            ResultsLUA: ['wherigo_code_http_503', _httpMessage],
            httpCode: _httpCode,
            httpMessage: _httpMessage)
      });
      return out;
    } // end catch exception
  } // end if not offline
  else
    _LUAFile = String.fromCharCodes(byteListLUA);

  // normalize LUA File
  _LUAFile = _normalizeLUAmultiLineText(_LUAFile);

  List<String> _ResultsLUA = [];
  ANALYSE_RESULT_STATUS _Status = ANALYSE_RESULT_STATUS.OK;

  FILE_LOAD_STATE checksToDo = FILE_LOAD_STATE.NULL;

  if ((byteListLUA != [] || byteListLUA != null || _LUAFile != '')) checksToDo = FILE_LOAD_STATE.LUA;

  if (checksToDo == FILE_LOAD_STATE.NULL) {
    _ResultsLUA.add('wherigo_error_empty_lua');
    out.addAll({
      'WherigoCartridgeLUA': WherigoCartridgeLUA(
          LUAFile: '',
          Characters: [],
          Items: [],
          Tasks: [],
          Inputs: [],
          Zones: [],
          Timers: [],
          Media: [],
          Messages: [],
          Answers: [],
          Variables: [],
          NameToObject: {},
          ResultStatus: ANALYSE_RESULT_STATUS.ERROR_LUA,
          ResultsLUA: _ResultsLUA,
          httpCode: '',
          httpMessage: '')
    });
    return out;
  }

  String _LUACartridgeName = '';
  String _CartridgeLUAName = '';
  String _LUACartridgeGUID = '';
  String _obfuscatorTable = '';
  List<CharacterData> _Characters = [];
  List<ItemData> _Items = [];
  List<TaskData> _Tasks = [];
  List<InputData> _Inputs = [];
  List<ZoneData> _Zones = [];
  List<TimerData> _Timers = [];
  List<MediaData> _Media = [];
  List<List<ActionMessageElementData>> _Messages = [];
  List<AnswerData> _Answers = [];
  List<VariableData> _Variables = [];
  Map<String, ObjectData> _NameToObject = {};

  bool sectionMedia = true;
  bool sectionInner = true;
  bool sectionZone = true;
  bool sectionDescription = true;
  bool sectionCharacter = true;
  bool sectionItem = true;
  bool sectionTask = true;
  bool sectionTimer = true;
  bool sectionMessages = true;
  bool sectionInput = true;
  bool sectionChoices = true;
  bool sectionText = true;
  bool sectionAnalysed = false;
  bool insideInputFunction = false;
  bool sectionVariables = true;
  bool beyondHeader = false;

  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String type = '';
  String medianame = '';
  String alttext = '';
  String _cartridgeName = '';
  BUILDER _builder = BUILDER.UNKNOWN;
  String _BuilderVersion = '';
  String _TargetDeviceVersion = '';
  String _CountryID = '';
  String _StateID = '';
  String _UseLogging = '';
  String _CreateDate = '';
  String _PublishDate = '';
  String _UpdateDate = '';
  String _LastPlayedDate = '';
  List<ZonePoint> points = [];
  String visible = '';
  String media = '';
  String icon = '';
  String active = '';
  String distanceRange = '';
  String showObjects = '';
  String proximityRange = '';
  ZonePoint originalPoint;
  String distanceRangeUOM = '';
  String proximityRangeUOM = '';
  String outOfRange = '';
  String inRange = '';
  String location = '';
  ZonePoint zonePoint = ZonePoint(0.0, 0.0, 0.0);
  String gender = '';
  String container = '';
  String locked = '';
  String opened = '';
  String complete = '';
  String correctstate = '';
  List<String> declaration = [];
  String duration = '';
  List<ActionMessageElementData> singleMessageDialog = [];
  String variableID = '';
  String inputType = '';
  String text = '';
  List<String> listChoices = [];
  String inputObject = '';
  List<InputData> resultInputs = [];
  List<ActionMessageElementData> answerActions = [];
  List<String> answerList = [];
  ActionMessageElementData action;
  Map<String, List<AnswerData>> Answers = {};
  String _obfuscatorFunction = '';

  // get cartridge details

  // get obfuscator data
  _obfuscatorFunction = 'NO_OBFUSCATOR';
  bool _obfuscatorFound = false;
  if (RegExp(r'(WWB_latin1_string)').hasMatch(_LUAFile)) {
    _obfuscatorFunction = 'WWB_deobf';
    _obfuscatorTable = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~';
    _obfuscatorFound = true;
  } else if (RegExp(r'(gsub_wig)').hasMatch(_LUAFile)) {
    _obfuscatorFunction = 'gsub_wig';
    _obfuscatorTable = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~';
    _obfuscatorFound = true;
  }

  // get builder
  if (RegExp(r'(_Urwigo)').hasMatch(_LUAFile))
    _builder = BUILDER.URWIGO;
  else if (RegExp(r'(WWB_deobf)').hasMatch(_LUAFile)) {
    _builder = BUILDER.EARWIGO;
  } else if (RegExp(r'(gsub_wig)').hasMatch(_LUAFile)) {
    _builder = BUILDER.WHERIGOKIT;
  }

  // get all objects -----------------------------------------------------------
  int index = 0;
  List<String> lines = _LUAFile.split('\n');
  var progress = 0;
  int progressStep = max(lines.length ~/ 100, 1); // 100 steps

  for (int i = 0; i < lines.length; i++) {
    progress++;
    if (sendAsyncPort != null && (progress % progressStep == 0)) {
      sendAsyncPort.send({'progress': progress / lines.length});
    }

    // get obfuscator function
    if (lines[i].startsWith('function') && !_obfuscatorFound) {
      _obfuscatorFunction = lines[i].substring(9);
      _obfuscatorFound = true;
      for (int j = _obfuscatorFunction.length - 1; j > 0; j--) {
        if (_obfuscatorFunction[j] == '(') {
          _obfuscatorFunction = _obfuscatorFunction.substring(0, j);
          j = 0;
        }
      }
    }

    if (RegExp(r'(local dtable = ")').hasMatch(lines[i])) {
      _obfuscatorTable = lines[i].substring(0, lines[i].length - 1);
      _obfuscatorTable = _obfuscatorTable.trimLeft().replaceAll('local dtable = "', '');
    }

    if (RegExp(r'(Wherigo.ZCartridge)').hasMatch(lines[i])) {
      _CartridgeLUAName = lines[i].replaceAll('=', '').replaceAll(' ', '').replaceAll('Wherigo.ZCartridge()', '');
    }

    try {
      if (RegExp(r'(Wherigo.ZMedia)').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = OBJECT_TYPE.MEDIA;
        index++;
        LUAname = '';
        id = '';
        name = '';
        description = '';
        type = '';
        medianame = '';
        alttext = '';

        LUAname = getLUAName(lines[i]);

        sectionMedia = true;
        do {
          i++;
          if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Id')) {
            id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Name')) {
            name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Description')) {
            if (lines[i + 1].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
              description = getLineData(lines[i], LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
            } else {
              sectionInner = true;
              description = lines[i].trim().replaceAll(LUAname + '.', '');
              i++;
              do {
                if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText'))
                  sectionInner = false;
                else
                  description = description + lines[i];
                i++;
              } while (sectionInner);
            }
            if (description.startsWith('WWB_multi')) description = removeWWB(description);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
            alttext = getLineData(lines[i], LUAname, 'AltText', _obfuscatorFunction, _obfuscatorTable);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Resources')) {
            i++;
            sectionInner = true;
            do {
              if (lines[i].trimLeft().startsWith('Filename = ')) {
                medianame = getStructData(lines[i], 'Filename');
              } else if (lines[i].trimLeft().startsWith('Type = ')) {
                type = getStructData(lines[i], 'Type');
              } else if (lines[i].trimLeft().startsWith('Directives = ')) {
                sectionInner = false;
                sectionMedia = false;
              }
              i++;
            } while (sectionInner);
          }

          if (RegExp(r'(Wherigo.ZCharacter\()').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZMedia)').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZItem)').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZTask)').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZTimer)').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZInput)').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.Zone\()').hasMatch(lines[i])) {
            sectionMedia = false;
          }
        } while (sectionMedia && (i < lines.length - 1));

        _Media.add(MediaData(
          LUAname,
          id,
          name,
          description,
          alttext,
          type,
          medianame,
        ));
        _NameToObject[LUAname] = ObjectData(id, index, name, medianame, OBJECT_TYPE.MEDIA);
      } // end if line hasmatch zmedia
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_media');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    if (RegExp(r'( Wherigo.ZCartridge)').hasMatch(lines[i])) {
      _cartridgeName = lines[i].replaceAll('= Wherigo.ZCartridge()', '').trim();
      beyondHeader = true;
    }

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.Name')) {
      _LUACartridgeName = lines[i].replaceAll(_cartridgeName + '.Name = ', '').replaceAll('"', '').trim();
    }

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.Id')) {
      _LUACartridgeGUID = lines[i].replaceAll(_cartridgeName + '.Id = ', '').replaceAll('"', '').trim();
    }

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.BuilderVersion'))
      _BuilderVersion = lines[i].replaceAll(_cartridgeName + '.BuilderVersion = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.TargetDeviceVersion'))
      _TargetDeviceVersion =
          lines[i].replaceAll(_cartridgeName + '.TargetDeviceVersion = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.CountryId'))
      _CountryID = lines[i].replaceAll(_cartridgeName + '.CountryId = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.StateId'))
      _StateID = lines[i].replaceAll(_cartridgeName + '.StateId = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.UseLogging'))
      _UseLogging = lines[i].replaceAll(_cartridgeName + '.UseLogging = ', '').replaceAll('"', '').trim().toLowerCase();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.CreateDate'))
      _CreateDate = lines[i].replaceAll(_cartridgeName + '.CreateDate = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.PublishDate'))
      _PublishDate = lines[i].replaceAll(_cartridgeName + '.PublishDate = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.UpdateDate'))
      _UpdateDate = lines[i].replaceAll(_cartridgeName + '.UpdateDate = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.LastPlayedDate'))
      _LastPlayedDate = lines[i].replaceAll(_cartridgeName + '.LastPlayedDate = ', '').replaceAll('"', '').trim();

    try {
      if (RegExp(r'( Wherigo.Zone\()').hasMatch(lines[i])) {
        beyondHeader = true;

        currentObjectSection = OBJECT_TYPE.ZONE;
        points = [];
        LUAname = '';
        id = '';
        name = '';
        description = '';
        visible = '';
        media = '';
        icon = '';
        active = '';
        distanceRange = '';
        showObjects = '';
        proximityRange = '';
        originalPoint;
        distanceRangeUOM = '';
        proximityRangeUOM = '';
        outOfRange = '';
        inRange = '';

        LUAname = getLUAName(lines[i]);

        sectionZone = true;
        do {
          i++;
          if (lines[i].startsWith(LUAname + '.Id'))
            id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Name'))
            name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            do {
              description = description + lines[i];
              i++;
              if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) sectionDescription = false;
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description =
                getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable).trim();
            if (description.startsWith('WWB_multi')) description = removeWWB(description);
          }

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Active'))
            active = getLineData(lines[i], LUAname, 'Active', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.DistanceRangeUOM ='))
            distanceRangeUOM =
                getLineData(lines[i], LUAname, 'DistanceRangeUOM', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.ProximityRangeUOM ='))
            proximityRangeUOM =
                getLineData(lines[i], LUAname, 'ProximityRangeUOM', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.DistanceRange ='))
            distanceRange = getLineData(lines[i], LUAname, 'DistanceRange', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.ShowObjects'))
            showObjects = getLineData(lines[i], LUAname, 'ShowObjects', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.ProximityRange ='))
            proximityRange = getLineData(lines[i], LUAname, 'ProximityRange', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.OriginalPoint')) {
            String point = getLineData(lines[i], LUAname, 'OriginalPoint', _obfuscatorFunction, _obfuscatorTable);
            List<String> pointdata =
                point.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '').split(',');
            originalPoint =
                ZonePoint(double.parse(pointdata[0]), double.parse(pointdata[1]), double.parse(pointdata[2]));
          }

          if (lines[i].startsWith(LUAname + '.OutOfRangeName'))
            outOfRange = getLineData(lines[i], LUAname, 'OutOfRangeName', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.InRangeName'))
            inRange = getLineData(lines[i], LUAname, 'InRangeName', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Points = ')) {
            i++;
            do {
              while (lines[i].trimLeft().startsWith('ZonePoint')) {
                points.add(_getPoint(lines[i]));
                i++;
              }
            } while (lines[i].trimLeft().startsWith('ZonePoint'));
          }

          if (RegExp(r'( Wherigo.ZCharacter\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.Zone\()').hasMatch(lines[i])) {
            sectionZone = false;
          }
        } while (sectionZone);
        i--;

        _Zones.add(ZoneData(
          LUAname,
          id,
          name,
          description,
          visible,
          media,
          icon,
          active,
          distanceRange,
          showObjects,
          proximityRange,
          originalPoint,
          distanceRangeUOM,
          proximityRangeUOM,
          outOfRange,
          inRange,
          points,
        ));
        _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.ZONE);
      }
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_zones');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    try {
      if (RegExp(r'( Wherigo.ZCharacter)').hasMatch(lines[i])) {
        beyondHeader = true;

        currentObjectSection = OBJECT_TYPE.CHARACTER;
        LUAname = '';
        id = '';
        name = '';
        description = '';
        visible = '';
        media = '';
        icon = '';
        location = '';
        gender = '';
        type = '';

        LUAname = getLUAName(lines[i]);
        container = getContainer(lines[i]);

        sectionCharacter = true;

        do {
          i++;
          if (lines[i].trim().startsWith(LUAname + '.Container =')) {
            container = getContainer(lines[i]);
          }

          if (lines[i].trim().startsWith(LUAname + '.Id')) {
            id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Name')) {
            name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            do {
              description = description + lines[i];
              if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible')) {
                sectionDescription = false;
              }
              i++;
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable).trim();

          if (lines[i].startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
            location =
                lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
            if (location.endsWith('INVALID_ZONEPOINT'))
              location = '';
            else if (location.startsWith('ZonePoint')) {
              location = location.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '');
              zonePoint = ZonePoint(double.parse(location.split(',')[0]), double.parse(location.split(',')[1]),
                  double.parse(location.split(',')[2]));
              location = 'ZonePoint';
            } else
              location = getLineData(lines[i], LUAname, 'ObjectLocation', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Gender')) {
            gender =
                getLineData(lines[i], LUAname, 'Gender', _obfuscatorFunction, _obfuscatorTable).toLowerCase().trim();
          }

          if (lines[i].startsWith(LUAname + '.Type'))
            type = getLineData(lines[i], LUAname, 'Type', _obfuscatorFunction, _obfuscatorTable);

          if (RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZCharacter)').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i])) {
            sectionCharacter = false;
          }
        } while (sectionCharacter);

        _Characters.add(CharacterData(
            LUAname, id, name, description, visible, media, icon, location, zonePoint, container, gender, type));
        _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.CHARACTER);
        i--;
      } // end if
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_characters');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    try {
      if (RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i])) {
        beyondHeader = true;

        currentObjectSection = OBJECT_TYPE.ITEM;
        LUAname = '';
        container = '';
        id = '';
        name = '';
        description = '';
        visible = '';
        media = '';
        icon = '';
        location = '';
        zonePoint = ZonePoint(0.0, 0.0, 0.0);
        locked = '';
        opened = '';
        container = '';

        LUAname = getLUAName(lines[i]);
        container = getContainer(lines[i]);

        sectionItem = true;
        do {
          i++;
          if (lines[i].trim().startsWith(LUAname + 'Container =')) {
            container = getContainer(lines[i]);
          }

          if (lines[i].trim().startsWith(LUAname + '.Id')) {
            id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Name')) {
            name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            do {
              description = description + lines[i];
              if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible')) {
                sectionDescription = false;
              }
              i++;
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description =
                getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable).trim();
          }

          if (lines[i].trim().startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable).trim();

          if (lines[i].trim().startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Locked'))
            locked = getLineData(lines[i], LUAname, 'Locked', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Opened')) {
            opened = getLineData(lines[i], LUAname, 'Opened', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
            location =
                lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
            if (location.endsWith('INVALID_ZONEPOINT'))
              location = '';
            else if (location.startsWith('ZonePoint')) {
              location = location.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '');
              zonePoint = ZonePoint(double.parse(location.split(',')[0]), double.parse(location.split(',')[1]),
                  double.parse(location.split(',')[2]));
              location = 'ZonePoint';
            } else
              location = getLineData(lines[i], LUAname, 'ObjectLocation', _obfuscatorFunction, _obfuscatorTable);
          }

          if (RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i]) ||
              i > lines.length - 2) sectionItem = false;
        } while (sectionItem);

        _Items.add(ItemData(
            LUAname, id, name, description, visible, media, icon, location, zonePoint, container, locked, opened));

        _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.ITEM);
        i--;
      } // end if
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_items');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    try {
      if (RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = OBJECT_TYPE.TASK;
        LUAname = '';
        id = '';
        name = '';
        description = '';
        visible = '';
        media = '';
        icon = '';
        complete = '';
        correctstate = '';
        active = '';

        LUAname = getLUAName(lines[i]);

        sectionTask = true;

        do {
          i++;

          if (lines[i].startsWith(LUAname + '.Id'))
            id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Name'))
            name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;

            do {
              description = description + lines[i];
              if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible')) sectionDescription = false;
              i++;
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable).trim();

          if (lines[i].startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Active'))
            active = getLineData(lines[i], LUAname, 'Active', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.CorrectState'))
            correctstate = getLineData(lines[i], LUAname, 'CorrectState', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Complete'))
            complete = getLineData(lines[i], LUAname, 'Complete', _obfuscatorFunction, _obfuscatorTable);

          if (RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) || RegExp(r'(.ZVariables =)').hasMatch(lines[i]))
            sectionTask = false;
        } while (sectionTask && (i < lines.length - 1));

        i--;

        _Tasks.add(TaskData(LUAname, id, name, description, visible, media, icon, active, complete, correctstate));
        _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.TASK);
      } // end if task
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_tasks');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    try {
      if (RegExp(r'(.ZVariables =)').hasMatch(lines[i])) {
        sectionVariables = true;
        beyondHeader = true;
        currentObjectSection = OBJECT_TYPE.VARIABLES;
        if (lines[i + 1].trim().startsWith('buildervar')) {
          declaration = lines[i]
              .replaceAll(_cartridgeName + '.ZVariables', '')
              .replaceAll('{', '')
              .replaceAll('}', '')
              .split('=');
          if (declaration[1].startsWith(_obfuscatorFunction)) {
            // content is obfuscated
            _Variables.add(VariableData(
                declaration[1].trim(),
                deobfuscateUrwigoText(
                    declaration[2].replaceAll(_obfuscatorFunction, '').replaceAll('("', '').replaceAll('")', ''),
                    _obfuscatorTable)));
          } else
            _Variables.add(// content not obfuscated
                VariableData(declaration[1].trim(), declaration[2].replaceAll('"', '')));
        }
        i++;
        do {
          declaration = lines[i].trim().replaceAll(',', '').replaceAll(' ', '').split('=');
          if (declaration.length == 2) {
            if (declaration[1].startsWith(_obfuscatorFunction)) {
              // content is obfuscated
              _Variables.add(VariableData(
                  declaration[0].trim(),
                  deobfuscateUrwigoText(
                      declaration[1].replaceAll(_obfuscatorFunction, '').replaceAll('("', '').replaceAll('")', ''),
                      _obfuscatorTable)));
            } else
              _Variables.add(// content not obfuscated
                  VariableData(declaration[0].trim(), declaration[1].replaceAll('"', '')));
          } else // only one element
            _Variables.add(VariableData(declaration[0].trim(), ''));

          i++;
          if (lines[i].trim() == '}' || lines[i].trim().startsWith('buildervar')) sectionVariables = false;
        } while ((i < lines.length - 1) && sectionVariables);
      }
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_identifiers');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    try {
      if (beyondHeader && RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i])) {
        currentObjectSection = OBJECT_TYPE.TIMER;
        LUAname = '';
        id = '';
        name = '';
        description = '';
        visible = '';
        type = '';
        duration = '';

        LUAname = getLUAName(lines[i]);

        sectionTimer = true;
        do {
          i++;

          if (lines[i].trim().startsWith(LUAname + '.Id'))
            id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Name'))
            name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;

            do {
              description = description + lines[i];
              i++;
              if (i > lines.length - 1 || lines[i].trim().startsWith(LUAname + '.Visible')) sectionDescription = false;
            } while (sectionDescription);
            description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Duration'))
            duration = getLineData(lines[i], LUAname, 'Duration', _obfuscatorFunction, _obfuscatorTable).trim();

          if (lines[i].trim().startsWith(LUAname + '.Type')) {
            type = getLineData(lines[i], LUAname, 'Type', _obfuscatorFunction, _obfuscatorTable).trim().toLowerCase();
          }

          if (lines[i].trim().startsWith(LUAname + '.Visible'))
            visible =
                getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable).trim().toLowerCase();

          if (RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) || RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]))
            sectionTimer = false;
        } while (sectionTimer && i < lines.length - 1);

        _Timers.add(TimerData(
          LUAname,
          id,
          name,
          description,
          visible,
          duration,
          type,
        ));

        _NameToObject[LUAname] = ObjectData(id, 0, name, '', OBJECT_TYPE.TIMER);
        i--;
      }
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_timers');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    try {
      if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i])) {
        currentObjectSection = OBJECT_TYPE.INPUT;
        currentObjectSection = OBJECT_TYPE.MESSAGES;
        LUAname = '';
        id = '';
        variableID = '';
        name = '';
        description = '';
        visible = '';
        media = '';
        icon = '';
        inputType = '';
        text = '';
        listChoices = [];

        LUAname = getLUAName(lines[i]);

        sectionInput = true;
        do {
          i++;

          if (lines[i].trim().startsWith(LUAname + '.Id')) {
            id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Name')) {
            name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            //i++;
            do {
              description = description + lines[i];
              i++;
              if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) sectionDescription = false;
            } while (sectionDescription);
            description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Media')) {
            media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Visible')) {
            visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Icon')) {
            icon = getLineData(lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.InputType')) {
            inputType = getLineData(lines[i], LUAname, 'InputType', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.InputVariableId')) {
            variableID = getLineData(lines[i], LUAname, 'InputVariableId', _obfuscatorFunction, _obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Text')) {
            if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
                lines[i + 1].trim().startsWith(LUAname + '.Media') ||
                lines[i + 1].trim().startsWith(LUAname + '.Visible') ||
                lines[i + 1].trim().startsWith('function') ||
                RegExp(r'(:OnProximity)').hasMatch(lines[i + 1])) {
              // single Line
              text = getLineData(lines[i], LUAname, 'Text', _obfuscatorFunction, _obfuscatorTable);
            } else {
              // multi Lines of Text
              text = '';
              sectionText = true;
              do {
                i++;
                text = text + lines[i];
                if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
                    RegExp(r'(:OnProximity)').hasMatch(lines[i + 1]) ||
                    lines[i + 1].trim().startsWith(LUAname + '.Media') ||
                    lines[i + 1].trim().startsWith('function') ||
                    lines[i + 1].trim().startsWith(LUAname + '.Visible')) sectionText = false;
              } while (sectionText);
              text = text.replaceAll(']]', '').replaceAll('<BR>', '\n');
            }
          }

          if (lines[i].trim().startsWith(LUAname + '.Choices')) {
            listChoices = [];
            if (lines[i + 1].trim().startsWith(LUAname + '.InputType') ||
                lines[i + 1].trim().startsWith(LUAname + '.Text')) {
              listChoices.addAll(getChoicesSingleLine(lines[i], LUAname, _obfuscatorFunction, _obfuscatorTable));
            } else {
              i++;
              sectionChoices = true;
              do {
                if (lines[i].trimLeft().startsWith('"')) {
                  listChoices.add(lines[i].trimLeft().replaceAll('",', '').replaceAll('"', ''));
                  i++;
                } else {
                  sectionChoices = false;
                }
              } while (sectionChoices);
            }
          }

          if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
              RegExp(r'(function)').hasMatch(lines[i + 1]) ||
              RegExp(r'(:OnProximity)').hasMatch(lines[i + 1]) ||
              RegExp(r'(:OnStart)').hasMatch(lines[i + 1])) sectionInput = false;
        } while (sectionInput);
        i--;

        _Inputs.add(InputData(
          LUAname,
          id,
          variableID,
          name,
          description,
          visible,
          media,
          icon,
          inputType,
          text,
          listChoices,
          [],
        ));
        _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.INPUT);
      } // end if lines[i] hasMatch Wherigo.ZInput - Input-Object
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_inputs');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    // get all Answers - these are part of the function <InputObjcet>:OnGetInput(input)
    try {
      if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
        // function for getting all inputs for an input object found
        insideInputFunction = true;
        inputObject = '';
        answerActions = [];
        _answerVariable = '';

        // getting name of function
        inputObject = lines[i].replaceAll('function ', '').replaceAll(':OnGetInput(input)', '').trim();
        Answers[inputObject] = [];
      } // end if identify input function

      if (lines[i].trim().endsWith('= tonumber(input)')) {
        _answerVariable = lines[i].trim().replaceAll(' = tonumber(input)', '');
      } else if (lines[i].trim().endsWith(' = input')) {
        _answerVariable = lines[i].trim().replaceAll(' = input', '');
      } else if (lines[i].trimLeft() == 'if input == nil then') {
        // suppress this
        //answer = 'NIL';
        i++;
        sectionAnalysed = false;
        do {
          i++;
          if (lines[i].trim() == 'end') sectionAnalysed = true;
        } while (!sectionAnalysed); // end of section
      } // end of NIL

      else if (_SectionEnd(lines[i])) {
        //
        if (insideInputFunction) {
          answerList.forEach((answer) {
            Answers[inputObject].add(AnswerData(
              answer,
              answerActions,
            ));
          });
          answerActions = [];
          answerList = _getAnswers(i, lines[i], lines[i - 1], _obfuscatorFunction, _obfuscatorTable);
        }
      } else if ((i + 1 < lines.length - 1) && _FunctionEnd(lines[i], lines[i + 1])) {
        if (insideInputFunction) {
          insideInputFunction = false;
          answerList.forEach((answer) {
            Answers[inputObject].add(AnswerData(
              answer,
              answerActions,
            ));
          });
          answerActions = [];
          answerList = [];
          _answerVariable = '';
        }
      } else if (lines[i].trimLeft().startsWith('Buttons')) {
        do {
          i++;
          if (!(lines[i].trim() == '}' || lines[i].trim() == '},')) {
            if (lines[i].trimLeft().startsWith(_obfuscatorFunction))
              answerActions.add(ActionMessageElementData(
                  ACTIONMESSAGETYPE.BUTTON,
                  deobfuscateUrwigoText(lines[i].trim().replaceAll(_obfuscatorFunction + '("', '').replaceAll('")', ''),
                      _obfuscatorTable)));
            else
              answerActions.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON,
                  lines[i].trim().replaceAll(_obfuscatorFunction + '("', '').replaceAll('")', '')));
          }
        } while (!lines[i].trim().startsWith('}'));
      } else {
        action = _handleLine(lines[i].trimLeft(), _obfuscatorTable, _obfuscatorFunction);
        if (action != null) {
          answerActions.add(action);
          answerActions.forEach((element) {});
        }
      } // end if other line content
    } catch (exception) {
      if (_Status == ANALYSE_RESULT_STATUS.OK)
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      else
        _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.add('wherigo_error_runtime');
      _ResultsLUA.add('wherigo_error_runtime_exception');
      _ResultsLUA.add('wherigo_error_lua_answers');
      _ResultsLUA.add('wherigo_error_lua_line');
      _ResultsLUA.add('> ' + i.toString() + ' <');
      _ResultsLUA.add(exception.toString());
      _ResultsLUA.add('');
    }

    // get all messages and dialoges
    if (currentObjectSection == OBJECT_TYPE.MESSAGES) {
      if (lines[i].trimLeft().startsWith('_Urwigo.MessageBox(') ||
          lines[i].trimLeft().startsWith('Wherigo.MessageBox(')) {
        singleMessageDialog = [];
        i++;
        sectionMessages = true;
        do {
          if (lines[i].trimLeft().startsWith('Text')) {
            singleMessageDialog.add(ActionMessageElementData(
                ACTIONMESSAGETYPE.TEXT, getTextData(lines[i], _obfuscatorFunction, _obfuscatorTable)));
          } else if (lines[i].trimLeft().startsWith('Media')) {
            singleMessageDialog.add(ActionMessageElementData(ACTIONMESSAGETYPE.IMAGE,
                lines[i].trimLeft().replaceAll('Media = ', '').replaceAll('"', '').replaceAll(',', '')));
          } else if (lines[i].trimLeft().startsWith('Buttons')) {
            i++;
            do {
              singleMessageDialog.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON,
                  getTextData('Text = ' + lines[i].trim(), _obfuscatorFunction, _obfuscatorTable)));
              i++;
            } while (!lines[i].trimLeft().startsWith('}'));
          }

          i++;
          if (i > lines.length - 2 || lines[i].trimLeft().startsWith('})')) sectionMessages = false;
        } while (sectionMessages);
        _Messages.add(singleMessageDialog);
      } else if (lines[i].trimLeft().startsWith('_Urwigo.Dialog(') ||
          lines[i].trimLeft().startsWith('Wherigo.Dialog(')) {
        sectionMessages = true;
        singleMessageDialog = [];
        i++;
        do {
          if (lines[i].trimLeft().startsWith('Text = ') ||
              lines[i].trimLeft().startsWith('Text = ' + _obfuscatorFunction + '(') ||
              lines[i].trimLeft().startsWith('Text = (' + _obfuscatorFunction + '(')) {
            singleMessageDialog.add(ActionMessageElementData(
                ACTIONMESSAGETYPE.TEXT, getTextData(lines[i], _obfuscatorFunction, _obfuscatorTable)));
          } else if (lines[i].trimLeft().startsWith('Media')) {
            singleMessageDialog
                .add(ActionMessageElementData(ACTIONMESSAGETYPE.IMAGE, lines[i].trimLeft().replaceAll('Media = ', '')));
          } else if (lines[i].trimLeft().startsWith('Buttons')) {
            i++;
            do {
              singleMessageDialog.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON,
                  getTextData('Text = ' + lines[i].trim(), _obfuscatorFunction, _obfuscatorTable)));
              i++;
            } while (lines[i].trimLeft() != '}');
          }
          if (lines[i].trimLeft().startsWith('}, function(action)') ||
              lines[i].trimLeft().startsWith('}, nil)') ||
              lines[i].trimLeft().startsWith('})')) {
            sectionMessages = false;
          }
          i++;
        } while (sectionMessages && (i < lines.length));
        _Messages.add(singleMessageDialog);
      } else if (lines[i].trimLeft().startsWith('_Urwigo.OldDialog(')) {
        i++;
        sectionMessages = true;
        singleMessageDialog = [];
        do {
          if (lines[i].trimLeft().startsWith('Text = ' + _obfuscatorFunction + '(') ||
              lines[i].trimLeft().startsWith('Text = (' + _obfuscatorFunction + '(')) {
            singleMessageDialog.add(ActionMessageElementData(
                ACTIONMESSAGETYPE.TEXT, getTextData(lines[i], _obfuscatorFunction, _obfuscatorTable)));
          } else if (lines[i].trimLeft().startsWith('Media')) {
            singleMessageDialog
                .add(ActionMessageElementData(ACTIONMESSAGETYPE.IMAGE, lines[i].trimLeft().replaceAll('Media = ', '')));
          } else if (lines[i].trimLeft().startsWith('Buttons')) {
            i++;
            do {
              singleMessageDialog.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON,
                  getTextData('Text = ' + lines[i].trim(), _obfuscatorFunction, _obfuscatorTable)));
              i++;
            } while (lines[i].trimLeft() != '}');
          }
          if (lines[i].trimLeft().startsWith('})')) {
            sectionMessages = false;
          }
          i++;
        } while (sectionMessages);
        _Messages.add(singleMessageDialog);
      }
    }
  } // end for i = 0 to lines.length

  _Inputs.forEach((inputObject) {
    resultInputs.add(InputData(
        inputObject.InputLUAName.trim(),
        inputObject.InputID,
        inputObject.InputVariableID,
        inputObject.InputName,
        inputObject.InputDescription,
        inputObject.InputVisible,
        inputObject.InputMedia,
        inputObject.InputIcon,
        inputObject.InputType,
        inputObject.InputText,
        inputObject.InputChoices,
        Answers[inputObject.InputLUAName.trim()]));
  });
  _Inputs = resultInputs;

  out.addAll({
    'WherigoCartridgeLUA': WherigoCartridgeLUA(
      LUAFile: _LUAFile,
      CartridgeLUAName: _CartridgeLUAName,
      CartridgeName: _LUACartridgeName,
      CartridgeGUID: _LUACartridgeGUID,
      ObfuscatorTable: _obfuscatorTable,
      ObfuscatorFunction: _obfuscatorFunction,
      Characters: _Characters,
      Items: _Items,
      Tasks: _Tasks,
      Inputs: _Inputs,
      Zones: _Zones,
      Timers: _Timers,
      Media: _Media,
      Messages: _Messages,
      Answers: _Answers,
      Variables: _Variables,
      NameToObject: _NameToObject,
      ResultStatus: _Status,
      ResultsLUA: _ResultsLUA,
      Builder: _builder,
      BuilderVersion: _BuilderVersion,
      TargetDeviceVersion: _TargetDeviceVersion,
      StateID: _StateID,
      CountryID: _CountryID,
      UseLogging: _UseLogging,
      CreateDate: _CreateDate,
      PublishDate: _PublishDate,
      UpdateDate: _UpdateDate,
      LastPlayedDate: _LastPlayedDate,
      httpCode: _httpCode,
      httpMessage: _httpMessage,
    )
  });

  return out;
}

String _normalizeLUAmultiLineText(String LUA) {
  return LUA
      .replaceAll('[[\n', '[[')
      .replaceAll('<BR>\n', '<BR>')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('\\195\\164', 'ä')
      .replaceAll('\\195\\182', 'ö')
      .replaceAll('\\195\\188', 'ü')
      .replaceAll('\\195\\132', 'Ä')
      .replaceAll('\\195\\156', 'Ü')
      .replaceAll('\\195\\159', 'ß')
      .replaceAll('\\194\\176', '°')
      .replaceAll('\n\n', '\n');
}

ZonePoint _getPoint(String line) {
  List<String> data = line
      .trimLeft()
      .replaceAll('ZonePoint(', '')
      .replaceAll('),', '')
      .replaceAll(')', '')
      .replaceAll(' ', '')
      .split(',');
  return ZonePoint(double.parse(data[0]), double.parse(data[1]), double.parse(data[2]));
}

List<String> _getAnswers(int i, String line, String lineBefore, String obfuscator, String dtable) {
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('elseif input == ') ||
      line.trim().startsWith('if ' + _answerVariable + ' == ')) {
    return line
        .trimLeft()
        .replaceAll('if', '')
        .replaceAll('else', '')
        .replaceAll('input', '')
        .replaceAll('==', '')
        .replaceAll('then', '')
        .replaceAll(_answerVariable, '')
        .replaceAll(' ', '')
        .split('or');
  } else if (RegExp(r'(_Urwigo.Hash)').hasMatch(line)) {
    List<String> results = [];
    int hashvalue = 0;
    line
        .trim()
        .replaceAll('if ', '')
        .replaceAll('elseif ', '')
        .replaceAll('_Urwigo.Hash', '')
        .replaceAll('input', '')
        .replaceAll('=', '')
        .replaceAll('string.lower', '')
        .replaceAll('string.upper', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('then', '')
        .replaceAll('else', '')
        .replaceAll('true', '')
        .replaceAll(' ', '')
        .split('or')
        .forEach((element) {
      hashvalue = int.parse(element.replaceAll('\D+', ''));
      results.add(breakUrwigoHash(hashvalue).toString());
    });
    return results;
  } else if (line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals(')) {
    if (_answerVariable == '') _answerVariable = _getVariable(lineBefore);
    line = line
        .trim()
        .replaceAll('if ', '')
        .replaceAll('elseif ', '')
        .replaceAll('Wherigo.NoCaseEquals', '')
        .replaceAll(_answerVariable + ',', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('"', '')
        .replaceAll('then', '')
        .replaceAll('else', '')
        .replaceAll('input,', '')
        .replaceAll('Answer,', '')
        .trim();
    if (RegExp(r'(' + obfuscator + ')').hasMatch(line)) {
      line = deobfuscateUrwigoText(line.replaceAll(obfuscator, '').replaceAll('("', '').replaceAll('")', ''), dtable);
    }
    line = line.split(' or ').join('\n');
    return [removeWWB(line)];
  }
}

bool _SectionEnd(String line) {
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('elseif input == ') ||
      line.trim().startsWith('if _Urwigo.Hash(') ||
      line.trim().startsWith('if (_Urwigo.Hash(') ||
      line.trim().startsWith('elseif _Urwigo.Hash(') ||
      line.trim().startsWith('elseif (_Urwigo.Hash(') ||
      line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('if ' + _answerVariable + ' == '))
    return true;
  else
    return false;
}

bool _FunctionEnd(String line1, String line2) {
  return (line1.trim() == 'end' && (line2.trimLeft().startsWith('function') || line2.trimLeft().startsWith('return')));
}

ActionMessageElementData _handleLine(String line, String dtable, String obfuscator) {
  line = line.trim();
  if (line.startsWith('Wherigo.PlayAudio'))
    return ActionMessageElementData(ACTIONMESSAGETYPE.COMMAND, line.trim());
  else if (line.startsWith('Wherigo.GetInput'))
    return ActionMessageElementData(ACTIONMESSAGETYPE.COMMAND, line.trim());
  else if (line.startsWith('_Urwigo') ||
      line.startsWith('Callback') ||
      line.startsWith('Wherigo') ||
      line.startsWith('Buttons') ||
      line.startsWith('end') ||
      line == ']]' ||
      line.startsWith('if action') ||
      line.startsWith('{') ||
      line.startsWith('}'))
    return null;
  else if (line.startsWith('Text = ')) {
    return ActionMessageElementData(ACTIONMESSAGETYPE.TEXT, getTextData(line, obfuscator, dtable));
  } else if (line.startsWith('Media = ')) {
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.IMAGE, line.trimLeft().replaceAll('Media = ', '').replaceAll(',', ''));
  } else if (line.startsWith('if '))
    return ActionMessageElementData(ACTIONMESSAGETYPE.CASE, line.trimLeft());
  else if (line.startsWith('elseif '))
    return ActionMessageElementData(ACTIONMESSAGETYPE.CASE, line.trimLeft());
  else if (line.startsWith('else'))
    return ActionMessageElementData(ACTIONMESSAGETYPE.CASE, line.trimLeft());
  else {
    String actionLine = '';
    if (RegExp(r'(' + obfuscator + ')').hasMatch(line)) {
      List<String> actions = line.trim().split('=');
      if (actions.length == 2) {
        actionLine = actions[0].trim() +
            ' = ' +
            deobfuscateUrwigoText(
                (actions[1].indexOf('")') > 0)
                    ? actions[1]
                        .substring(0, actions[1].indexOf('")'))
                        .replaceAll(obfuscator, '')
                        .replaceAll('("', '')
                        .replaceAll('")', '')
                        .trim()
                    : actions[1].replaceAll(obfuscator, '').replaceAll('("', '').replaceAll('")', '').trim(),
                dtable);
      } else {
        actionLine = deobfuscateUrwigoText(
            actions[0].replaceAll(obfuscator, '').replaceAll('("', '').replaceAll('")', '').trim(), dtable);
      }
    } else
      actionLine = line.trimLeft();
    actionLine = actionLine.replaceAll('<BR>', '\n').replaceAll(']],', '');
    return ActionMessageElementData(ACTIONMESSAGETYPE.COMMAND, actionLine);
  }
}

String _getVariable(String line) {
  if (line.trim().endsWith('= input')) line = line.trim().replaceAll(' = input', '').replaceAll(' ', '');
  if (line.trim().endsWith('~= nil then'))
    line = line.trim().replaceAll('if', '').replaceAll(' ~= nil then', '').replaceAll(' ', '');
  return line;
}
