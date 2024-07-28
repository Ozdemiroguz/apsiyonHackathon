import 'dart:developer';
import 'dart:io';

import 'package:apsiyonY/features/home/domain/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/failure/failure.dart';
import '../../domain/models/apsiyon_point.dart';
import '../../domain/models/demand.dart';
import '../../domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
final class HomeRepositoryImpl implements HomeRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  HomeRepositoryImpl(this._firestore, this._firebaseStorage);

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
          return left(
              const Failure.unknownError("No demand found for the user"));
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

  @override
  Future<Option<Failure>> setPost({
    required String title,
    required String content,
    required String apsiyonPointId,
    required String userId,
    required String type,
    required String image,
    required String username,
  }) async {
    try {
      final String url = await uploadImage(image, userId);

      _firestore.collection('posts').add({
        'title': title,
        'content': content,
        'apsiyonPointId': apsiyonPointId,
        'createdAt': Timestamp.now(),
        'userId': userId,
        'type': type,
        'image': url,
        'username': username,
      });
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }

  @override
  Future<String> uploadImage(String path, String userId) async {
    try {
      final Reference ref = _firebaseStorage.ref().child('post/');
      final UploadTask uploadTask = ref.putFile(File(path));

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return "";
    }

    // Returns the download url
  }

  @override
  Future<Either<Failure, List<Post>>> getAnnoucments() async {
    try {
      final snapshot =
          await _firestore.collection("announcement_privilege").get();

      final posts = snapshot.docs.map((doc) {
        return Post.fromJson(doc.data(), doc.id);
      }).toList();

      for (var i = 0; i < posts.length; i++) {
        print(posts[i].image);
      }

      return right(posts);
    } on Exception catch (e) {
      log("Error: $e");
      return left(Failure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getPost(
      {required String apsiyonPointId}) async {
    try {
      final snapshot = await _firestore
          .collection("posts")
          .where("apsiyonPointId", isEqualTo: apsiyonPointId)
          .get();

      final posts = snapshot.docs.map((doc) {
        return Post.fromJson(doc.data(), doc.id);
      }).toList();

      for (var i = 0; i < posts.length; i++) {
        print(posts[i].image);
      }

      return right(posts);
    } on Exception catch (e) {
      log("Error: $e");
      return left(Failure.unknownError(e.toString()));
    }
  }

  Future<String?> getApsiyonPointId({required String userId}) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('uid', arrayContains: userId)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      final doc = snapshot.docs.first;
      final result = doc['apsiyon_id'];

      return result as String;
    } on Exception catch (e) {
      log("Error: $e");
      return null;
    }
  }

  @override
  Future<Option<Failure>> deletePost({required String postId}) async {
    try {
      await _firestore.collection("posts").doc(postId).delete();

      return none();
    } on Exception catch (e) {
      log("Error: $e");
      return some(Failure.unknownError(e.toString()));
    }
  }
}
