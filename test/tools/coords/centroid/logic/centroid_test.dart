import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/coords/centroid/centroid_arithmetic_mean/logic/centroid_arithmetic_mean.dart';
import 'package:gc_wizard/tools/coords/centroid/centroid_center_of_gravity/logic/centroid_center_of_gravity.dart';
import 'package:gc_wizard/tools/coords/centroid/logic/centroid.dart';
import 'package:gc_wizard/utils/coordinate_utils.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group("Centroid.centroid:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'coords' : [LatLng(-21.1333, -175.2), LatLng(-8.53333, 179.2167)], 'expectedOutput': LatLng(-14.833315, -177.99165)}
    ];

    for (var elem in _inputsToExpected) {
      test('coords: ${elem['coords']}', () {
        var actual = centroid(elem['coords'] as List<LatLng>);
        expect(equalsLatLng(actual!, elem['expectedOutput'] as LatLng), true);
      });
    }
  });

  group("Centroid.centroidCenterOfGravity:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'coords' : [LatLng(34.088869, 33.3238855), LatLng(68.3433821667, 5.3754655667), LatLng(54.3917007667, -11.53589395)], 'expectedOutput': LatLng(54.017923, 12.893674)},
      {'coords' : [LatLng(34.088869, -157.6761145), LatLng(68.3433821667, 174.3754655667), LatLng(54.3917007667, 157.4641061)], 'expectedOutput': LatLng(54.017923, -178.106326)},
      {'coords' : [LatLng(34.088869, 157.6761145), LatLng(68.3433821667, -174.3754655667), LatLng(54.3917007667, -157.4641061)], 'expectedOutput': LatLng(54.017923, 178.106326)}
    ];

    for (var elem in _inputsToExpected) {
      test('coords: ${elem['coords']}', () {
        var actual = centroidCenterOfGravity(elem['coords'] as List<LatLng>);
        expect(equalsLatLng(actual!, elem['expectedOutput'] as LatLng, tolerance: 1e-5), true);
      });
    }
  });

  group("Centroid.centroidArithmeticMean:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'coords' : [LatLng(34.088869, 33.3238855), LatLng(68.3433821667, 5.3754655667), LatLng(54.3917007667, -11.53589395)], 'expectedOutput': LatLng(52.274651, 9.054486)},
      {'coords' : [LatLng(34.088869, -157.6761145), LatLng(68.3433821667, 174.3754655667), LatLng(54.3917007667, 157.4641061)], 'expectedOutput': LatLng(52.274651, 178.054486)},
      {'coords' : [LatLng(34.088869, 157.6761145), LatLng(68.3433821667, -174.3754655667), LatLng(54.3917007667, -157.4641061)], 'expectedOutput': LatLng(52.274651, -178.054486)}
    ];

    for (var elem in _inputsToExpected) {
      test('coords: ${elem['coords']}', () {
        var cog = centroidCenterOfGravity(elem['coords'] as List<LatLng>);
        var actual = centroidArithmeticMean(elem['coords'] as List<LatLng>, cog!);
        expect(equalsLatLng(actual!, elem['expectedOutput'] as LatLng, tolerance: 1e-5), true);
      });
    }
  });
}