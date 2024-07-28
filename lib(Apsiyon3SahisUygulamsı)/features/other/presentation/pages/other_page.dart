import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../custom/custom_dialog.dart';
import '../../../../custom/custom_text_field.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../services/kurye_service/kurye_provider.dart';
import '../../domain/models/token.dart';
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
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
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
      appBar: _TopPart(),
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
              Text("Aktif Tokenler",
                  style: Theme.of(context).textTheme.displayMedium),
              SizedBox(
                height: 10.h,
              ),
              state.tokenListConfirmed.isEmpty
                  ? _EmptylistPart(text: "Aktif token bulunmamaktadır")
                  : _ConfirmedTokenPart(),
              SizedBox(
                height: 10.h,
              ),
              Text("Onaylanmamış Tokenler",
                  style: Theme.of(context).textTheme.displayMedium),
              SizedBox(
                height: 10.h,
              ),
              state.tokenListUnconfirmed.isEmpty
                  ? _EmptylistPart(text: "Onay bekleyen token bulunmamaktadır")
                  : _UnconfirmedTokenPart(),
              SizedBox(
                height: 10.h,
              ),
              Text("Geçmiş Tokenler",
                  style: Theme.of(context).textTheme.displayMedium),
              SizedBox(
                height: 10.h,
              ),
              state.tokenListExpired.isEmpty
                  ? _EmptylistPart(text: "Geçmiş token bulunmamaktadır")
                  : _PastConfirmedTokenPart(),
              SizedBox(
                height: 100.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TopPart extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(kuryeProvider);
    return SizedBox(
      height: 150.h,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
            width: double.infinity,
            height: 150.h,
            color: apsiyonPrimaryColor,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.circle,
                    border: Border.all(color: apsiyonSecondaryColor, width: 2),
                  ),
                  child: Text(
                    user.name.isEmpty
                        ? ""
                        : "${user.name[0]}${user.surname[0]}",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${user.name} ${user.surname}",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700, color: white),
                        ),
                        SizedBox(width: 10.w),
                        Text("(${user.job})",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: white)),
                      ],
                    ),
                    Text(
                      "+90 ${user.phoneNumber}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: white),
                    )
                  ],
                ),
                const Spacer(),
                Icon(Icons.notifications_none_outlined,
                    color: white, size: 30.r),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(150.h);
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
        child: Text("$value",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: state.tokenTime == value ? white : apsiyonPrimaryColor,
                )),
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
      width: 423.w,
      height: 100.h,
      padding: EdgeInsets.all(10.r),
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
              Text(token.tokenDescription,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: apsiyonPrimaryColor,
                      )),
              Row(
                children: [
                  Icon(
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
                          )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(_timeStampToString(token.createdAt),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: gray,
                          )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_alarms_sharp,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(_timeStampToString(token.expirationDate),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: gray,
                          )),
                ],
              )
            ],
          ),
          Spacer(),
          SizedBox(
            width: 200.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Text(token.tokenId,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(
                                        ClipboardData(text: token.tokenId));
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
                                  version: QrVersions.auto,
                                  size: 150.r,
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: QrImageView(
                    data: token.tokenId,
                    version: QrVersions.auto,
                    size: 130.0,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          )
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
          Text(token.tokenDescription,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: apsiyonPrimaryColor,
                  )),
          Row(
            children: [
              Icon(
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
                      )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_filled,
                color: apsiyonPrimaryColor,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(_timeStampToString(token.createdAt),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: gray,
                      )),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Icon(
                Icons.access_alarms_sharp,
                color: apsiyonPrimaryColor,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(_timeStampToString(token.expirationDate),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: gray,
                      )),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          if (isPast)
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(otherProvider.notifier).requestToken(
                          token: token,
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: apsiyonPrimaryColor,
                    ),
                    child: Text("Token Talep Et",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: white,
                            )),
                  ),
                )
              ],
            )
          else
            Text("Onay bekleniyor",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: darkBlue,
                    )),
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
          }),
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
                token: state.tokenListUnconfirmed[index], isPast: false);
          }),
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
          }),
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
  "Aralık"
];
