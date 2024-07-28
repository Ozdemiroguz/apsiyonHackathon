import 'package:fpdart/fpdart.dart';

abstract class LocaleResourcesService {
  Future<Option<String>> getRefreshToken();
  Future<void> setRefreshToken(String token);
  Future<void> deleteRefreshToken();
  Future<Option<String>> getAccessToken();
  Future<void> setAccessToken(String token);
  Future<void> deleteAccessToken();
  Future<void> setEmail(String email);
  Future<Option<String>> getEmail();
  Future<void> deleteEmail();
  bool getRememberMe();
  Future<void> setRememberMe(bool value);

  /// Clears all data from secure storage. Use with caution.
  Future<void> clearSecureStorage();
  Future<Option<String>> getEmployeeId();
  Future<void> deleteAll();
}
