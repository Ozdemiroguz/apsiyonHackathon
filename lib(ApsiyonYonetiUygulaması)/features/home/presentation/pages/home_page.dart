import 'dart:io';

import 'package:apsiyonY/custom/custom_text_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/colors.dart';
import '../../../../custom/custom_dialog.dart';
import '../../../../custom/custom_filled_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../services/user_service/user_service_provider.dart';
import '../../domain/models/post.dart';
import '../providers/home_provider.dart';

final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final user = ref.watch(userService);
    return Scaffold(
      floatingActionButton: Container(
        width: 65.w,
        height: 160.h,
        padding: EdgeInsets.only(bottom: 100.h),
        child: FloatingActionButton(
          backgroundColor: white,
          onPressed: () async {
            await ref.read(homeProvider.notifier).setInitial();
            showDialog(
              context: context,
              builder: (context) {
                return SelectionDialog();
              },
            );
          },
          child: const Icon(Icons.add, color: apsiyonPrimaryColor),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      appBar: _TopPart(),
      body: Center(
        child: RefreshIndicator.adaptive(
          color: apsiyonPrimaryColor,
          onRefresh: () async {
            await ref.read(homeProvider.notifier).getHomeData();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(FirebaseAuth.instance.currentUser!.uid),
                SizedBox(height: 10.h),
                _PrivilegesAndBilborde(),
                SizedBox(height: 10.h),
                _Timeline(),
                SizedBox(height: 1000.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopPart extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userService);
    return SizedBox(
      height: 210.h,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
              width: double.infinity,
              height: 170.h,
              color: apsiyonPrimaryColor,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      color: white,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: apsiyonSecondaryColor, width: 2),
                    ),
                    child: Text(
                      user.userData.name.isEmpty
                          ? ""
                          : "${user.userData.name[0]}${user.userData.surname[0]}",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.userData.name} ${user.userData.surname}",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: white,
                                ),
                      ),
                      if (user.apsiyonPoint != null)
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "${user.apsiyonPoint!.apartment_name} ${user.userData.apartment_number}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications_none_outlined,
                    color: white,
                    size: 30.r,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 130.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.konfeti.image(width: 50.w, height: 50.h),
                    SizedBox(width: 10.w),
                    Text(
                      textAlign: TextAlign.center,
                      "Borcunuz bulunmamaktadır.",
                      style: Theme.of(context).textTheme.displayMedium!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(210.h);
}

class _PrivilegesAndBilborde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.w),
              height: 250.h,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ayrıcalıklar",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: SizedBox(
                        height: 100.h,
                        child: Assets.images.albaraka.image(),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Albaraka Türk",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: apsiyonPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Albaraka Türk ile yapacağınız alışverişlerde %10 indirim fırsatı!",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  //indicator
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        width: 7.w,
                        height: 7.h,
                        margin: EdgeInsets.only(right: 5.w),
                        decoration: BoxDecoration(
                          color: index == 0 ? apsiyonPrimaryColor : gray,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              height: 250.h,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "İlan Panosu",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(height: 20.h),
                  const Spacer(),
                  Align(
                    child: Text(
                      textAlign: TextAlign.center,
                      "İlanlarınızı buradan ekleyebilirsiniz.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    child: SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: CustomFilledButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: white, size: 20.r),
                            Text(
                              "İlan Ekle",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: white),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Timeline extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    return ListView.separated(
      itemCount: state.postList.length,
      shrinkWrap: true, // Bu satırı ekleyin
      physics: const NeverScrollableScrollPhysics(), // Bu satırı ekleyin
      itemBuilder: (context, index) {
        return _PostPart(post: state.postList[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10.h);
      },
    );
  }
}

class _PostPart extends ConsumerWidget {
  final Post post;

  const _PostPart({required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // user Info
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: const BoxDecoration(
                  color: apsiyonPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  post.username[0],
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: white),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.username,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (post.type != "announcement" && post.type != "privilege")
                    Row(
                      children: [
                        //uyarı butonu
                        Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Uyar",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: white),
                              ),
                              Icon(
                                Icons.warning,
                                color: white,
                                size: 15.r,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),

                        GestureDetector(
                          onTap: () async {
                            await ref
                                .read(homeProvider.notifier)
                                .deletePost(post.postId);

                            ref.read(homeProvider).failure.fold(
                              () {
                                const CustomDialog.success(
                                  title: "Başarılı",
                                  subtitle:
                                      "Gönderi başarılı bir şekilde silindi.",
                                ).show(context);
                              },
                              (r) {
                                const CustomDialog.failure(
                                  title: "Hata",
                                  subtitle:
                                      "Gönderi silinirken bir hata oluştu.",
                                ).show(context);
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Sil",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: white),
                                ),
                                Icon(
                                  Icons.delete,
                                  color: white,
                                  size: 15.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),

                        Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color: post.type == "Site Sakini Gönderisi"
                                ? apsiyonPrimaryColor
                                : post.type == "İlan"
                                    ? Colors.yellow[700]
                                    : post.type == "Yönetim Duyurusu"
                                        ? red
                                        : post.type == "announcement"
                                            ? Colors.orange
                                            : Colors.blue[700],
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            post.type == "announcement"
                                ? "Duyuru"
                                : post.type == "privilege"
                                    ? "Ayrıcalık"
                                    : post.type == "Site Sakini Gönderisi"
                                        ? "Site Sakini "
                                        : post.type,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: white),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 5.h),
                  Text(
                    _timeStamptoTime(post.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          if (post.image.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                color: apsiyonPrimaryColor,
              ),
              width: double.infinity,
              child: post.image == null
                  ? const Center(
                      child: Text(
                        "Resim yok",
                        style: TextStyle(color: white),
                      ),
                    )
                  : Image.network(
                      post.image!,
                    ),
            ),

          const Divider(
            color: gray,
            thickness: 1,
          ),
          SizedBox(height: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 10.h),
              Text(
                post.content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  const Icon(Icons.favorite_border, color: apsiyonPrimaryColor),
                  SizedBox(width: 10.w),
                  const Icon(Icons.comment, color: apsiyonPrimaryColor),
                  const Spacer(),
                  Text("Beğen", style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(width: 10.w),
                  Text(
                    "Yorum Yap",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectionDialog extends StatefulHookConsumerWidget {
  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends ConsumerState<SelectionDialog> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    return Form(
      key: ref.watch(_keyProvider),
      child: AlertDialog(
        title: const Text('Site/Apartman Seçimi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
              hint: const Text("Gönderi Tipi"),
              value: state.type,
              onChanged: (value) {
                notifier.onChangedType(value!);
              },
              items: ["Site Sakini Gönderisi", "İlan", "Yönetim Duyurusu"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )),
            Visibility(
              visible: state.type != null,
              child: CustomTextField(
                validator: (value) => value!.isEmpty ? "Boş bırakılamaz" : null,
                hintText: "Gönderi Başlığı",
                onChanged: (value) {
                  notifier.onChangedTitle(value);
                },
              ),
            ),
            Visibility(
              visible: state.type != null,
              child: CustomTextField(
                hintText: "Gönderi İçeriği",
                onChanged: (value) {
                  notifier.onChangedContent(value);
                },
              ),
            ),
            Visibility(visible: state.type != null, child: _PickImage())
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200.w,
                    child: Visibility(
                      visible: !state.isCompleted,
                      child: CustomFilledButton(
                        onPressed: () async {
                          if (ref.read(_keyProvider).currentState!.validate() &&
                              !state.isLoading) {
                            print("Gönderi Yapıldı");
                            await notifier.setPost();
                            ref.read(homeProvider).failure.fold(
                              () {
                                notifier.onChangedIsCompleted(true);
                                const CustomDialog.success(
                                  title: "Başarılı",
                                  subtitle:
                                      "Gönderi başarılı bir şekilde yapıldı.",
                                ).show(context);
                              },
                              (r) {
                                const CustomDialog.failure(
                                  title: "Hata",
                                  subtitle:
                                      "Gönderi yapılırken bir hata oluştu.",
                                ).show(context);
                              },
                            );
                          }
                        },
                        child: state.isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text("Gönderi Yap"),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PickImage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeProvider.notifier);
    final notifierState = ref.watch(homeProvider);
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
                        leading: const Icon(Icons.camera,
                            color: apsiyonPrimaryColor),
                        title: const Text('Camera'),
                        onTap: () async {
                          File? _image;
                          final picker = ImagePicker();
                          picker
                              .pickImage(source: ImageSource.camera)
                              .then((value) {
                            if (value != null) {
                              _image = File(value.path);
                              print('Image path: ${_image!.path}');
                              notifier.onChangedImg(_image!.path);
                            }
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library,
                            color: apsiyonPrimaryColor),
                        title: const Text('Gallery'),
                        onTap: () {
                          File? _image;
                          final picker = ImagePicker();
                          picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) {
                            if (value != null) {
                              _image = File(value.path);
                              print('Image path: ${_image!.path}');
                              notifier.onChangedImg(_image!.path);
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
            child: notifierState.img == ''
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 5.w),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            textAlign: TextAlign.center,
                            'Gönderinize resim eklemek için tıklayın.',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: gray,
                                )),
                      ),
                      const Icon(Icons.add_a_photo, color: gray),
                    ],
                  )
                : Image.file(
                    File(notifierState.img),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ],
    );
  }
}

String _timeStamptoTime(Timestamp timestamp) {
  final DateTime date = timestamp.toDate();
  final String formattedDate =
      "${date.day}.${_months[date.month]}. ${date.hour}:${date.minute}";
  return formattedDate;
}

const List<String> _months = [
  "Ocak",
  "Şubat",
  "Mart",
  "Nisan",
  "Mayıs",
  "Haziran",
  "Temmuz",
  "Ağustos",
  "Eylül",
  "Ekim",
  "Kasım",
  "Aralık"
];
