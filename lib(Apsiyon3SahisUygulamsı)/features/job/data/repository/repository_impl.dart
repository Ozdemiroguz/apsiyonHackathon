import 'package:apsiyon3/core/models/failure/failure.dart';
import 'package:apsiyon3/features/job/domain/models/employment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/option.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/job_repository.dart';

@LazySingleton(as: JobRepository)
final class JobRepositoryImpl implements JobRepository {
  final FirebaseFirestore _firebaseFirestore;

  JobRepositoryImpl(this._firebaseFirestore);

  @override
  Stream<Either<Failure, List<Employment>>> getEmployment(
      {required String job}) {
    try {
      return _firebaseFirestore
          .collection("employments")
          .where(
            'job',
            isEqualTo: job,
          )
          .snapshots()
          .map((snapshot) {
        final employmentList = snapshot.docs
            .map((doc) => Employment.fromJson(doc.data(), doc.id))
            .toList();
        return right(employmentList);
      });
    } on Exception catch (e) {
      return Stream.value(left(Failure.unknownError(e.toString())));
    }
  }

  @override
  Stream<Either<Failure, List<Employment>>> getPersonalEmployment(
      {required String otherId}) {
    try {
      return _firebaseFirestore
          .collection("employments")
          .where(
            'otherId',
            isEqualTo: otherId,
          )
          .snapshots()
          .map((snapshot) {
        final employmentList = snapshot.docs
            .map((doc) => Employment.fromJson(doc.data(), doc.id))
            .toList();
        return right(employmentList);
      });
    } on Exception catch (e) {
      return Stream.value(left(Failure.unknownError(e.toString())));
    }
  }

  @override
  Future<String> getJob({
    required String userId,
  }) async {
    try {
      final snapshot =
          await _firebaseFirestore.collection('other_user').doc(userId).get();
      final result = snapshot.data()!['job'];
      return result as String;
    } catch (error) {
      print("User Service Error: $error");
      return 'Other';
    }
  }

  @override
  Future<Option<Failure>> setOffer({
    required String employmentId,
    required String otherId,
    required String otherName,
    required String price,
  }) async {
    try {
      await _firebaseFirestore
          .collection("employments")
          .doc(employmentId)
          .update({
        "otherId": otherId,
        "otherName": otherName,
        "price": price,
        "status": "offerreceived",
      });
      return none();
    } catch (e) {
      return some(Failure.unknownError(e.toString()));
    }
  }
}
