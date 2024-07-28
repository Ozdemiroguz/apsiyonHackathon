import 'package:fpdart/fpdart.dart';

import '../../../../core/models/failure/failure.dart';

abstract interface class AuthRepository {
  Future<bool> isSignIn();
  Future<String> getUserJob();
  Future<Option<Failure>> login(
      {required String username, required String password});

  Future<Option<Failure>> register(
    String name,
    String surname,
    String email,
    String password,
    String phoneNumber,
  );
  Future<Option<Failure>> setJob(String job);
  Future<Option<Failure>> setDesc(
    String desc,
    String socialMedia,
    String imagePath,
  );
  Future<String> uploadImage(String path, String uid);
}
