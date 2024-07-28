import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../router/router.dart';
import '../providers/kuryepage_provider.dart';

@RoutePage()
class MainKuryePage extends ConsumerWidget {
  const MainKuryePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        OtherRoute(),
        ForYouRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          floatingActionButton: _ActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
          body: child,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            safeAreaValues: const SafeAreaValues(top: false, bottom: false),
            elevation: 0,
            iconSize: 32.r,
            icons: const [
              Icons.home,
              Icons.person,
            ],
            activeIndex: tabsRouter.activeIndex,
            onTap: (index) async {
              tabsRouter.setActiveIndex(index);
            },
            gapLocation: GapLocation.center,
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

class _ActionButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(kuryePageProvider.notifier);
    final state = ref.watch(kuryePageProvider);
    return SizedBox(
      height: 70.h,
      width: 75.w,
      child: FloatingActionButton(
        backgroundColor: apsiyonPrimaryColor,
        onPressed: () {},
        child: state.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Icon(Icons.code),
      ),
    );
  }
}
