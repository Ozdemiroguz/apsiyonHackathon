import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../core/models/kurye/kurye.dart';
import '../../core/models/order/order_data.dart';
import 'kurye_service.dart';

@LazySingleton(as: KuryeService)
class KuryeServiceImpl implements KuryeService {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  KuryeServiceImpl(this._firebaseFirestore, this._firebaseAuth);

  @override
  Stream<Kurye> getKuryeInfo() {
    return _firebaseFirestore
        .collection('other_user')
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      try {
        final result = Kurye.fromJson(snapshot.data()!);
        return result;
      } catch (error) {
        print("User Service Error: $error");
        return Kurye.initial();
      }
    });
  }

  Future<String> getJob(String kuryeId) async {
    try {
      final snapshot =
          await _firebaseFirestore.collection('other_user').doc(kuryeId).get();
      final result = snapshot.data()!['job'];
      return result as String;
    } catch (error) {
      print("User Service Error: $error");
      return 'Other';
    }
  }

  @override
  Future<bool> isSignIn() {
    return Future.value(_firebaseAuth.currentUser != null);
  }

  @override
  Stream<List<OrderData>> getOrders(String kuryeId) {
    return _firebaseFirestore
        .collection('orders')
        .where('kuryeId', isEqualTo: kuryeId)
        .snapshots()
        .map((snapshot) {
      try {
        final result =
            snapshot.docs.map((doc) => OrderData.fromJson(doc.data())).toList();
        return result;
      } catch (error) {
        print("User Service Error: $error");
        return [];
      }
    });
  }
}
