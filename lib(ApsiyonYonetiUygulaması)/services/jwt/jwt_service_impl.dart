import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'jwt_service.dart';

@LazySingleton(as: JwtService)
final class JwtServiceImpl implements JwtService {
  @override
  Map<String, dynamic> decode(String token) => JwtDecoder.decode(token);

  @override
  bool isExpired(String token) => JwtDecoder.isExpired(token);
}
