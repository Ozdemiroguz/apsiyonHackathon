import 'package:apsiyon/core/models/failure/failure.dart';
import 'package:apsiyon/features/other/domain/models/token.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/employment.dart';

abstract interface class OtherRepository {
  Future<Option<Failure>> setToken(
      {required String tokenDescription,
      required String tokenOtherId,
      required Duration tokenTime,
      required String userId,
      required String apsiyonPointId,
      required String tokenOtherName});
  Stream<Either<Failure, List<Token>>> getToken({required String userId});
  Future<Option<Failure>> setStatus({
    required String status,
    required String tokenID,
  });
  Future<Option<Failure>> setEmployment({required Employment employment});
  Stream<Either<Failure, List<Employment>>> getEmployment(
      {required String userId});
  Future<Option<Failure>> setEmploymentStatus(
      {required String status, required String employmentID});

  Future<Option<Failure>> deleteEmployment({required String employmentID});
}
