import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/models/user_models/user_data.dart';
import '../../features/home/domain/models/apsiyon_point.dart';
import 'user_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserService)
final class UserServiceImpl implements UserService {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  UserServiceImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Stream<UserData> getUserInfo() {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return Stream.error('No user is currently signed in.');
    }

    final uid = user.uid;

    return _firebaseFirestore
        .collection('users')
        .where('uid', arrayContains: uid)
        .snapshots()
        .map((snapshot) {
      try {
        if (snapshot.docs.isEmpty) {
          throw 'No user data found for the current user.';
        }

        final doc = snapshot.docs.first;
        final result = UserData.fromJson(doc.data());

        return result;
      } catch (error) {
        print("User Service Error: $error");
        return UserData.initial();
      }
    });
  }

  @override
  Future<bool> isSignIn() {
    return Future.value(_firebaseAuth.currentUser != null);
  }

  Future<bool> isApartmentStatus() {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return Future.error('No user is currently signed in.');
    }

    final uid = user.uid;

    return _firebaseFirestore
        .collection('users')
        .where('uid', arrayContains: uid)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        return false;
      }

      final doc = snapshot.docs.first;
      final result = doc['apartment_status'];

      return result == 'accepted';
    });
  }

  @override
  Future<ApsiyonPoint?> getApsiyonPoint(String apsiyonId) {
    try {
      return _firebaseFirestore
          .collection('apsiyon_point')
          .doc(apsiyonId)
          .get()
          .then((doc) {
        if (!doc.exists) {
          throw 'No apsiyon point found for the current user.';
        }

        final result = ApsiyonPoint.fromJson(doc.data()!, doc.id);
        return result;
      });
    } catch (e) {
      print("User Service Error: $e");
      return Future.error(e);
    }
  }
}
