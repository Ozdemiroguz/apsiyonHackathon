import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/colors.dart';
import '../../../../router/router.dart';

@RoutePage()
class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        MeetingHomeRoute(),
        OtherRoute(),
        AccountInfoRoute(),
        AccountInfoRoute(),
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
            icons: [
              Icons.home_rounded,
              Icons.receipt,
              Icons.add_box_outlined,
              Icons.card_giftcard,
              Icons.menu,
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
