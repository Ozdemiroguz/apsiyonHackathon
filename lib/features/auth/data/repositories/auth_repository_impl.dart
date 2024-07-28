import 'dart:async';
import 'package:apsiyon/services/user_service/user_service_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/failure/failure.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
final class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepositoryImpl(this._firebaseAuth, this._firebaseFirestore);

  @override
  Future<bool> isSignIn() async {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<Option<Failure>> login({
    required String username,
    required String password,
  }) async {
    try {
      // Kullanıcıyı kontrol et
      final userQuerySnapshot = await _firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: username)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        print("This email is not registered");
        return some(const Failure.auth("This email is not registered"));
      }

      // Kullanıcıyı Firebase Auth ile giriş yaptır
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
  Future<Either<Failure, Map<String, String?>>> verifyPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      final completer = Completer<Either<Failure, Map<String, String?>>>();

      _firebaseFirestore
          .collection("users")
          .where("phoneNumber", isEqualTo: phoneNumber)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          completer.complete(
            left(const Failure.auth("This phone number is already registered")),
          );
        } else {
          await _firebaseAuth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) async {
              // Doğrulama otomatik olarak tamamlandığında burada bir şey yapmanıza gerek yok
            },
            verificationFailed: (FirebaseAuthException e) {
              // Hata durumunda Failure döndürülür
              completer.complete(
                  left(Failure.auth(e.message ?? 'Verification failed')));
            },
            codeSent: (String verificationId, int? resendToken) async {
              // verificationId ve resendToken'ı burada alıyoruz

              //önceden kaydedilen bir numara olup olmadığını kontrol ediyoruz

              completer.complete(
                right({
                  "verificationId": verificationId,
                  "resendToken": resendToken?.toString(),
                }),
              );
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              // Kodun otomatik olarak alınma süresi dolduğunda burada bir şey yapmanıza gerek yok
            },
          );
        }
      });

      return completer.future;
    } catch (e) {
      // Diğer hata durumları için
      return left(Failure.unknownError(e.toString()));
    }
  }

  Future<Either<Failure, PhoneAuthCredential>> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      return right(credential);
    } catch (e) {
      return left(Failure.auth(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FirebaseAuthException>> addInformation(
    String name,
    String surname,
    String email,
    String password,
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    try {
      final phoneUserCredendial =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firebaseFirestore
          .collection("users")
          .doc(userCredential.user!.uid + phoneUserCredendial.user!.uid)
          .set({
        "uid": [userCredential.user!.uid, phoneUserCredendial.user!.uid],
        "email": userCredential.user!.email,
        "name": name,
        "surname": surname,
        "apartment_number": "",
        "apartment_status": "waiting",
        "apsiyon_id": "",
        "phoneNumber": phoneUserCredendial.user!.phoneNumber,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return right(FirebaseAuthException(code: "200", message: "Success"));
    } catch (e) {
      return left(Failure.auth(e.toString()));
    }
  }
}
//kullanıcı firestore ekleme fonksiyonu