import 'package:fpdart/fpdart.dart';

import '../../../../core/models/failure/failure.dart';
import '../models/token.dart';

abstract interface class OtherRepository {
  Future<Option<Failure>> setToken(
      {required String tokenDescription,
      required String tokenOtherId,
      required Duration tokenTime,
      required String userId,
      required String apsiyonPointId,
      required String tokenOtherName});
  Stream<Either<Failure, List<Token>>> getToken({required String tokenOtherId});
  Future<Option<Failure>> setStatus({
    required String status,
    required String tokenID,
  });
}
