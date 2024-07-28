import 'package:apsiyon3/core/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../../utils/text_input_formatters.dart';
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

    ref.watch(registerProvider);
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(left: 37.w, right: 37.w, top: 70.h, bottom: 40.h),
        child: Form(
          key: ref.watch(_keyProvider),
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Align(child: Assets.images.indir.image(height: 40.h)),
                    Text("3.Şahıs ",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: apsiyonPrimaryColor,
                                fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  "Hesap Oluştur",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 30.h),
                _NameInput(),
                SizedBox(height: 15.h),
                _Surname(),
                SizedBox(height: 15.h),
                _EmailInput(),
                SizedBox(height: 15.h),
                _PhoneInput(),
                SizedBox(height: 15.h),
                _Password(),
                SizedBox(height: 15.h),
                _CheckPassword(),
                SizedBox(height: 20.h),
                ConfirmButton(),
                SizedBox(height: 20.h),
                _LoginRouteButton(),
                SizedBox(height: 200.h),
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

class _PhoneInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            "Telefon Numarası",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: apsiyonPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.r),
                    ),
                    border: Border.all(color: lightGray, width: 1.w)),
                child: CountryCodePicker(
                  hideSearch: true,
                  countryFilter: const [
                    'TR',
                    'US',
                    'GB',
                    'DE',
                    'FR',
                    'ES',
                    'IT',
                    'RU',
                    'Hu',
                  ],
                  onChanged: (CountryCode? countryCode) =>
                      notifier.onChangedCountryCode(countryCode!.dialCode),
                  initialSelection: 'TR',
                  favorite: const ['+90', 'TR'],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: CustomTextField(
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  PhoneNumberFormatter(),
                ],
                validator: (value) => ref
                    .read(registerProvider)
                    .phoneNumberFailure
                    .toNullable()
                    ?.message,
                onChanged: notifier.onChangedPhoneNumber,
                onFieldSubmitted: notifier.onChangedPhoneNumber,
                onSaved: notifier.onChangedPhoneNumber,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: gray,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                hintText: 'Phone Number',
              ),
            ),
          ],
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
          await notifier.register();

          ref.read(registerProvider).failure.fold(
            () {
              Future.delayed(const Duration(seconds: 1), () {
                //scaffol ile bilgilendirme yapılabilir
                //contexti kontrol et
                context.router.replace(const JobRoute());
              });
              CustomDialog.success(
                title: "Başarılı",
                subtitle:
                    "Hesabınız başarıyla oluşturuldu Yönlendiriliyorsunuz...",
              ).show(context);
            },
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

class _LoginRouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Hesabınız var mı"),
        SizedBox(width: 5.h),
        GestureDetector(
          onTap: () {
            context.router.replace(const LoginRoute());
          },
          child: Text(
            textAlign: TextAlign.center,
            "Giriş Yap",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: apsiyonPrimaryColor),
          ),
        ),
      ],
    );
  }
}
