import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';

import '../../core/models/failure/failure.dart';

abstract class LocationService {
  // Future<Either<Failure, Unit>> checkPermission();
  Future<Either<Failure, LatLng>> getCurrentPosition();
}
