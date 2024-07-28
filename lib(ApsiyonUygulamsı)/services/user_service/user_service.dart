import '../../core/models/user_models/user_data.dart';
import '../../features/home/domain/models/apsiyon_point.dart';

abstract interface class UserService {
  Future<bool> isSignIn();
  Stream<UserData> getUserInfo();
  Future<bool> isApartmentStatus();
  Future<ApsiyonPoint?> getApsiyonPoint(String apsiyonId);
}
