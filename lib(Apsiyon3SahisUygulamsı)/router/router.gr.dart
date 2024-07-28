// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CreateAccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateAccountPage(),
      );
    },
    DescriptionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DescriptionPage(),
      );
    },
    ForYouRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForYouPage(),
      );
    },
    JobMainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const JobMainPage(),
      );
    },
    JobManageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: JobManagePage(),
      );
    },
    JobRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: JobPage(),
      );
    },
    KuryeHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: KuryeHomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(),
      );
    },
    MainKuryeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainKuryePage(),
      );
    },
    OtherRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OtherPage(),
      );
    },
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SplashPage(
          resetToken: args.resetToken,
          userId: args.userId,
        ),
      );
    },
  };
}

/// generated route for
/// [CreateAccountPage]
class CreateAccountRoute extends PageRouteInfo<void> {
  const CreateAccountRoute({List<PageRouteInfo>? children})
      : super(
          CreateAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateAccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DescriptionPage]
class DescriptionRoute extends PageRouteInfo<void> {
  const DescriptionRoute({List<PageRouteInfo>? children})
      : super(
          DescriptionRoute.name,
          initialChildren: children,
        );

  static const String name = 'DescriptionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForYouPage]
class ForYouRoute extends PageRouteInfo<void> {
  const ForYouRoute({List<PageRouteInfo>? children})
      : super(
          ForYouRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForYouRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [JobMainPage]
class JobMainRoute extends PageRouteInfo<void> {
  const JobMainRoute({List<PageRouteInfo>? children})
      : super(
          JobMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobMainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [JobManagePage]
class JobManageRoute extends PageRouteInfo<void> {
  const JobManageRoute({List<PageRouteInfo>? children})
      : super(
          JobManageRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobManageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [JobPage]
class JobRoute extends PageRouteInfo<void> {
  const JobRoute({List<PageRouteInfo>? children})
      : super(
          JobRoute.name,
          initialChildren: children,
        );

  static const String name = 'JobRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [KuryeHomePage]
class KuryeHomeRoute extends PageRouteInfo<void> {
  const KuryeHomeRoute({List<PageRouteInfo>? children})
      : super(
          KuryeHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'KuryeHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainKuryePage]
class MainKuryeRoute extends PageRouteInfo<void> {
  const MainKuryeRoute({List<PageRouteInfo>? children})
      : super(
          MainKuryeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainKuryeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OtherPage]
class OtherRoute extends PageRouteInfo<void> {
  const OtherRoute({List<PageRouteInfo>? children})
      : super(
          OtherRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtherRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    String? resetToken,
    String? userId,
    List<PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(
            resetToken: resetToken,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<SplashRouteArgs> page = PageInfo<SplashRouteArgs>(name);
}

class SplashRouteArgs {
  const SplashRouteArgs({
    this.resetToken,
    this.userId,
  });

  final String? resetToken;

  final String? userId;

  @override
  String toString() {
    return 'SplashRouteArgs{resetToken: $resetToken, userId: $userId}';
  }
}
