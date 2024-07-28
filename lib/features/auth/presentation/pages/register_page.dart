import 'package:apsiyon/core/extensions/context_extensions.dart';
import 'package:apsiyon/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../custom/custom_dialog.dart';
import '../../../../custom/custom_filled_button.dart';
import '../../../../custom/custom_text_field.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../utils/text_input_formatters.dart';
import '../providers/register_provider.dart';

final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class RegisterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(registerProvider);
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
                        "Üye Ol",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Hesap oluşturmak için lütfen cep telefonu numaranızı giriniz.",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: gray,
                                  ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      _PhoneInput(),
                      SizedBox(height: 20.h),
                      _Agrements(),
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.h),
                      _ConfirmButton(),
                      SizedBox(height: 200.h),
                    ],
                  ),
                  Positioned(bottom: 150.h, child: _LoginRouteButton()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Row(
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
            ),
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
    );
  }
}

class _Agrements extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    final notifier = ref.read(registerProvider.notifier);

    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: white,
              activeColor: apsiyonPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              value: state.agrrement[0],
              onChanged: (value) {
                notifier.onChangedCheckList(0);
              },
            ),
            Text(
              "Üyelik Sözleşmesini okudum, kabul ediyorum.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: apsiyonPrimaryColor,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            Checkbox(
              checkColor: white,
              activeColor: apsiyonPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              value: state.agrrement[1],
              onChanged: (value) {
                notifier.onChangedCheckList(1);
              },
            ),
            Text(
              "KVKK aydınlatma metnini okudum.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: apsiyonPrimaryColor,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ConfirmButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    final notfier = ref.read(registerProvider.notifier);
    return state.isLoading
        ? const CircularProgressIndicator()
        : CustomFilledButton(
            disabled: !ref.read(registerProvider).isAgreement,
            buttonText: "Devam Et",
            onPressed: () async {
              final formState = ref.read(_keyProvider).currentState;
              formState?.validate();

              if (formState != null && formState.validate()) {
                await notfier.verifyPhoneNumber();

                ref.read(registerProvider).failure.fold(
                      () =>
                          context.pushRoute(const RegisterVerificationRoute()),
                      (l) => CustomDialog.failure(
                        title: "Hata",
                        subtitle: l.message,
                      ).show(context),
                    );
              }
            },
          );
  }
}

class _LoginRouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Hesabınız var mı"),
        SizedBox(height: 20.h),
        SizedBox(
          height: 50.h,
          width: context.screenWidth - 70.w,
          child: CustomFilledButton(
            onPressed: () {},
            child: Text(
              "Giriş Yap",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: apsiyonPrimaryColor),
            ),
            color: Colors.transparent,
            borderColor: apsiyonPrimaryColor,
          ),
        ),
      ],
    );
  }
}
