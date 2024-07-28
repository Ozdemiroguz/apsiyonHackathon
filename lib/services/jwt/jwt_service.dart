abstract class JwtService {
  Map<String, dynamic> decode(String token);

  bool isExpired(String token);
}
