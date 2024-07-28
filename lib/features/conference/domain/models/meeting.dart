import 'package:cloud_firestore/cloud_firestore.dart';

class Meeting {
  final String meetingID;
  final String apsiyon_pointId;
  final String title;
  final String description;
  final Timestamp date;
  final String location;
  final String type;
  final String status;

  Meeting({
    required this.meetingID,
    required this.apsiyon_pointId,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.type,
    required this.status,
  });

  //json to object
  factory Meeting.fromJson(Map<String, dynamic> json, String id) {
    return Meeting(
      meetingID: id,
      apsiyon_pointId: json['apsiyon_pointId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as Timestamp,
      location: json['location'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
    );
  }
}
