import 'package:apsiyon3/features/auth/presentation/pages/job_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/create_account_page.dart';
import '../features/auth/presentation/pages/descripton_page.dart';
import '../features/auth/presentation/pages/login_page.dart';

import '../features/job/presentation/pages/job_main_page.dart';
import '../features/job/presentation/pages/job_manage_page.dart';
import '../features/kurye/presentation/pages/foryou_page.dart';
import '../features/kurye/presentation/pages/kurye_home_page.dart';

import '../features/kurye/presentation/pages/main_kurye_page.dart';
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

        AutoRoute(page: CreateAccountRoute.page),
        AutoRoute(page: JobRoute.page),
        AutoRoute(page: DescriptionRoute.page),

        //Intro

        //Home
        AutoRoute(page: MainKuryeRoute.page, children: [
          AutoRoute(page: ForYouRoute.page),
          AutoRoute(page: OtherRoute.page, initial: true),
          AutoRoute(page: KuryeHomeRoute.page),
        ]),

        AutoRoute(page: JobMainRoute.page, children: [
          AutoRoute(page: OtherRoute.page, initial: true),
          AutoRoute(page: JobManageRoute.page),
          AutoRoute(page: ForYouRoute.page),
        ]),
      ];
}
