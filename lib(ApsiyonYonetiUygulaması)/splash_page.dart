// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'bootstrap.dart';
import 'constants/colors.dart';
import 'core/injections/locator.dart';
import 'gen/assets.gen.dart';
import 'router/router.dart';

final _isSignInProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(userServiceProvider).isSignIn(),
);

final _isStatusProvider = FutureProvider.autoDispose(
  (ref) => ref.watch(userServiceProvider).isApartmentStatus(),
);

@RoutePage()
class SplashPage extends StatefulHookConsumerWidget {
  final String? resetToken;
  final String? userId;

  const SplashPage({this.resetToken, this.userId});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        FlutterNativeSplash.remove();

        Future.delayed(const Duration(seconds: 1), () async {
          if (await ref.watch(_isSignInProvider.future)) {
            if (context.mounted) {
              if (await ref.watch(_isStatusProvider.future)) {
                return context.replaceRoute(const MainRoute());
              } else {
                return context.replaceRoute(const LoginRoute());
              }
            }
          } else {
            if (context.mounted) {
              return context.replaceRoute(const LoginRoute());
            }
          }
        });

        return null;
      },
      [],
    );
    return Material(
      color: white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // isTablet.fold(
          //   () => Assets.images.splashBgPhone.image(fit: BoxFit.fill),
          //   (t) => Assets.images.splashBgTablet.image(fit: BoxFit.fill),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 240.r,
                child: Assets.images.tododysTLogo.image(fit: BoxFit.fill),
              ),
            ],
          ),
          Positioned(
            bottom: 36.h,
            right: 0,
            left: 0,
            child: const _TododysLogoAndVersionInfo(),
          ),
        ],
      ),
    );
  }
}

class _TododysLogoAndVersionInfo extends StatelessWidget {
  const _TododysLogoAndVersionInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Text(
          'V.$appVersion',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14.sp,
              ),
        ),
      ],
    );
  }
}
