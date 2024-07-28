import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../constants/failure_message.dart';
import '../../core/models/failure/failure.dart';
import '../locale/locale_resources_service.dart';
import 'network_info.dart';
import 'network_service.dart';

@LazySingleton(as: NetworkService)
final class NetworkServiceImpl implements NetworkService {
  final LocaleResourcesService localeResourcesService;
  final NetworkInfo networkInfo;
  final Dio _dio;

  NetworkServiceImpl(
    this._dio, {
    required this.localeResourcesService,
    required this.networkInfo,
  }) {
    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onResponse: (e, handler) {},
    //     onError: (e, handler) async {
    //       log(e.toString());

    //       if (e.response?.statusCode == 422) {
    //         getIt<AppRouter>().replaceAll([const LoginRoute()]);

    //         return handler.reject(e);
    //       }

    //       return handler.next(e);
    //     },
    //   ),
    // );
    _addSentryInterceptors();
  }

  @override
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void setHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  @override
  void setHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  @override
  void setToken(String token) {
    _dio.options.headers["Authorization"] = 'Bearer $token';
  }

  @override
  void clearToken() {
    _dio.options.headers.remove("Authorization");
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async =>
      _tryCatch(() => _dio.get(url, queryParameters: queryParameters));

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
  }) {
    return _tryCatch(
      () async => _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: Map.of(_dio.options.headers)..addAll(optionalHeaders ?? {}),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> put(
    String url, {
    dynamic data,
  }) =>
      _tryCatch(() => _dio.put(url, data: data));

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> delete(
    String url, {
    dynamic data,
  }) =>
      _tryCatch(() => _dio.delete(url, data: data));

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> patch(
    String url, {
    dynamic data,
  }) =>
      _tryCatch(() => _dio.patch(url, data: data));

  Future<Either<Failure, Response<Map<String, dynamic>>>> _tryCatch<T>(
    AsyncValueGetter<Response<Map<String, dynamic>>> operation,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await operation();

        // if (result.data?["status"] == 401) {
        //   localeResourcesService.clearSecureStorage();
        //   clearToken();

        //   getIt<AppRouter>().replaceAll([const LoginRoute()]);

        //   return left(Failure.responseError(result.data?["message"] as String? ?? unknownErrorMessage));
        // }

        if (result.data?["email"] != null) {
          return right(result);
        }
        if (result.data?["token"] != null) {
          return right(result);
        }
        return left(Failure.responseError(
            result.data?["message"] as String? ?? unknownErrorMessage));
      } else {
        return left(Failure.noConnection(noConnectionMessage));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return left(
          Failure.connectionTimedOut(connectionTimedOutMessage),
        );
      } else {
        return left(
          Failure.responseError(
            (e.response?.data as Map<String, dynamic>?)?["message"]
                    .toString() ??
                e.message ??
                e.error.toString(),
          ),
        );
      }
    } on TimeoutException {
      return left(
        Failure.connectionTimedOut(connectionTimedOutMessage),
      );
    } catch (e) {
      return left(Failure.unknownError(unknownErrorMessage));
    }
  }

  @override
  String getToken() {
    return _dio.options.headers["Authorization"] as String;
  }

  void _addSentryInterceptors() {
    _dio.addSentry();
    late ISentrySpan transaction;
    _dio.interceptors
      ..clear()
      ..add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            try {
              transaction = Sentry.startTransaction(
                options.path.split("/").last,
                options.path,
                startTimestamp: DateTime.now(),
                bindToScope: true,
              );
              transaction.setData(
                "Request",
                {
                  "url": options.path,
                  "method": options.method,
                  "headers": options.headers,
                  "data": options.data,
                  "queryParameters": options.queryParameters,
                },
              );
            } on Exception catch (e) {
              log(e.toString());
            }

            return handler.next(options);
          },
          onError: (error, handler) async {
            try {
              transaction.status = SpanStatus.fromHttpStatusCode(
                (error.response?.data as Map?)
                        ?.extract<int>('code')
                        .toNullable() ??
                    error.response?.statusCode ??
                    0,
              );

              transaction.setData(
                "Response",
                {
                  "data": error.response?.data ?? "",
                  "statusCode": error.response?.statusCode ?? "",
                  "errorMessage": error.message ?? "",
                  "errorType": error.type.toString(),
                  "stackTrace": error.stackTrace.toString(),
                },
              );

              transaction.finish();

              return handler.next(error);
            } catch (e) {
              log(e.toString());
              return handler.next(error);
            }
          },
          onResponse: (e, handler) {
            transaction.status = SpanStatus.fromHttpStatusCode(
                (e.data as Map?)?.extract<int>('code').getOrElse(() => 0) ?? 0);

            transaction.setData(
              "response",
              {
                "data": e.data,
                "statusCode": e.statusCode,
                "errorMessage": "",
                "errorType": "",
                "stackTrace": "",
              },
            );

            transaction.finish();

            return handler.next(e);
          },
        ),
      );
  }

  @override
  Future<Response<List<dynamic>>> getList(String url) async {
    final dio = Dio();

    return await dio.get(url);
  }
}
