import 'package:fpdart/fpdart.dart';

import '../../../../core/models/failure/failure.dart';
import '../models/apsiyon_point.dart';
import '../models/demand.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<ApsiyonPoint>>> getApsiyonPoints();
  Future<Option<Failure>> setDemands({
    required String userId,
    required String apartmentNumber,
    required String apsiyonPointId,
    required String apartment_name,
  });
  Stream<Either<Failure, Demand>> getDemand({required String userId});
  //deleteDemand
  Future<Option<Failure>> deleteDemand({required String userId});
}
