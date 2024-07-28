import 'dart:async';

import 'package:apsiyon/custom/custom_dialog.dart';
import 'package:apsiyon/custom/custom_text_field.dart';
import 'package:apsiyon/features/other/domain/models/token.dart';
import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../gen/assets.gen.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/other_provider.dart';

//global key for form
final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class OtherPage extends ConsumerStatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends ConsumerState<OtherPage> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      ref.read(otherProvider.notifier).updateTokenList();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(otherProvider);

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 100.h),
        child: SizedBox(
          height: 70.h,
          width: 70.h,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SelectionDialog();
                },
              );
            },
            child: const Icon(Icons.code),
            backgroundColor: apsiyonPrimaryColor,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Aktif Tokenler",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.tokenListConfirmed.isEmpty)
                const _EmptylistPart(text: "Aktif token bulunmamaktadır")
              else
                _ConfirmedTokenPart(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Onaylanmamış Tokenler",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.tokenListUnconfirmed.isEmpty)
                const _EmptylistPart(
                  text: "Onay bekleyen token bulunmamaktadır",
                )
              else
                _UnconfirmedTokenPart(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Geçmiş Tokenler",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.tokenListExpired.isEmpty)
                const _EmptylistPart(text: "Geçmiş token bulunmamaktadır")
              else
                _PastConfirmedTokenPart(),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptylistPart extends StatelessWidget {
  final String text;

  const _EmptylistPart({required this.text});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 170.h,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: white,
            boxShadow: const [
              BoxShadow(
                color: dropdownShadowColor,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Assets.images.kurye.image(
            height: 170.h,
          ),
        ),
        //blur effect
        Container(
          height: 170.h,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: gray.withOpacity(0.3),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          color: white.withOpacity(0.8),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: apsiyonPrimaryColor,
                ),
          ),
        ),
      ],
    );
  }
}

class _TimeChip extends ConsumerWidget {
  final String value;

  const _TimeChip({required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    return GestureDetector(
      onTap: () => ref.read(otherProvider.notifier).setTokenTime(value),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: state.tokenTime == value ? apsiyonPrimaryColor : white,
        ),
        child: Text(
          "$value",
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: state.tokenTime == value ? white : apsiyonPrimaryColor,
              ),
        ),
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
    final state = ref.watch(otherProvider);
    final keyProvider = ref.watch(_keyProvider);
    final notifier = ref.read(otherProvider.notifier);
    return Form(
      key: keyProvider,
      child: AlertDialog(
        title: Text(
          "Token Oluştur".toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: apsiyonPrimaryColor,
              ),
        ),
        content: state.isLoading
            ? const CircularProgressIndicator.adaptive()
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomTextField(
                      validator: (value) => value!.isEmpty
                          ? "Token açıklaması boş bırakılamaz"
                          : null,
                      onChanged: (value) {
                        ref
                            .read(otherProvider.notifier)
                            .onChangedTokenDescription(
                              value,
                            );
                      },
                      hintText: "Token açıklaması",
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text("Tokenin atandığı kişi(opsiyonel)"),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: lightGray),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text("Tokenin atandığı kişi"),
                        value: state.tokenOtherId,
                        items: <String>["Belirsiz", "Ahmet", "Mehmet", "Ali"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          ref
                              .read(otherProvider.notifier)
                              .setTokenOtherId(value!);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text("Toplantı Süresi"),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      const _TimeChip(value: "15 Dk"),
                      SizedBox(width: 5.w),
                      const _TimeChip(value: "30 Dk"),
                      SizedBox(width: 5.w),
                      const _TimeChip(value: "1 Saat"),
                      SizedBox(width: 5.w),
                      const _TimeChip(value: "8 Saat"),
                    ],
                  ),
                ],
              ),
        actions: state.isLoading
            ? []
            : [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("İptal"),
                ),
                TextButton(
                  onPressed: () async {
                    if (keyProvider.currentState!.validate()) {
                      await notifier.setToken();

                      ref.read(otherProvider).failure.fold(
                        () {
                          Future.delayed(const Duration(seconds: 2), () {
                            //scaffol ile bilgilendirme yapılabilir
                            //contexti kontrol et
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              Future.delayed(const Duration(seconds: 2), () {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              });
                            }
                          });
                          const CustomDialog.success(
                            title: "Başarılı",
                            subtitle: "Token başarıyla oluşturuldu",
                          ).show(context);
                        },
                        (a) => CustomDialog.failure(
                          title: "Hata",
                          subtitle: a.message,
                        ).show(context),
                      );
                    }
                  },
                  child: const Text("Oluştur"),
                ),
              ],
      ),
    );
  }
}

