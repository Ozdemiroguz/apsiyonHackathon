import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

extension PositionX on Position {
  LatLng get toLatLng => LatLng(latitude, longitude);
}
