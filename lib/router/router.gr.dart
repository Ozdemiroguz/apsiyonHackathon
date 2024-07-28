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
    AccountInfoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountInfoPage(),
      );
    },
    ApartmentGateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ApartmentGatePage(),
      );
    },
    ApartmentStatusRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ApartmentStatusPage(),
      );
    },
    CreateAccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateAccountPage(),
      );
    },
    ForYouRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForYouPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(),
      );
    },
    MainOtherRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainOtherPage(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    MeetingEnterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MeetingEnterPage(),
      );
    },
    MeetingHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MeetingHomePage(),
      );
    },
    OtherRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OtherPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterPage(),
      );
    },
    RegisterVerificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterVerificationPage(),
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
    VideoConferenceRoute.name: (routeData) {
      final args = routeData.argsAs<VideoConferenceRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VideoConferencePage(
          key: args.key,
          conferenceID: args.conferenceID,
          userID: args.userID,
        ),
      );
    },
  };
}

/// generated route for
/// [AccountInfoPage]
class AccountInfoRoute extends PageRouteInfo<void> {
  const AccountInfoRoute({List<PageRouteInfo>? children})
      : super(
          AccountInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountInfoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ApartmentGatePage]
class ApartmentGateRoute extends PageRouteInfo<void> {
  const ApartmentGateRoute({List<PageRouteInfo>? children})
      : super(
          ApartmentGateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApartmentGateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ApartmentStatusPage]
class ApartmentStatusRoute extends PageRouteInfo<void> {
  const ApartmentStatusRoute({List<PageRouteInfo>? children})
      : super(
          ApartmentStatusRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApartmentStatusRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

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
/// [MainOtherPage]
class MainOtherRoute extends PageRouteInfo<void> {
  const MainOtherRoute({List<PageRouteInfo>? children})
      : super(
          MainOtherRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainOtherRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MeetingEnterPage]
class MeetingEnterRoute extends PageRouteInfo<void> {
  const MeetingEnterRoute({List<PageRouteInfo>? children})
      : super(
          MeetingEnterRoute.name,
          initialChildren: children,
        );

  static const String name = 'MeetingEnterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MeetingHomePage]
class MeetingHomeRoute extends PageRouteInfo<void> {
  const MeetingHomeRoute({List<PageRouteInfo>? children})
      : super(
          MeetingHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MeetingHomeRoute';

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
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterVerificationPage]
class RegisterVerificationRoute extends PageRouteInfo<void> {
  const RegisterVerificationRoute({List<PageRouteInfo>? children})
      : super(
          RegisterVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterVerificationRoute';

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

/// generated route for
/// [VideoConferencePage]
class VideoConferenceRoute extends PageRouteInfo<VideoConferenceRouteArgs> {
  VideoConferenceRoute({
    Key? key,
    required String conferenceID,
    required String userID,
    List<PageRouteInfo>? children,
  }) : super(
          VideoConferenceRoute.name,
          args: VideoConferenceRouteArgs(
            key: key,
            conferenceID: conferenceID,
            userID: userID,
          ),
          initialChildren: children,
        );

  static const String name = 'VideoConferenceRoute';

  static const PageInfo<VideoConferenceRouteArgs> page =
      PageInfo<VideoConferenceRouteArgs>(name);
}

class VideoConferenceRouteArgs {
  const VideoConferenceRouteArgs({
    this.key,
    required this.conferenceID,
    required this.userID,
  });

  final Key? key;

  final String conferenceID;

  final String userID;

  @override
  String toString() {
    return 'VideoConferenceRouteArgs{key: $key, conferenceID: $conferenceID, userID: $userID}';
  }
}
