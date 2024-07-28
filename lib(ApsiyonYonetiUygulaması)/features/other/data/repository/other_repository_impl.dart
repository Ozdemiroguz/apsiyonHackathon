import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/failure/failure.dart';
import '../../../conference/domain/models/meeting.dart';
import '../../domain/models/token.dart';
import '../../domain/repository/other_repository.dart';

@LazySingleton(as: OtherRepository)
final class OtherRepositoryImpl implements OtherRepository {
  final FirebaseFirestore _firebaseFirestore;

  OtherRepositoryImpl(this._firebaseFirestore);

  @override
  Future<Option<Failure>> setToken(
      {required String tokenDescription,
      required String tokenOtherId,
      required Duration tokenTime,
      required String userId,
      required String apsiyonPointId,
      required String tokenOtherName}) {
    // TODO: implement setToken

    try {
      _firebaseFirestore.collection('tokens').add({
        'tokenDescription': tokenDescription,
        'userId': userId,
        'tokenOtherId': tokenOtherId,
        'apsiyonPointId': apsiyonPointId,
        'tokenOtherName': tokenOtherName,
        'status': 'confirmed',
        'createdAt': Timestamp.now(),
        'expirationDate': Timestamp.now().toDate().add(tokenTime),
      });
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }

  @override
  Stream<Either<Failure, List<Token>>> getToken({required String userId}) {
    try {
      return _firebaseFirestore
          .collection("tokens")
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
        final tokenList = snapshot.docs
            .map((doc) => Token.fromJson(doc.data(), doc.id))
            .toList();
        return right(tokenList);
      });
    } on Exception catch (e) {
      return Stream.value(left(Failure.unknownError(e.toString())));
    }
  }

  @override
  Future<Option<Failure>> setStatus({
    required String status,
    required String tokenID,
  }) {
    try {
      _firebaseFirestore.collection('tokens').doc(tokenID).update({
        'status': status,
      });
      return Future.value(none());
    } catch (e) {
      return Future.value(some(Failure.auth(e.toString())));
    }
  }
}
