import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_lines.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:latlong/latlong.dart';

class IntersectFourPoints extends StatefulWidget {
  @override
  IntersectFourPointsState createState() => IntersectFourPointsState();
}

class IntersectFourPointsState extends State<IntersectFourPoints> {
  LatLng _currentIntersection = null;

  var _currentCoords11 = defaultCoordinate;
  var _currentCoords12 = defaultCoordinate;
  var _currentCoords21 = defaultCoordinate;
  var _currentCoords22 = defaultCoordinate;

  var _currentCoordsFormat11 = defaultCoordFormat();
  var _currentCoordsFormat12 = defaultCoordFormat();
  var _currentCoordsFormat21 = defaultCoordFormat();
  var _currentCoordsFormat22 = defaultCoordFormat();

  var _currentMapPoints;
  var _currentOutputFormat = defaultCoordFormat();
  var _currentOutput = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          text: i18n(context, 'coords_intersectfourpoints_coord11'),
          coordsFormat: _currentCoordsFormat11,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat11 = ret['coordsFormat'];
              _currentCoords11 = ret['value'];
            });
          },
        ),
        GCWCoords(
          text: i18n(context, 'coords_intersectfourpoints_coord12'),
          coordsFormat: _currentCoordsFormat12,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat12 = ret['coordsFormat'];
              _currentCoords12 = ret['value'];
            });
          },
        ),
        GCWCoords(
          text: i18n(context, 'coords_intersectfourpoints_coord21'),
          coordsFormat: _currentCoordsFormat21,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat21 = ret['coordsFormat'];
              _currentCoords21 = ret['value'];
            });
          },
        ),
        GCWCoords(
          text: i18n(context, 'coords_intersectfourpoints_coord22'),
          coordsFormat: _currentCoordsFormat22,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat22 = ret['coordsFormat'];
              _currentCoords22 = ret['value'];
            });
          },
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
            });
          },
        ),
        GCWSubmitFlatButton(
          onPressed: () {
            setState(() {
              _calculateOutput(context);
            });
          },
        ),
        GCWCoordsOutput(
          text: _currentOutput,
          points: _currentMapPoints,
          geodetics: [
            MapGeodetic(
              start: _currentCoords11,
              end: _currentCoords12
            ),
            MapGeodetic(
                start: _currentCoords21,
                end: _currentCoords22,
                color: HSLColor
                    .fromColor(ThemeColors.mapPolyline)
                    .withLightness(HSLColor.fromColor(ThemeColors.mapPolyline).lightness - 0.3)
                    .toColor()
            ),
          ],
        ),
      ],
    );
  }

  _calculateOutput(BuildContext context) {
    _currentIntersection = intersectFourPoints(_currentCoords11, _currentCoords12, _currentCoords21, _currentCoords22, defaultEllipsoid());

    _currentMapPoints = _currentMapPoints = [
      MapPoint(
        point: _currentCoords11,
      ),
      MapPoint(
        point: _currentCoords12,
      ),
      MapPoint(
        point: _currentCoords21,
      ),
      MapPoint(
        point: _currentCoords22,
      )
    ];

    if (_currentIntersection == null) {
      _currentOutput = i18n(context, "coords_intersect_nointersection");
      return;
    }

    _currentMapPoints.add(
      MapPoint(
        point: _currentIntersection,
        color: ThemeColors.mapCalculatedPoint
      )
    );

    _currentOutput = formatCoordOutput(_currentIntersection, _currentOutputFormat, defaultEllipsoid());
  }
}