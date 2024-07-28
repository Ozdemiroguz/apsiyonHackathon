import 'package:apsiyon/features/auth/presentation/pages/create_account_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/register_verification_page.dart';
import '../features/conference/presentation/pages/meeting_enter_page.dart';
import '../features/conference/presentation/pages/meeting_home_page.dart';
import '../features/conference/presentation/pages/meeting_page.dart';
import '../features/home/presentation/pages/account_info_page.dart';
import '../features/home/presentation/pages/apartment_gate_page.dart';
import '../features/home/presentation/pages/apartment_status_page.dart';
import '../features/home/presentation/pages/foryou_page.dart';
import '../features/home/presentation/pages/home_page.dart';

import '../features/home/presentation/pages/main_page.dart';
import '../features/other/presentation/pages/main_other_page.dart';
import '../features/other/presentation/pages/other_page.dart';
import '../splash_page.dart';

part "router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page|Screen|View|Widget|Tab,Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),

        //Auth
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: RegisterVerificationRoute.page),
        AutoRoute(page: CreateAccountRoute.page),

        //Intro

        //Home
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: AccountInfoRoute.page),
          AutoRoute(page: MeetingHomeRoute.page),
          AutoRoute(page: ForYouRoute.page),
          AutoRoute(page: OtherRoute.page),
          AutoRoute(page: MainOtherRoute.page),
          AutoRoute(page: HomeRoute.page, initial: true),
        ]),
        AutoRoute(page: ApartmentStatusRoute.page),

        //Conference
        AutoRoute(page: MeetingEnterRoute.page),
        AutoRoute(page: VideoConferenceRoute.page),
      ];
}
