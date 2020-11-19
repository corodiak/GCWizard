import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/export/export.dart' as coodinatesExport;
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_mapview.dart';

class GCWCoordsOutput extends StatefulWidget {
  final List<dynamic> outputs;
  final List<MapPoint> points;
  final List<MapGeodetic> geodetics;
  final List<MapCircle> circles;
  final bool mapButtonTop;

  const GCWCoordsOutput({
    Key key,
    this.outputs,
    this.points: const [],
    this.geodetics: const [],
    this.circles: const [],
    this.mapButtonTop: false
  }) : super(key: key);

  @override
  _GCWCoordsOutputState createState() => _GCWCoordsOutputState();
}


class _GCWCoordsOutputState extends State<GCWCoordsOutput> {

  @override
  Widget build(BuildContext context) {
    var children = widget.outputs.map((output) {
      return Container(
        child: GCWOutput(
          child: output,
        ),
        padding: EdgeInsets.only(bottom: 15),
      );
    }).toList();
    var _outputText = Column(
      children: children,
    );

    var _button = Visibility (
      visible: widget.outputs != null && widget.outputs.length > 0 && widget.points.length > 0,
      child: GCWButton (
        text: i18n(context, 'coords_show_on_map'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GCWToolWidget(
            tool: GCWMapView(
              points: widget.points,
              geodetics: widget.geodetics,
              circles: widget.circles,
            ),
            toolName: i18n(context, 'coords_map_view_title'),
            autoScroll: false,
          )));
        },
      )
    );

    var _children = widget.mapButtonTop ? [_button, _outputText] : [_outputText, _button];

    return GCWMultipleOutput(
      children: _children,
      trailing: GCWIconButton(
        iconData: Icons.save,
        size: IconButtonSize.SMALL,
        onPressed: () {
          _exportCoordinates(context, 'GC Wizard Export', widget.points);
        },
      )
    );
  }

  Future<bool> _exportCoordinates(BuildContext context, String name, List<MapPoint> points) async {
    showGCWDialog(
        context,
        i18n(context, 'coords_export_saved'),
          Text(i18n(context, 'coords_export_fileformat'),
        ),
        [
          GCWDialogButton(
            text: 'GPX',
            onPressed: () async {
              coodinatesExport.exportCoordinates(name, points).then((value) {
                _showFilePath(value);
              });
            },
          ),
          GCWDialogButton(
            text: 'KML',
            onPressed: () async {
              coodinatesExport.exportCoordinates(name, points, kmlFormat: true).then((value) {
                _showFilePath(value);
              });
            },
          )
        ]);
  }

  _showFilePath(Map<String, dynamic> value) {
    showGCWDialog(
        context,
        i18n(context, 'coords_export_saved'),
        Column(
          children: [
            Text(i18n(context, 'coords_export_savedpath', parameters: [value['path']]),
            ),
          ],
        ),
        [
          GCWDialogButton(
            text: i18n(context, 'common_ok'),
          )
        ],
        cancelButton: false
    );
  }
}
