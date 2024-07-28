// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i14;

import 'package:cloud_firestore/cloud_firestore.dart' as _i10;
import 'package:cross_connectivity/cross_connectivity.dart' as _i8;
import 'package:dio/dio.dart' as _i12;
import 'package:firebase_auth/firebase_auth.dart' as _i9;
import 'package:firebase_storage/firebase_storage.dart' as _i11;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i17;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i16;
import '../../features/job/data/repository/repository_impl.dart' as _i19;
import '../../features/job/domain/repository/job_repository.dart' as _i18;
import '../../features/kurye/data/repositories/home_repository_impl.dart'
    as _i29;
import '../../features/kurye/domain/repositories/home_repository.dart' as _i28;
import '../../features/other/data/repository/other_repository_impl.dart'
    as _i27;
import '../../features/other/domain/repository/other_repository.dart' as _i26;
import '../../router/router.dart' as _i7;
import '../../services/jwt/jwt_service.dart' as _i24;
import '../../services/jwt/jwt_service_impl.dart' as _i25;
import '../../services/kurye_service/kurye_service.dart' as _i30;
import '../../services/kurye_service/kurye_service_impl.dart' as _i31;
import '../../services/locale/locale_resources_service.dart' as _i3;
import '../../services/locale/locale_resources_service_impl.dart' as _i4;
import '../../services/location/location_service.dart' as _i22;
import '../../services/location/location_service_impl.dart' as _i23;
import '../../services/network/network_info.dart' as _i20;
import '../../services/network/network_info_impl.dart' as _i21;
import '../../services/network/network_service.dart' as _i32;
import '../../services/network/network_service_impl.dart' as _i33;
import '../models/usecases/base_64_encode.dart' as _i15;
import '../models/usecases/usecase.dart' as _i13;
import 'register_module.dart' as _i34;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.LocaleResourcesService>(
        () => _i4.LocaleResourcesServiceImpl(
              secureStorage: gh<_i5.FlutterSecureStorage>(),
              sharedPreferences: gh<_i6.SharedPreferences>(),
            ));
    gh.lazySingleton<_i7.AppRouter>(() => registerModule.appRouter);
    gh.lazySingleton<_i8.Connectivity>(() => registerModule.connectivity);
    await gh.lazySingletonAsync<_i6.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i5.FlutterSecureStorage>(
        () => registerModule.secureStorage);
    gh.lazySingleton<_i9.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i10.FirebaseFirestore>(
        () => registerModule.firebaseFirestore);
    gh.lazySingleton<_i11.FirebaseStorage>(
        () => registerModule.firebaseStorage);
    gh.lazySingleton<_i12.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i13.UseCase<String, _i14.Uint8List>>(
        () => const _i15.Base64Encode());
    gh.lazySingleton<_i16.AuthRepository>(() => _i17.AuthRepositoryImpl(
          gh<_i9.FirebaseAuth>(),
          gh<_i10.FirebaseFirestore>(),
          gh<_i11.FirebaseStorage>(),
        ));
    gh.lazySingleton<_i18.JobRepository>(
        () => _i19.JobRepositoryImpl(gh<_i10.FirebaseFirestore>()));
    gh.lazySingleton<_i20.NetworkInfo>(
        () => _i21.NetworkInfoImpl(connectivity: gh<_i8.Connectivity>()));
    gh.lazySingleton<_i22.LocationService>(
        () => const _i23.LocationServiceImpl());
    gh.lazySingleton<_i24.JwtService>(() => _i25.JwtServiceImpl());
    gh.lazySingleton<_i26.OtherRepository>(
        () => _i27.OtherRepositoryImpl(gh<_i10.FirebaseFirestore>()));
    gh.lazySingleton<_i28.HomeRepository>(
        () => _i29.HomeRepositoryImpl(gh<_i10.FirebaseFirestore>()));
    gh.lazySingleton<_i30.KuryeService>(() => _i31.KuryeServiceImpl(
          gh<_i10.FirebaseFirestore>(),
          gh<_i9.FirebaseAuth>(),
        ));
    gh.lazySingleton<_i32.NetworkService>(() => _i33.NetworkServiceImpl(
          gh<_i12.Dio>(),
          localeResourcesService: gh<_i3.LocaleResourcesService>(),
          networkInfo: gh<_i20.NetworkInfo>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i34.RegisterModule {
  @override
  _i7.AppRouter get appRouter => _i7.AppRouter();

  @override
  _i8.Connectivity get connectivity => _i8.Connectivity();
}
