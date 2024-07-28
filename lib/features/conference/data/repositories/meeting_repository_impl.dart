import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/option.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/failure/failure.dart';
import '../../domain/models/meeting.dart';
import '../../domain/repositories/meeting_repository.dart';

@LazySingleton(as: MeetingRepository)
final class MeetingRepositoryImpl implements MeetingRepository {
  final FirebaseFirestore _firebaseFirestore;

  MeetingRepositoryImpl(this._firebaseFirestore);

  @override
  Stream<Either<Failure, List<Meeting>>> getMeeting() {
    try {
      return _firebaseFirestore
          .collection("meeting")
          .snapshots()
          .map((snapshot) {
        final meetingList = snapshot.docs
            .map((doc) => Meeting.fromJson(doc.data(), doc.id))
            .toList();
        return right(meetingList);
      });
    } on Exception catch (e) {
      log("Error: $e");
      return Stream.value(left(Failure.unknownError(e.toString())));
    }
  }

  @override
  Future<Option<Failure>> setMeeting({
    required String title,
    required String description,
    required DateTime date,
    required String location,
    required String type,
    required String apsiyon_pointId,
  }) async {
    // TODO: implement setMeeting

    try {
      _firebaseFirestore.collection("meeting").add({
        "title": title,
        "description": description,
        "date": date,
        "location": location,
        "type": type,
        "status": "upcoming",
        "apsiyon_pointId": apsiyon_pointId,
      });

      return none();
    } on Exception catch (e) {
      log("Error: $e");
      return some(Failure.unknownError(e.toString()));
    }
  }
}

//kullanıcı firestore ekleme fonksiyonu
