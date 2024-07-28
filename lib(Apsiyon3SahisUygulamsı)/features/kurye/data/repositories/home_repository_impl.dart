import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/failure/failure.dart';
import '../../domain/models/apsiyon_point.dart';
import '../../domain/models/demand.dart';
import '../../domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
final class HomeRepositoryImpl implements HomeRepository {
  FirebaseFirestore _firestore;

  HomeRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, List<ApsiyonPoint>>> getApsiyonPoints() async {
    try {
      final snapshot = await _firestore.collection("apsiyon_point").get();

      final apsiyonPoints = snapshot.docs.map((doc) {
        return ApsiyonPoint.fromJson(doc.data(), doc.id);
      }).toList();

      return right(apsiyonPoints);
    } on Exception catch (e) {
      log("Error: $e");
      return left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Option<Failure>> setDemands({
    required String userId,
    required String apartmentNumber,
    required String apsiyonPointId,
    required String apartment_name,
  }) async {
    try {
      await _firestore.collection("demands").doc(userId).set({
        "apsiyon_id": apsiyonPointId,
        "apartment_number": apartmentNumber,
        "status": "waiting",
        "apartment_name": apartment_name,
      });

      await _firestore.collection("users").doc(userId).update({
        "apartment_status": "waiting",
        "apartment_number": apartmentNumber,
        "apsiyon_id": apsiyonPointId,
      });

      return none();
    } on Exception catch (e) {
      log("Error: $e");
      return some(Failure.unknownError(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, Demand>> getDemand({required String userId}) {
    return _firestore
        .collection("demands")
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      try {
        if (!snapshot.exists) {
          return left(Failure.unknownError("No demand found for the user"));
        }

        final demand = Demand.fromJson(snapshot.data()!);

        return right(demand);
      } catch (error) {
        log("Error: $error");
        return left(Failure.unknownError(error.toString()));
      }
    });
  }

  @override
  Future<Option<Failure>> deleteDemand({required String userId}) async {
    try {
      await _firestore.collection("demands").doc(userId).delete();

      return none();
    } on Exception catch (e) {
      log("Error: $e");
      return some(Failure.unknownError(e.toString()));
    }
  }
}
