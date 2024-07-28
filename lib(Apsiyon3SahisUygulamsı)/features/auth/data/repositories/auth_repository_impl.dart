import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/failure/failure.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
final class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  AuthRepositoryImpl(
      this._firebaseAuth, this._firebaseFirestore, this._firebaseStorage);

  @override
  Future<bool> isSignIn() async {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<Option<Failure>> login({
    required String username,
    required String password,
  }) async {
    final userQuerySnapshot = await _firebaseFirestore
        .collection("other_user")
        .where("email", isEqualTo: username)
        .get();

    if (userQuerySnapshot.docs.isEmpty) {
      print("This email is not registered");
      return some(const Failure.auth("This email is not registered"));
    }
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      return none();
    } on FirebaseAuthException catch (e) {
      return some(Failure.auth(e.message ?? "Failed to login"));
    }
  }

  @override
  Future<Option<Failure>> register(
    String name,
    String surname,
    String email,
    String password,
    String phoneNumber,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firebaseFirestore
          .collection("other_user")
          .doc(userCredential.user!.uid)
          .set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email,
        "name": name,
        "surname": surname,
        "status": "waiting",
        "isApsiyonConfirmed": false,
        "phoneNumber": phoneNumber,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return none();
    } catch (e) {
      return some(Failure.auth(e.toString()));
    }
  }

  @override
  Future<Option<Failure>> setJob(String job) async {
    try {
      await _firebaseFirestore
          .collection("other_user")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        "job": job,
      });

      return none();
    } catch (e) {
      return some(Failure.auth(e.toString()));
    }
  }

  @override
  Future<String> uploadImage(String path, String userId) async {
    try {
      final Reference ref = _firebaseStorage.ref().child('user/$userId');
      final UploadTask uploadTask = ref.putFile(File(path));

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return "Error";
    }

    // Returns the download url
  }

  @override
  Future<Option<Failure>> setDesc(
    String desc,
    String socialMedia,
    String imgPath,
  ) async {
    final String url =
        await uploadImage(imgPath, _firebaseAuth.currentUser!.uid);
    try {
      await _firebaseFirestore
          .collection("other_user")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        "desc": desc,
        "socialMedia": socialMedia,
        "imgUrl": url,
      });

      return none();
    } catch (e) {
      return some(Failure.auth(e.toString()));
    }
  }

  @override
  Future<String> getUserJob() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return "No User";
    }

    try {
      final snapshot =
          await _firebaseFirestore.collection("other_user").doc(user.uid).get();

      if (snapshot.data() == null) {
        return "No User";
      }

      if (snapshot.data()!["job"] == null) {
        return "Other";
      }

      return snapshot.data()!["job"].toString();
    } catch (e) {
      return "Error";
    }
  }
}
//kullanıcı firestore ekleme fonksiyonu
