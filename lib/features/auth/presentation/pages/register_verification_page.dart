import 'package:apsiyon/core/extensions/context_extensions.dart';
import 'package:apsiyon/custom/custom_dialog.dart';
import 'package:apsiyon/features/auth/presentation/providers/register_provider.dart';
import 'package:apsiyon/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';

import '../../../../custom/custom_dialog.dart';
import '../../../../custom/custom_filled_button.dart';
import '../../../../custom/custom_text_field.dart';
import '../../../../gen/assets.gen.dart';

final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class RegisterVerificationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    return Scaffold(
      backgroundColor: bgColor,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 35.w,
            right: 35.w,
            top: 100.h,
            bottom: 40.h,
          ),
          child: Form(
            key: ref.watch(_keyProvider),
            child: SizedBox(
              height: context.screenHeight,
              width: context.screenWidth,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Align(child: Assets.images.indir.image(height: 50.h)),
                      SizedBox(height: 50.h),
                      Text(
                        "Doğrulama ",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Text(
                            "${ref.read(registerProvider).countryCode} ${ref.read(registerProvider).phoneNumber} telefon numarasına gönderilen doğrulama kodunu girin.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: gray,
                                )),
                      ),
                      SizedBox(height: 50.h),
                      _VerificationCode(),
                      SizedBox(height: 20.h),
                      _NextButton(),
                      SizedBox(height: 50.h),
                      _GoBackButton(),
                      Text(state.failure.fold(
                          () => "a",
                          (a) => a is FirebaseAuthException
                              ? a.message!
                              : a.message)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VerificationCode extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return CustomTextField(
      textAlign: TextAlign.center,
      textInputType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      validator: (value) =>
          ref.read(registerProvider).pinputFailure.toNullable()?.message,
      onChanged: notifier.onChangedPinput,
      onFieldSubmitted: notifier.onChangedPinput,
      onSaved: (value) => notifier.onChangedPinput,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            letterSpacing: 10.sp,
          ),
    );
  }
}

class _NextButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    final state = ref.read(registerProvider);
    return CustomFilledButton(
      onPressed: () async {
        if (ref.read(_keyProvider).currentState!.validate()) {
          await notifier.register();

          state.failure.fold(
              () => context.pushRoute(CreateAccountRoute()),
              (a) => CustomDialog.failure(
                    title: "Hata",
                    subtitle: a.message,
                  ).show(context));
        }
      },
      buttonText: "Devam Et",
    );
  }
}

class _GoBackButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          "Kod ulaşmadı mı?",
          style: TextStyle(fontSize: 18.sp),
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          child: Text(
            "Tekrar Gönder",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: apsiyonPrimaryColor,
                ),
          ),
          onTap: () {
            ref.read(registerProvider.notifier).verifyPhoneNumber();
          },
        ),
        GestureDetector(
          child: Text(
            "Geri Dön",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: apsiyonPrimaryColor),
          ),
          onTap: () {
            context.replaceRoute(RegisterRoute());
          },
        )
      ],
    );
  }
}
