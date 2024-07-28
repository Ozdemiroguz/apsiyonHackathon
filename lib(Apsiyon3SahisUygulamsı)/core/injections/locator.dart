import 'package:apsiyon3/core/injections/locator.config.dart';
import 'package:apsiyon3/features/job/domain/repository/job_repository.dart';
import 'package:apsiyon3/features/kurye/domain/repositories/home_repository.dart';
import 'package:apsiyon3/features/other/domain/repository/other_repository.dart';
import 'package:apsiyon3/services/kurye_service/kurye_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../router/router.dart';
import '../../services/locale/locale_resources_service.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true)
Future<void> configureDependencies() => getIt.init();

final appRouterProvider = Provider.autoDispose((ref) => getIt<AppRouter>());

final localeResourcesServiceProvider =
    Provider.autoDispose((ref) => getIt<LocaleResourcesService>());

final authRepositoryProvider =
    Provider.autoDispose((ref) => getIt<AuthRepository>());

final kuryeRepositoryProvider =
    Provider.autoDispose((ref) => getIt<HomeRepository>());

final kuryeServiceProvider =
    Provider.autoDispose((ref) => getIt<KuryeService>());

final otherRepositoryProvider =
    Provider.autoDispose((ref) => getIt<OtherRepository>());

final jobRepositoryProvider =
    Provider.autoDispose((ref) => getIt<JobRepository>());
