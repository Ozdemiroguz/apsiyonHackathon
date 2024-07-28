import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../constants/colors.dart';
import '../../../../../router/router.dart';

@RoutePage()
class JobMainPage extends ConsumerWidget {
  const JobMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        OtherRoute(),
        JobManageRoute(),
        ForYouRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          extendBody: true,
          body: child,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            safeAreaValues: const SafeAreaValues(top: false, bottom: false),
            elevation: 0,
            iconSize: 32.r,
            icons: const [
              Icons.home,
              Icons.work,
              Icons.person,
            ],
            activeIndex: tabsRouter.activeIndex,
            onTap: (index) async {
              tabsRouter.setActiveIndex(index);
            },
            gapLocation: GapLocation.none,
            blurEffect: true,
            backgroundColor: Colors.white,
            activeColor: apsiyonPrimaryColor,
            inactiveColor: gray,
          ),
        );
      },
    );
  }
}
