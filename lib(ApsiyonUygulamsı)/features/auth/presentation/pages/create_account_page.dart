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
import '../providers/register_provider.dart';

final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class CreateAccountPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(registerProvider.select((value) => value.isLoading),
        (previous, next) {
      if (next) {
        LoadingScreen().show(context: context);
      } else {
        LoadingScreen().hide(context: context);
      }
    });

    final state = ref.watch(registerProvider);
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(left: 37.w, right: 37.w, top: 100.h, bottom: 40.h),
        child: Form(
          key: ref.watch(_keyProvider),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(child: Assets.images.indir.image(height: 50.h)),
                SizedBox(height: 30.h),
                Text(
                  "Hesap Oluştur",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50.h),
                _NameInput(),
                SizedBox(height: 15.h),
                _Surname(),
                SizedBox(height: 15.h),
                _EmailInput(),
                SizedBox(height: 15.h),
                _Password(),
                SizedBox(height: 15.h),
                _CheckPassword(),
                SizedBox(height: 20.h),
                ConfirmButton(),
                ElevatedButton(
                    onPressed: () {
                      ref.read(registerProvider.notifier).register();
                    },
                    child: Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NameInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            "İsim",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: apsiyonPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        CustomTextField(
          onChanged: notifier.onChangedFirstName,
          onFieldSubmitted: notifier.onChangedFirstName,
          onSaved: (value) => notifier.onChangedFirstName(value!),
          validator: (value) =>
              value!.isEmpty ? "İsim kısmı boş bırakılamaz!!" : null,
          hintText: "İsminiz",
        ),
      ],
    );
  }
}

class _Surname extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            "Soyisim",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: apsiyonPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        CustomTextField(
          hintText: "Soyisminiz",
          onChanged: notifier.onChangedLastName,
          onFieldSubmitted: notifier.onChangedLastName,
          onSaved: (value) => notifier.onChangedLastName(value!),
          validator: (value) =>
              value!.isEmpty ? "Soyisim kısmı boş bırakılamaz!" : null,
        ),
      ],
    );
  }
}

class _EmailInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            "E-Posta",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: apsiyonPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        CustomTextField(
          initialValue: "",
          hintText: "E-posta adresiniz",
          onChanged: notifier.onChangedEmail,
          onFieldSubmitted: notifier.onChangedEmail,
          onSaved: (value) => notifier.onChangedEmail(value!),
          validator: (value) =>
              ref.read(registerProvider).emailFailure.toNullable()?.message,
        ),
      ],
    );
  }
}

class _Password extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            "Şifre",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: apsiyonPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        PasswordTextField(
          hintText: "Şifreniz",
          onChanged: notifier.onChangedPassword,
          onFieldSubmitted: notifier.onChangedPassword,
          onSaved: (value) => notifier.onChangedPassword(value!),
          validator: (value) =>
              ref.read(registerProvider).passwordFailure.toNullable()?.message,
        ),
      ],
    );
  }
}

class _CheckPassword extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            "Şifre Tekrar",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: apsiyonPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        PasswordTextField(
          hintText: "Şifrenizi tekrar giriniz",
          onChanged: notifier.onChangedConfirmPassword,
          onFieldSubmitted: notifier.onChangedConfirmPassword,
          onSaved: (value) => notifier.onChangedConfirmPassword(value!),
          validator: (value) => ref
              .read(registerProvider)
              .confirmPasswordFailure
              .toNullable()
              ?.message,
        ),
      ],
    );
  }
}

class ConfirmButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(registerProvider);
    final notifier = ref.watch(registerProvider.notifier);

    return CustomFilledButton(
      onPressed: () async {
        final formState = ref.read(_keyProvider).currentState;

        formState?.validate();

        if (formState != null && formState.validate()) {
          await notifier.addInformation();

          ref.read(registerProvider).failure.fold(
                () => context.router.replace(const LoginRoute()),
                (t) => CustomDialog.failure(
                  title: 'Hata',
                  subtitle: t.message,
                ).show(context),
              );
        }
      },
      buttonText: "Onayla",
    );
  }
}
