import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'1': false, '4': false, '2': false, '5': false, '3': false, '6': false};

const _MURRAY_RELATIVE_DISPLAY_WIDTH = 50;
const _MURRAY_RELATIVE_DISPLAY_HEIGHT = 110;
const _MURRAY_RADIUS = 10.0;

class MurraySegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;
  final bool tapeStyle;

  MurraySegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged, this.tapeStyle: false})
      : super(
            key: key,
            initialSegments: _INITIAL_SEGMENTS,
            segments: segments,
            readOnly: readOnly,
            onChanged: onChanged,
            type: SegmentDisplayType.CUSTOM,
            customPaint: (GCWTouchCanvas canvas, Size size, Map<String, bool> currentSegments, Function setSegmentState,
                Color segment_color_on, Color segment_color_off) {
              var paint = defaultSegmentPaint();
              var SEGMENTS_COLOR_ON = segment_color_on;
              var SEGMENTS_COLOR_OFF = segment_color_off;

              var shutters = {
                '1': [5, 20],
                '2': [25, 20],
                '3': [5, 50],
                '4': [25, 50],
                '5': [5, 80],
                '6': [25, 80]
              };
              var pointSize = size.height / _MURRAY_RELATIVE_DISPLAY_HEIGHT * _MURRAY_RADIUS;

              paint.color = Colors.black;
              shutters.forEach((key, value) {
                canvas.touchCanvas.drawRect(
                    Offset(size.width / _MURRAY_RELATIVE_DISPLAY_WIDTH * (value[0] - 1),
                            size.height / _MURRAY_RELATIVE_DISPLAY_HEIGHT * (value[1]) - 1) &
                        Size(pointSize * 3 + 2, pointSize * 2 + 2),
                    paint);

                if (size.height < 50) return;
              });

              shutters.forEach((key, value) {
                paint.color = currentSegments[key] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
                canvas.touchCanvas.drawRect(
                    Offset(size.width / _MURRAY_RELATIVE_DISPLAY_WIDTH * value[0],
                            size.height / _MURRAY_RELATIVE_DISPLAY_HEIGHT * value[1]) &
                        Size(pointSize * 3, pointSize * 2),
                    paint, onTapDown: (tapDetail) {
                  setSegmentState(key, !currentSegments[key]);
                });

                if (size.height < 50) return;
              });
            });
}
