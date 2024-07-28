// ignore_for_file: avoid_classes_with_only_static_members

abstract final class Endpoints {
  static const baseUrlAuth = "http://localhost:3000/";

  static const login = "${baseUrlAuth}api/auths/login";
  static const register = "${baseUrlAuth}api/auths/register";
}
