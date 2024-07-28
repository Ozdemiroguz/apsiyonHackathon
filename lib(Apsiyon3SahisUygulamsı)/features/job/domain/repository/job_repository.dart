import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/failure/failure.dart';
import '../models/employment.dart';

abstract interface class JobRepository {
  Future<String> getJob({required String userId});
  Future<Option<Failure>> setOffer({
    required String employmentId,
    required String otherId,
    required String otherName,
    required String price,
  });

  Stream<Either<Failure, List<Employment>>> getEmployment(
      {required String job});

  Stream<Either<Failure, List<Employment>>> getPersonalEmployment(
      {required String otherId});
}
