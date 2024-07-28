import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/durations.dart';
import '../../router/router.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AppRouter get appRouter;

  @lazySingleton
  Connectivity get connectivity;

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          connectTimeout: timeoutDuration,
          receiveTimeout: timeoutDuration,
          sendTimeout: timeoutDuration,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            // 'accept-language': Intl.defaultLocale,
            // "Authorization":
            //     "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IkZEN0U2NUYwNDY4MTJBQjQyNTAzNEQwNkUwM0MxNDYwNEM2ODU1NDEiLCJ4NXQiOiJfWDVsOEVhQktyUWxBMDBHNER3VVlFeG9WVUUiLCJ0eXAiOiJhdCtqd3QifQ.eyJzdWIiOiIzYTBkYTBlOS05M2IwLTg3OTUtZGY2NS0yYTE4ZTAxYmNmYmUiLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiIzMTE2NjAxMjg0MiIsImVtYWlsIjoidWJzX3NlZl9wZXJzb25lbEBwaXRvbi5jb20udHIiLCJnaXZlbl9uYW1lIjoiTmF6YW4iLCJmYW1pbHlfbmFtZSI6IkVydHXEn3J1bCIsInBob25lX251bWJlciI6IjA1MDcwMTE3NzMwIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjoiRmFsc2UiLCJlbWFpbF92ZXJpZmllZCI6IkZhbHNlIiwidW5pcXVlX25hbWUiOiIzMTE2NjAxMjg0MiIsInBhcmVudF9vcmdhbml6YXRpb25fdW5pdF9pZCI6IjNhMGRhMGUxLTVmZDEtNjcyMy1iMmYxLTc5YWE1ZWZlNzU3MiIsInBhcmVudF9vcmdhbml6YXRpb25fdW5pdF9uYW1lIjoiVWtvbWUgxZ51YmUgTcO8ZMO8cmzDvMSfw7wiLCJvcmdhbml6YXRpb25fdW5pdF9pZCI6IjNhMGRhMGUzLTg0ODUtNTQwMS05MzcyLWZmN2JlNWE0NmRhMiIsIm9yZ2FuaXphdGlvbl91bml0X25hbWUiOiJQcm9qZSBLb29yZGluYXN5b24gxZ5lZmxpxJ9pIiwidGVuYW50aWQiOiIzYTBkYTBkNS1hM2U1LWQ0ZWYtNjAxNC0wM2YzMjAwMzNmMzgiLCJhcHBsaWNhdGlvbl9zY29wZV9pZCI6ImE0ZDM4MDc0LTRhNWEtNDU2Yi1iMTI2LWU4NTk2ZDgxMTFjZiIsIm9pX3Byc3QiOiJBdXRoZW50aWNhdG9yX0FwcCIsImNsaWVudF9pZCI6IkF1dGhlbnRpY2F0b3JfQXBwIiwib2lfdGtuX2lkIjoiM2EwZjQxNzQtZjVmOC1jNzk2LTQ2NjQtZGI3NmRmZGExMDZiIiwiYXVkIjoiQXV0aGVudGljYXRvciIsInNjb3BlIjoiQXV0aGVudGljYXRvciIsImp0aSI6Ijg4ZmVmOWM5LTdhNWQtNDQ3Yy05ZWQ0LWE2YzgxZDAzMTcyMSIsImV4cCI6MTcwMTY4NjcwNCwiaXNzIjoiaHR0cHM6Ly91YnMtYXV0aC1hcGktZGV2LnBpdG9uLmNvbS50ci8iLCJpYXQiOjE3MDE2MDAzMDR9.F8gqFp1OtyW5jbhLMtwkZcHXEVZ5D2LDfUKNq8ScxQgHpUbbKXqRn53C_f2KR_-sTyUFIi9FHZ1pFV4Wypl6ppgKmR0DcRbQ4FSR0CrgBod8ooy9in7nGQTB2cl77oQ6Gspi2J0vh_uT4KjIFz7lkMvN0bmUeZUggrj1uDOnhfYgx0NgF8ttR3IKt27oyf_dXcS5sQfUu9CiIPZjO3d0o8aZZXgflUZ1nb_K4m_Z0KCpvfU6meX8iKXST1UrCMQG_ovK4E65BZoG4iZrH2s6q_dTUNJNg0ai1jI88uT_eIXCOCpr9hBmIQ3kBDN7_uPMbW9Vjgwm3Ih9XMMUtQdY_WKIjCrESBZDaZ9ZqDUILXJIi9OkmeN3UyFfZSME8iQUQxBhOE84gS0qEwh9ZjIlZIFF2JrIrzuSN9ymQo0x1Y87DZG14Vdy04JT2ZRk8fHu0sZeEd8_lmXUoU6UPxTdAi7KSjJSYpKH2QupdGawM2guf_C2UFagdz_4g-slqKqKQTrsLR6jO_1G-5A5WrFTDElwtxADfVoBKu0qdeX49gFn_yR42iTmQhxVwV1te985bievXeD1yWFp2GlGydxffMgQsJja9Gt3L_-DI_1pFZRLCE1bDK34_kRn0LE0VDe_mZ5JyEk9mkvBQRgGdjyzNs8aQhxtF9teY6o5q8vAg2E"
          },
        ),
      );
}
