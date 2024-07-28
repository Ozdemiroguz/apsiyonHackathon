import 'package:apsiyonY/features/conference/domain/models/meeting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/models/failure/failure.dart';

abstract interface class MeetingRepository {
  Stream<Either<Failure, List<Meeting>>> getMeeting();
  Future<Option<Failure>> setMeeting({
    required String title,
    required String description,
    required DateTime date,
    required String location,
    required String type,
    required String apsiyon_pointId,
  });

  Future<Option<Failure>> setStatus(String meetingId, String status);
}
