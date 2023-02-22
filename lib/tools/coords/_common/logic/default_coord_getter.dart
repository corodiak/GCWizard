import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coords_return_types.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:prefs/prefs.dart';

const defaultLambertType = CoordFormatKey.LAMBERT93;
const defaultGaussKruegerType = CoordFormatKey.GAUSS_KRUEGER_GK1;
const defaultSlippyMapType = CoordFormatKey.SLIPPYMAP_10;

CoordFormatKey? _getDefaultSubtypeForFormat(CoordFormatKey format) {
  switch (format) {
    case CoordFormatKey.GAUSS_KRUEGER:
      return defaultGaussKruegerType;
    case CoordFormatKey.LAMBERT:
      return defaultLambertType;
    case CoordFormatKey.SLIPPY_MAP:
      return defaultSlippyMapType;
    default: return null;
  }
}

CoordsFormatValue defaultCoordFormat() {
  var formatStr = Prefs.getString(PREFERENCE_COORD_DEFAULT_FORMAT);

  CoordFormatKey format;
  if(formatStr.isEmpty)
    format = CoordFormatKey.DMM;
  else {
    var _format = getCoordinateFormatByPersistenceKey(formatStr);
    if (_format == null)
      format = CoordFormatKey.DMM;
    else
      format = _format.key;
  }

  return CoordsFormatValue(format, getDefaultSubtypesForFormat(format));
}

CoordFormatKey? getDefaultSubtypesForFormat(CoordFormatKey format) {
  if (![CoordFormatKey.LAMBERT, CoordFormatKey.GAUSS_KRUEGER, CoordFormatKey.SLIPPY_MAP].contains(format))
    return null;

  CoordFormatKey subtype;

  var subtypeStr = Prefs.getString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE);
  if (subtypeStr.isEmpty) {
    subtype = _getDefaultSubtypeForFormat(format)!;
  } else {

    var _subtype = getCoordinateFormatSubtypeByPersistenceKey(subtypeStr);
    if (_subtype == null || !isSubtypeOfCoordFormat(format, _subtype.key)) {

      subtype = _getDefaultSubtypeForFormat(format)!;

    } else {

      subtype = _subtype.key;

    }

  }

  var persistenceKeyForSubtype = getCoordinateFormatByKey(subtype).persistenceKey;
  Prefs.setString(PREFERENCE_COORD_DEFAULT_FORMAT_SUBTYPE, persistenceKeyForSubtype);

  return subtype;
}

int defaultHemiphereLatitude() {
  return Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LATITUDE) == HemisphereLatitude.North.toString() ? 1 : -1;
}

int defaultHemiphereLongitude() {
  return Prefs.getString(PREFERENCE_COORD_DEFAULT_HEMISPHERE_LONGITUDE) == HemisphereLongitude.East.toString() ? 1 : -1;
}

Ellipsoid defaultEllipsoid() {
  var _WGS84Ells = getEllipsoidByName(ELLIPSOID_NAME_WGS84)!;

  String type = Prefs.getString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_TYPE);
  if (type.isEmpty)
    type = EllipsoidType.STANDARD.toString();

  if (type == EllipsoidType.STANDARD.toString()) {
    var ells = getEllipsoidByName(Prefs.getString(PREFERENCE_COORD_DEFAULT_ELLIPSOID_NAME));
    if (ells == null)
      return _WGS84Ells;

    return ells;
  }

  else if (type == EllipsoidType.USER_DEFINED.toString()) {
    double a = Prefs.getDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_A);
    if (a == 0)
      a = _WGS84Ells.a;

    double invf = Prefs.getDouble(PREFERENCE_COORD_DEFAULT_ELLIPSOID_INVF);
    if (invf == 0)
      invf = _WGS84Ells.invf;

    return Ellipsoid(null, a, invf, type: EllipsoidType.USER_DEFINED);
  }

  throw Exception('No Ellipsoid type found.');
}