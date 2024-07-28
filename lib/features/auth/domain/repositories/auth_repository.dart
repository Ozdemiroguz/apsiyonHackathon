import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/models/failure/failure.dart';

abstract interface class AuthRepository {
  Future<bool> isSignIn();
  Future<Option<Failure>> login(
      {required String username, required String password});

  Future<Either<Failure, Map<String, String?>>> verifyPhoneNumber(
      {required String phoneNumber});

  Future<Either<Failure, PhoneAuthCredential>> signInWithSmsCode({
    required String verificationId,
    required String smsCode,
  });
  Future<Either<Failure, FirebaseAuthException>> addInformation(
    String name,
    String surname,
    String email,
    String password,
    PhoneAuthCredential phoneAuthCredential,
  );
}
