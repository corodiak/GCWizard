import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_sign_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_double_textfield.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/logic/ellipsoid.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:prefs/prefs.dart';

part 'package:gc_wizard/application/settings/widget/ellipsoid_picker.dart';

class CoordinatesSettings extends StatefulWidget {
  @override
  CoordinatesSettingsState createState() => CoordinatesSettingsState();
}

class CoordinatesSettingsState extends State<CoordinatesSettings> {
  var _currentDefaultFormat = {
    'format': Prefs.getString(PREFERENCE_COORD_DEFAULT_FORMAT),
    'subtype': Prefs.getString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE)
  };
  var _currentDefaultHemisphereLatitude = Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE);
  var _currentDefaultHemisphereLongitude = Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE);
  Ellipsoid _currentDefaultEllipsoid = defaultEllipsoid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultformat'),
        ),
        GCWCoordsFormatSelector(
          format: _currentDefaultFormat,
          onChanged: (newValue) {
            setState(() {
              _currentDefaultFormat = newValue;
              Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT, _currentDefaultFormat['format']);
              Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE, _currentDefaultFormat['subtype']);
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaulthemispheres'),
        ),
        Row(children: <Widget>[
          Expanded(
              child: GCWText(
                text: i18n(context, 'coords_common_latitude'),
              ),
              flex: 1),
          Expanded(
              child: GCWSignDropDown(
                  itemList: [i18n(context, 'coords_common_north'), i18n(context, 'coords_common_south')],
                  value: _currentDefaultHemisphereLatitude == HemisphereLatitude.North.toString() ? 1 : -1,
                  onChanged: (value) {
                    setState(() {
                      _currentDefaultHemisphereLatitude =
                          value > 0 ? HemisphereLatitude.North.toString() : HemisphereLatitude.South.toString();
                      Prefs.setString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE, _currentDefaultHemisphereLatitude);
                    });
                  }),
              flex: 4)
        ]),
        Row(children: <Widget>[
          Expanded(
              child: GCWText(
                text: i18n(context, 'coords_common_longitude'),
              ),
              flex: 1),
          Expanded(
              child: GCWSignDropDown(
                  itemList: [i18n(context, 'coords_common_east'), i18n(context, 'coords_common_west')],
                  value: _currentDefaultHemisphereLongitude == HemisphereLongitude.East.toString() ? 1 : -1,
                  onChanged: (value) {
                    setState(() {
                      _currentDefaultHemisphereLongitude =
                          value > 0 ? HemisphereLongitude.East.toString() : HemisphereLongitude.West.toString();
                      Prefs.setString(
                          PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE, _currentDefaultHemisphereLongitude);
                    });
                  }),
              flex: 4)
        ]),
        GCWTextDivider(
          text: i18n(context, 'settings_coordinates_defaultrotationellipsoid'),
        ),
        _EllipsoidPicker(
          onChanged: (ells) {
            _currentDefaultEllipsoid = ells;

            switch (_currentDefaultEllipsoid.type) {
              case EllipsoidType.STANDARD:
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE, EllipsoidType.STANDARD.toString());
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_NAME, ells.name);
                break;
              case EllipsoidType.USER_DEFINED:
                Prefs.setString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE, EllipsoidType.USER_DEFINED.toString());
                Prefs.setDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_A, ells.a);
                Prefs.setDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_INVF, ells.invf);
                break;
            }
          },
        )
      ],
    );
  }
}
