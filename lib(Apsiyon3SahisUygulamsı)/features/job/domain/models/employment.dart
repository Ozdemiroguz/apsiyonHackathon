import 'package:cloud_firestore/cloud_firestore.dart';

class Employment {
  final String id;
  final String title;
  final String description;
  final Timestamp startDate;
  final String job;
  final String? price;
  final String employerId;
  final String employerName;
  final String employerAddress;
  final String employerPhone;
  final String status;
  final String? otherId;
  final String? otherName;

  Employment({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.job,
    required this.employerName,
    required this.employerId,
    required this.employerAddress,
    required this.employerPhone,
    required this.status,
    this.price,
    this.otherId,
    this.otherName,
  });

  factory Employment.fromJson(Map<String, dynamic> json, String id) {
    return Employment(
      id: id,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as Timestamp,
      job: json['job'] as String,
      employerId: json['employerId'] as String,
      employerName: json['employerName'] as String,
      employerAddress: json['employerAddress'] as String,
      employerPhone: json['employerPhone'] as String,
      status: json['status'] as String,
      price: json['price'] as String?,
      otherId: json['otherId'] as String?,
      otherName: json['otherName'] as String?,
    );
  }
}
