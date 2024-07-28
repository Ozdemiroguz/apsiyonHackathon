import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/models/failure/failure.dart';

abstract interface class NetworkService {
  void setBaseUrl(String baseUrl);
  void setHeader(String key, String value);
  void setHeaders(Map<String, String> headers);
  void setToken(String token);
  void clearToken();
  String getToken();

  Future<Either<Failure, Response<Map<String, dynamic>>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Response<Map<String, dynamic>>>> post(
    String url, {
    Map<String, dynamic>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
    dynamic data,
  });

  Future<Either<Failure, Response<Map<String, dynamic>>>> put(
    String url, {
    dynamic data,
  });

  Future<Either<Failure, Response<Map<String, dynamic>>>> patch(
    String url, {
    dynamic data,
  });

  Future<Either<Failure, Response<Map<String, dynamic>>>> delete(
    String url, {
    dynamic data,
  });

  Future<Response<List<dynamic>>> getList(String url);
}
