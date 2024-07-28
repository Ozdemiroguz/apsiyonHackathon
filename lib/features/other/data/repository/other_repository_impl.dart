import 'package:apsiyon/core/models/failure/failure.dart';
import 'package:apsiyon/features/other/domain/models/employment.dart';
import 'package:apsiyon/features/other/domain/models/token.dart';
import 'package:apsiyon/features/other/domain/repository/other_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/option.dart';
import 'package:injectable/injectable.dart';

import '../../../conference/domain/models/meeting.dart';

@LazySingleton(as: OtherRepository)
final class OtherRepositoryImpl implements OtherRepository {
  final FirebaseFirestore _firebaseFirestore;

  OtherRepositoryImpl(this._firebaseFirestore);

  @override
  Future<Option<Failure>> setToken(
      {required String tokenDescription,
      required String tokenOtherId,
      required Duration tokenTime,
      required String userId,
      required String apsiyonPointId,
      required String tokenOtherName}) {
    // TODO: implement setToken

    try {
      _firebaseFirestore.collection('tokens').add({
        'tokenDescription': tokenDescription,
        'userId': userId,
        'tokenOtherId': tokenOtherId,
        'apsiyonPointId': apsiyonPointId,
        'tokenOtherName': tokenOtherName,
        'status': 'confirmed',
        'createdAt': Timestamp.now(),
        'expirationDate': Timestamp.now().toDate().add(tokenTime),
      });
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }

  @override
  Stream<Either<Failure, List<Token>>> getToken({required String userId}) {
    try {
      return _firebaseFirestore
          .collection("tokens")
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
        final tokenList = snapshot.docs
            .map((doc) => Token.fromJson(doc.data(), doc.id))
            .toList();
        return right(tokenList);
      });
    } on Exception catch (e) {
      return Stream.value(left(Failure.unknownError(e.toString())));
    }
  }

  @override
  Future<Option<Failure>> setStatus({
    required String status,
    required String tokenID,
  }) {
    try {
      _firebaseFirestore.collection('tokens').doc(tokenID).update({
        'status': status,
      });
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }

  @override
  Future<Option<Failure>> setEmployment({required Employment employment}) {
    try {
      _firebaseFirestore.collection('employments').add({
        'title': employment.title,
        'description': employment.description,
        'startDate': Timestamp.now(),
        'job': employment.job,
        'employerId': employment.employerId,
        'employerName': employment.employerName,
        'employerAddress': employment.employerAddress,
        'employerPhone': employment.employerPhone,
        'status': employment.status,
        'price': employment.price,
        'otherId': employment.otherId,
        'otherName': employment.otherName,
      });
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }

  @override
  Stream<Either<Failure, List<Employment>>> getEmployment(
      {required String userId}) {
    try {
      return _firebaseFirestore
          .collection("employments")
          .where(
            'employerId',
            isEqualTo: userId,
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
  Future<Option<Failure>> setEmploymentStatus(
      {required String status, required String employmentID}) {
    try {
      if (status == "waiting") {
        _firebaseFirestore.collection('employments').doc(employmentID).update({
          'status': status,
          'price': '',
          'otherId': null,
          'otherName': null,
        });
        return Future.value(none());
      }
      _firebaseFirestore.collection('employments').doc(employmentID).update({
        'status': status,
      });
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }

  @override
  Future<Option<Failure>> deleteEmployment({required String employmentID}) {
    try {
      _firebaseFirestore.collection('employments').doc(employmentID).delete();
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }
}