class _ActiveTokenPart extends ConsumerWidget {
  final Token token;

  const _ActiveTokenPart({required this.token});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    return Container(
      width: 389.w,
      height: 100.h,
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.only(right: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: white,
        boxShadow: const [
          BoxShadow(
            color: dropdownShadowColor,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                token.tokenDescription,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: apsiyonPrimaryColor,
                    ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person_outlined,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    token.tokenOtherName == ''
                        ? "Belirsiz"
                        : token.tokenOtherName,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: gray,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time_filled,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _timeStampToString(token.createdAt),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: gray,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_alarms_sharp,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    _timeStampToString(token.expirationDate),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: gray,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Text(
                              token.tokenId,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: token.tokenId),
                                );
                              },
                              child: Icon(
                                size: 20.r,
                                Icons.copy,
                                color: gray,
                              ),
                            ),
                          ],
                        ),
                        content: SizedBox(
                          width: 200.w,
                          height: 200.h,
                          child: Align(
                            child: QrImageView(
                              data: token.tokenId,
                              size: 150.r,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: QrImageView(
                  data: token.tokenId,
                  size: 100.0,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Text(
                    token.tokenId,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: token.tokenId));
                    },
                    child: Icon(
                      size: 16.r,
                      Icons.copy,
                      color: gray,
                    ),
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

class _TokenPart extends ConsumerWidget {
  final Token token;
  final bool isPast;
  const _TokenPart({required this.token, required this.isPast});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    return Container(
      width: 200.w,
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.only(right: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: white,
        boxShadow: const [
          BoxShadow(
            color: dropdownShadowColor,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            token.tokenDescription,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: apsiyonPrimaryColor,
                ),
          ),
          Row(
            children: [
              const Icon(
                Icons.person_outlined,
                color: apsiyonPrimaryColor,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                token.tokenOtherName == '' ? "Belirsiz" : token.tokenOtherName,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: gray,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              const Icon(
                Icons.access_time_filled,
                color: apsiyonPrimaryColor,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                _timeStampToString(token.createdAt),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: gray,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              const Icon(
                Icons.access_alarms_sharp,
                color: apsiyonPrimaryColor,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                _timeStampToString(token.expirationDate),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: gray,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          if (!isPast)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ref
                        .read(otherProvider.notifier)
                        .setStatus("confirmed", token.tokenId);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: apsiyonPrimaryColor,
                    ),
                    child: Text(
                      "Onayla",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: white,
                          ),
                    ),
                  ),
                ),
              ],
            )
          else
            Text(
              "Zamanı geçmiş token",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: red,
                  ),
            ),
        ],
      ),
    );
  }
}

class _ConfirmedTokenPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.tokenListConfirmed.length,
        itemBuilder: (context, index) {
          return _ActiveTokenPart(
            token: state.tokenListConfirmed[index],
          );
        },
      ),
    );
  }
}

class _UnconfirmedTokenPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.tokenListUnconfirmed.length,
        itemBuilder: (context, index) {
          return _TokenPart(
            token: state.tokenListUnconfirmed[index],
            isPast: false,
          );
        },
      ),
    );
  }
}

class _PastConfirmedTokenPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    return SizedBox(
      height: 190.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.tokenListExpired.length,
        itemBuilder: (context, index) {
          return _TokenPart(
            token: state.tokenListExpired[index],
            isPast: true,
          );
        },
      ),
    );
  }
}

String _timeStampToString(Timestamp timestamp) {
  final date = timestamp.toDate();

  //yazıyla türkçe gün ve ay isimlerini yazdırmak için

  return "${date.day} ${monthNames[date.month]} - ${date.hour}:${date.minute}";
}

const List<String> monthNames = [
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
  "Aralık",
];
