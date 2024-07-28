import 'dart:io';

import 'package:apsiyon3/constants/colors.dart';
import 'package:apsiyon3/custom/custom_filled_button.dart';
import 'package:apsiyon3/custom/custom_text_field.dart';
import 'package:apsiyon3/gen/assets.gen.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/loading_overlay.dart';
import '../../../../custom/custom_dialog.dart';
import '../../../../router/router.dart';
import '../providers/register_provider.dart';

//global form key
final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class DescriptionPage extends ConsumerWidget {
  const DescriptionPage({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Description'),
      ),
      body: Center(
        child: Form(
          key: ref.watch(_keyProvider),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 40.h,
            ),
            child: Column(
              children: [
                Assets.images.indir.image(height: 40.h),
                Text(
                  "3.Şahıs ",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: apsiyonPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 40.h),
                Text(
                    "Kaydınızın çok daha hızlı onaylanabilmesi adına lütfen aşağıdaki bilgileri doldurunuz.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        )),
                SizedBox(height: 30.h),
                _Description(),
                SizedBox(height: 20.h),
                _SocialMedia(),
                SizedBox(height: 20.h),
                _PickImage(),
                SizedBox(height: 20.h),
                _ConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Description extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Açıklama',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: apsiyonPrimaryColor)),
        SizedBox(height: 10.h),
        CustomTextField(
          validator: (value) => value!.isEmpty
              ? 'Açıklama boş olamaz'
              : value.length < 50
                  ? 'Açıklama en az 50 karakter olmalı'
                  : null,
          maxLines: 5,
          hintText: 'Açıklama',
          onChanged: (value) => notifier.onChangedDescription(value),
        ),
      ],
    );
  }
}

class _SocialMedia extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sosyal Medya',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: apsiyonPrimaryColor)),
        SizedBox(height: 10.h),
        CustomTextField(
          validator: (value) =>
              value!.isEmpty ? 'Sosyal medya boş olamaz' : null,
          hintText: 'Sosyal Medya',
          onChanged: (value) => notifier.onChangedSocialMedia(value),
        ),
      ],
    );
  }
}

class _PickImage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    final notifierState = ref.watch(registerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Resim Seç',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: apsiyonPrimaryColor)),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () async {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.camera, color: apsiyonPrimaryColor),
                        title: Text('Camera'),
                        onTap: () async {
                          File? _image;
                          final picker = ImagePicker();
                          picker
                              .pickImage(source: ImageSource.camera)
                              .then((value) {
                            if (value != null) {
                              _image = File(value.path);
                              print('Image path: ${_image!.path}');
                              ref
                                  .read(registerProvider.notifier)
                                  .onChangedImagePath(
                                    _image!.path,
                                  );
                            }
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.photo_library,
                            color: apsiyonPrimaryColor),
                        title: Text('Gallery'),
                        onTap: () {
                          File? _image;
                          final picker = ImagePicker();
                          picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) {
                            if (value != null) {
                              _image = File(value.path);
                              print('Image path: ${_image!.path}');
                              ref
                                  .read(registerProvider.notifier)
                                  .onChangedImagePath(
                                    _image!.path,
                                  );
                            }
                          });

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ).then((value) {
              if (value != null) {
                print('Image path: $value');
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: apsiyonPrimaryColor),
              borderRadius: BorderRadius.circular(10.r),
            ),
            width: double.infinity,
            height: 150.h,
            child: notifierState.imagePath == ''
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 5.w),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            textAlign: TextAlign.center,
                            'İşinize dair belgelerinizi ekleyebilirsiniz.',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: gray,
                                )),
                      ),
                      Icon(Icons.add_a_photo, color: gray),
                    ],
                  )
                : Image.file(
                    File(notifierState.imagePath),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ],
    );
  }
}

class _ConfirmButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    ref.watch(_keyProvider);
    return CustomFilledButton(
      buttonText: "Kayıt Oluştur",
      onPressed: () async {
        if (ref.read(_keyProvider).currentState!.validate()) {
          print("object");
          await notifier.setDesc();
          ref.read(registerProvider).failure.fold(
                () => context.router.replaceAll([const LoginRoute()]),
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
