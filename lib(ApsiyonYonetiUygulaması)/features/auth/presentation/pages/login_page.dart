import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common/loading_overlay.dart';
import '../../../../constants/colors.dart';
import '../../../../custom/custom_dialog.dart';
import '../../../../custom/custom_filled_button.dart';
import '../../../../custom/custom_text_field.dart';
import '../../../../custom/password_text_field.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../router/router.dart';
import '../providers/login_provider.dart';

final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
//statefull widget
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loginProvider.select((value) => value.isLoading),
        (previous, next) {
      if (next) {
        LoadingScreen().show(context: context);
      } else {
        LoadingScreen().hide(context: context);
      }
    });
    ref.watch(loginProvider);
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
            child: Stack(
              children: [
                Column(
                  children: [
                    Align(child: Assets.images.indir.image(height: 50.h)),
                    SizedBox(height: 50.h),
                    Text(
                      "Giriş Yap",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Tekrar hoşgeldiniz!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: darkGray,
                          ),
                    ),
                    SizedBox(height: 50.h),
                    _MailInput(),
                    SizedBox(height: 20.h),
                    _PasswordInput(),
                    SizedBox(height: 20.h),
                    _ConfirmButton(),
                    SizedBox(height: 20.h),
                    _ForgotPasswordButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MailInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    return CustomTextField(
      hintText: "E-posta",
      onChanged: (value) =>
          ref.read(loginProvider.notifier).onChangedEmail(value),
      onEditingComplete: () => ref.read(loginProvider.notifier).onChangedEmail,
      onFieldSubmitted: (value) =>
          ref.read(loginProvider.notifier).onChangedEmail,
      onSaved: (value) =>
          ref.read(loginProvider.notifier).onChangedEmail(value),
      validator: (value) => state.emailFailure.toNullable()?.message,
    );
  }
}

class _PasswordInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loginProvider);
    return PasswordTextField(
      hintText: "Şifre",
      onChanged: (value) =>
          ref.read(loginProvider.notifier).onChangedPassword(value),
      onEditingComplete: () =>
          ref.read(loginProvider.notifier).onChangedPassword,
      onFieldSubmitted: (value) =>
          ref.read(loginProvider.notifier).onChangedPassword,
      onSaved: (value) =>
          ref.read(loginProvider.notifier).onChangedPassword(value),
      validator: (value) =>
          ref.read(loginProvider).passwordFailure.toNullable()?.message,
    );
  }
}

class _ConfirmButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(loginProvider.notifier);
    return CustomFilledButton(
      buttonText: "Giriş Yap",
      onPressed: () async {
        if (ref.read(_keyProvider).currentState!.validate()) {
          await notifier.login();

          ref.read(loginProvider).failure.fold(
                () => context.router.replaceAll([HomeRoute()]),
                (a) => CustomDialog.failure(
                  title: "Hata",
                  subtitle: a.message,
                ).show(context),
              );
        }
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        "Şifremi Unuttum",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: apsiyonPrimaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _RegisterRouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Column(
        children: [
          Text("Hesabınız yok mu?"),
          SizedBox(height: 20.h),
          CustomFilledButton(
            onPressed: () {
              context.router.replaceAll([RegisterRoute()]);
            },
            child: Text(
              "Üye Ol",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: apsiyonPrimaryColor),
            ),
            color: Colors.transparent,
            borderColor: apsiyonPrimaryColor,
          ),
        ],
      ),
    );
  }
}
