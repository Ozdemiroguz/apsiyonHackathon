import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart' hide Order;
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locale_resources_service.dart';

@Order(-1)
@LazySingleton(as: LocaleResourcesService)
final class LocaleResourcesServiceImpl implements LocaleResourcesService {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  const LocaleResourcesServiceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<Option<String>> getRefreshToken() async {
    final token = await secureStorage.read(key: _Keys.refreshToken);

    return optionOf(token);
  }

  @override
  Future<void> setRefreshToken(String token) => secureStorage.write(key: _Keys.refreshToken, value: token);

  @override
  Future<void> deleteRefreshToken() => secureStorage.delete(key: _Keys.refreshToken);

  @override
  Future<Option<String>> getAccessToken() async {
    final token = await secureStorage.read(key: _Keys.accessToken);

    return optionOf(token);
  }

  @override
  Future<void> setAccessToken(String token) => secureStorage.write(key: _Keys.accessToken, value: token);

  @override
  Future<void> deleteAccessToken() => secureStorage.delete(key: _Keys.accessToken);

  @override
  Future<void> setEmail(String email) => secureStorage.write(key: _Keys.email, value: email);

  @override
  Future<Option<String>> getEmail() async {
    final email = await secureStorage.read(key: _Keys.email);

    return optionOf(email);
  }

  @override
  Future<void> deleteEmail() => secureStorage.delete(key: _Keys.email);

  @override
  bool getRememberMe() => sharedPreferences.getBool(_Keys.rememberMe) ?? false;

  @override
  Future<void> setRememberMe(bool value) => sharedPreferences.setBool(_Keys.rememberMe, value);

  @override
  Future<void> clearSecureStorage() => secureStorage.deleteAll();

  @override
  Future<Option<String>> getEmployeeId() async {
    final token = await getAccessToken();

    return token.fold(
      none,
      (t) {
        final decodedToken = JwtDecoder.decode(t);

        // ignore: avoid_dynamic_calls
        return some(decodedToken["https://hasura.io/jwt/claims"]["x-hasura-employee-id"] as String);
      },
    );
  }

  @override
  Future<void> deleteAll() async {
    secureStorage.deleteAll();
    sharedPreferences.clear();
  }
}

abstract final class _Keys {
  static const String refreshToken = "refreshToken";
  static const String accessToken = "accessToken";
  static const String email = "email";
  static const String rememberMe = "rememberMe";
}
