import 'package:cloud_firestore/cloud_firestore.dart';

class Token {
  final String tokenId;
  final String tokenDescription;
  final Timestamp createdAt;
  final Timestamp expirationDate;
  final String status;
  final String userId;
  final String tokenOtherId;
  final String apsiyonPointId;
  final String tokenOtherName;

  Token({
    required this.tokenId,
    required this.tokenDescription,
    required this.createdAt,
    required this.expirationDate,
    required this.status,
    required this.userId,
    required this.tokenOtherId,
    required this.apsiyonPointId,
    required this.tokenOtherName,
  });

  factory Token.fromJson(Map<String, dynamic> json, String id) {
    return Token(
      tokenId: id,
      tokenDescription: json['tokenDescription'] as String,
      createdAt: json['createdAt'] as Timestamp,
      expirationDate: json['expirationDate'] as Timestamp,
      status: json['status'] as String,
      userId: json['userId'] as String,
      tokenOtherId: json['tokenOtherId'] as String,
      apsiyonPointId: json['apsiyonPointId'] as String,
      tokenOtherName: json['tokenOtherName'] as String,
    );
  }
}
