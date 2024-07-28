import 'package:fpdart/fpdart.dart';

import '../../../../core/models/failure/failure.dart';
import '../models/apsiyon_point.dart';
import '../models/demand.dart';
import '../models/post.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<ApsiyonPoint>>> getApsiyonPoints();
  Future<String?> getApsiyonPointId({required String userId});
  Future<Option<Failure>> setDemands({
    required String userId,
    required String apartmentNumber,
    required String apsiyonPointId,
    required String apartment_name,
  });
  Stream<Either<Failure, Demand>> getDemand({required String userId});
  //deleteDemand
  Future<Option<Failure>> deleteDemand({required String userId});
  Future<Either<Failure, List<Post>>> getPost({required String apsiyonPointId});
  Future<Either<Failure, List<Post>>> getAnnoucments();
  Future<Option<Failure>> setPost({
    required String title,
    required String content,
    required String apsiyonPointId,
    required String userId,
    required String type,
    required String image,
    required String username,
  });
  Future<String> uploadImage(String path, String userId);
  Future<Option<Failure>> deletePost({required String postId});
}
