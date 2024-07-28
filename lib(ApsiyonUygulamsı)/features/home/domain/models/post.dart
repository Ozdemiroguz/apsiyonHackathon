import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class Post {
  final String postId;
  final String content;
  final Timestamp createdAt;
  final String image;
  final String userId;
  final String username;
  final String type;
  final String title;
  final String apsiyonPointId;
  final String status;

  Post({
    required this.apsiyonPointId,
    required this.postId,
    required this.content,
    required this.createdAt,
    required this.userId,
    required this.type,
    required this.title,
    required this.image,
    required this.status,
    required this.username,
  });

  factory Post.fromJson(Map<String, dynamic> json, String id) {
    return Post(
      postId: id,
      apsiyonPointId: json['apsiyonPointId'] == null
          ? ''
          : json['apsiyonPointId'] as String,
      content: json['content'] as String,
      createdAt: json['createdAt'] as Timestamp,
      userId: json['userId'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      image: json['image'] == null
          ? ''
          : json['image'] == ''
              ? ''
              : json['image'] as String,
      status: json['status'] == null ? 'active' : json['status'] as String,
      username: json['username'] as String,
    );
  }
}
