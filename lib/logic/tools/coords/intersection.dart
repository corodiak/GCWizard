import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_lines.dart';
import 'package:latlong2/latlong.dart';

class IntersectionJobData {
  final LatLng coord1;
  final double alpha;
  final LatLng coord2;
  final double beta;
  final Ellipsoid ells;

  IntersectionJobData({this.coord1 = null, this.alpha = 0.0, this.coord2 = null, this.beta = 0.0, this.ells = null});
}

Future<List<LatLng>> intersectionAsync(dynamic jobData) async {
  if (jobData == null) return null;

  var output = intersection(jobData.parameters.coord1, jobData.parameters.alpha, jobData.parameters.coord2,
      jobData.parameters.beta, jobData.parameters.ells);

  if (jobData.sendAsyncPort != null) jobData.sendAsyncPort.send(output);

  return output;
}

List<LatLng> intersection(LatLng coord1, double alpha, LatLng coord2, double beta, Ellipsoid ells) {
  DistanceBearingData crs = distanceBearing(coord1, coord2, ells);

  LatLng i1 = intersectBearings(coord1, crs.bearingAToB + alpha, coord2, crs.bearingBToA - beta, ells, false);
  LatLng i2 = intersectBearings(coord1, crs.bearingAToB - alpha, coord2, crs.bearingBToA + beta, ells, false);

  return [i1, i2];
}
