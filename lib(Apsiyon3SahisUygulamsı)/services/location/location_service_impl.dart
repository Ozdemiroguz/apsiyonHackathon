import 'dart:async';

import 'package:apsiyon3/core/extensions/position_extension.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import '../../constants/durations.dart';
import '../../constants/failure_message.dart';
import '../../core/models/failure/failure.dart';
import 'location_service.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  const LocationServiceImpl();

  // @override
  // Future<Either<Failure, Unit>> checkPermission() async {
  //   final serviceEnabled = await Location().serviceEnabled();

  //   if (!serviceEnabled) {
  //     await Location().requestService();
  //   }

  //   var permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return left(Failure.locationPermissionDenied(message: locationPermissionDeniedMessage));
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     await Geolocator.openLocationSettings();
  //     return left(Failure.locationPermissionDenied(message: locationPermissionDeniedMessage));
  //   }
  //   return right(unit);
  // }

  @override
  Future<Either<Failure, LatLng>> getCurrentPosition() async {
    try {
      // final isLocationServiceEnabled = await Location().serviceEnabled();

      // if (!isLocationServiceEnabled) {
      //   await Location().requestService();
      // }

      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return left(
            Failure.locationPermissionDenied(
              message: locationPermissionDeniedMessage,
            ),
          );
        }
      } else if (permission == LocationPermission.deniedForever) {
        // await Geolocator.openLocationSettings();
        return left(
          Failure.locationPermissionDenied(message: locationDeniedForever),
        );
      } else {
        final position = await Geolocator.getCurrentPosition()
            .timeout(locationTimeoutDuration);

        return right(position.toLatLng);
      }

      return left(
        Failure.locationPermissionDenied(
          message: permission == LocationPermission.deniedForever
              ? locationDeniedForever
              : locationPermissionDeniedMessage,
        ),
      );
    } on PermissionDeniedException {
      return left(
        Failure.locationPermissionDenied(
          message: locationPermissionDeniedMessage,
        ),
      );
    } on LocationServiceDisabledException {
      return left(
        Failure.locationServiceDisabled(
          message: locationServiceDisabledMessage,
        ),
      );
    } on TimeoutException {
      final lastKnownPosition = await Geolocator.getLastKnownPosition();

      return optionOf(lastKnownPosition).map((t) => t.toLatLng).toEither(
            () => Failure.connectionTimedOut(connectionTimedOutMessage),
          );
    }
  }
}
