import 'package:apsiyon/core/extensions/context_extensions.dart';
import 'package:apsiyon/custom/custom_dialog.dart';
import 'package:apsiyon/custom/custom_filled_button.dart';
import 'package:apsiyon/custom/custom_text_field.dart';
import 'package:apsiyon/features/other/domain/models/employment.dart';
import 'package:apsiyon/features/other/domain/models/token.dart';
import 'package:apsiyon/features/other/presentation/providers/job_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../providers/other_provider.dart';

//global key for form
final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

class JobPage extends ConsumerStatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  _OtherPageState createState() => _OtherPageState();
}

class _OtherPageState extends ConsumerState<JobPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobProvider);

    return Scaffold(
      floatingActionButton: _ActionButton(),
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
                "Aktif Hizmetler",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.confirmedList.isEmpty)
                const _EmptylistPart(text: "Aktif hizmet bulunmamaktadır")
              else
                _ConfirmedTokenPart(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Teklif Bekleyen İlanlar",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.activeList.isEmpty)
                const _EmptylistPart(
                  text: "Onay bekleyen hizmet bulunmamaktadır",
                )
              else
                _OfferreceivedAndWaitingEmploymentsPart(),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Geçmiş Hizmetler",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.completedList.isEmpty)
                const _EmptylistPart(text: "Tamamlanmş Hizmet bulunmamaktadır")
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

class _ActionButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    return Padding(
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
          backgroundColor: apsiyonPrimaryColor,
          child: const Icon(Icons.add_business_outlined),
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

class SelectionDialog extends StatefulHookConsumerWidget {
  @override
  _SelectionDialogState createState() => _SelectionDialogState();
}

class _SelectionDialogState extends ConsumerState<SelectionDialog> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobProvider);
    final keyProvider = ref.watch(_keyProvider);
    final notifier = ref.read(jobProvider.notifier);
    return Form(
      key: keyProvider,
      child: AlertDialog(
        title: Text(
          "Hizmet Talebi Oluştur".toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: apsiyonPrimaryColor,
              ),
        ),
        content: state.isLoading
            ? const CircularProgressIndicator.adaptive()
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hizmet Başlığı",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomTextField(
                      validator: (value) => value!.isEmpty
                          ? "Hizmet başlığı boş bırakılamaz"
                          : null,
                      onChanged: (value) {
                        notifier.changedJobTitle(value);
                      },
                      hintText: "Hizmet başlığı",
                    ),
                    Text(
                      "Hizmet Açıklaması",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 5.h),
                    CustomTextField(
                      maxLines: 3,
                      validator: (value) => value!.isEmpty
                          ? "Hizmet açıklaması boş bırakılamaz"
                          : null,
                      onChanged: (value) {
                        notifier.changedJobDescription(value);
                      },
                      hintText: "Hizmet açıklaması",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        validator: (value) => value == null
                            ? "Hizmet türü boş bırakılamaz"
                            : null,
                        onChanged: (value) {
                          notifier.changedJob(value!);
                        },
                        items: jobList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          hintText: "Hizmet türü",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Visibility(
                      visible: !state.isCompleted,
                      child: CustomFilledButton(
                        onPressed: () async {
                          if (state.jobDateStart == null ||
                              state.jobDateEnd == null) {
                            notifier.changedDateCompleted(true);
                          } else {
                            notifier.changedDateCompleted(false);
                          }
                          if (keyProvider.currentState!.validate()) {
                            await notifier.setEmployment();

                            ref.read(jobProvider).failure.fold(
                              () {
                                ref
                                    .read(jobProvider.notifier)
                                    .changedIsCompleted(
                                      false,
                                    );
                                CustomDialog.success(
                                  title: "Hizmet Talebi Oluşturuldu",
                                  subtitle:
                                      "Hizmet talebiniz başarıyla oluşturuldu",
                                ).show(context);
                              },
                              (r) {
                                CustomDialog.failure(
                                  title: "Hizmet Talebi Oluşturulamadı",
                                  subtitle: r.toString(),
                                ).show(context);
                              },
                            );
                          }
                        },
                        child: state.isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : Text(
                                "Hizmet Talebi Oluştur",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: white,
                                    ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _Employment extends ConsumerWidget {
  final Employment employment;

  const _Employment({required this.employment});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(otherProvider);
    final notifier = ref.watch(jobProvider.notifier);
    return Container(
      width: context.screenWidth - 40.w,
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employment.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: apsiyonPrimaryColor,
                    ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                employment.description,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: gray,
                    ),
              ),
              SizedBox(
                height: 10.h,
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
                    employment.otherName == null
                        ? "Belirsiz"
                        : employment.otherName!,
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
                    _timeStampToString(employment.startDate),
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
                    Icons.business_center,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    employment.job,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: gray,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              if (employment.status == "confirmed")
                Row(
                  children: [
                    const Icon(
                      Icons.money_sharp,
                      color: apsiyonPrimaryColor,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${employment.price} TL",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: gray,
                          ),
                    ),
                  ],
                ),
            ],
          ),
          if (employment.status == "waiting")
            Positioned(
              right: 10.w,
              bottom: 10.h,
              child: GestureDetector(
                onTap: () {
                  notifier.setEmploymentStatus(
                      employmentID: employment.id, status: "cancelled");

                  ref.read(jobProvider).failure.fold(
                    () {
                      CustomDialog.success(
                        title: "Hizmet İptal Edildi",
                        subtitle: "Hizmet başarıyla iptal edildi",
                      ).show(context);
                    },
                    (r) {
                      CustomDialog.failure(
                        title: "Hizmet İptal Edilemedi",
                        subtitle: r.toString(),
                      ).show(context);
                    },
                  );
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4.r),
                      bottomLeft: Radius.circular(4.r),
                    ),
                  ),
                  child: Text(
                    "İptal Et",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: white,
                        ),
                  ),
                ),
              ),
            ),
          if (employment.status == "offerreceived")
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: apsiyonPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r),
                  ),
                ),
                child: Text(
                  "Teklif Alındı",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: white,
                      ),
                ),
              ),
            ),
          if (employment.status == "offerreceived")
            Positioned(
              right: 10.w,
              bottom: 10.h,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        " Verilen Teklif :${employment.price} TL",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                      GestureDetector(
                        onTap: () {
                          notifier.setEmploymentStatus(
                              employmentID: employment.id, status: "waiting");

                          ref.read(jobProvider).failure.fold(
                            () {
                              CustomDialog.success(
                                title: "Teklif İptal Edildi",
                                subtitle: "Teklif başarıyla iptal edildi",
                              ).show(context);
                            },
                            (r) {
                              CustomDialog.failure(
                                title: "Teklif İptal Edilemedi",
                                subtitle: r.toString(),
                              ).show(context);
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4.r),
                              bottomLeft: Radius.circular(4.r),
                            ),
                          ),
                          child: Text(
                            "Teklifi Reddet",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: white,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          notifier.setEmploymentStatus(
                              employmentID: employment.id, status: "confirmed");

                          ref.read(jobProvider).failure.fold(
                            () {
                              CustomDialog.success(
                                title: "Teklif  Kabul Edildi",
                                subtitle: "Teklif başarıyla kabul edildi",
                              ).show(context);
                            },
                            (r) {
                              CustomDialog.failure(
                                title: "Teklif Kabul Edilemedi",
                                subtitle: r.toString(),
                              ).show(context);
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: apsiyonPrimaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(4.r),
                              bottomLeft: Radius.circular(4.r),
                            ),
                          ),
                          child: Text(
                            "Teklifi Kabul Et",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (employment.status == "confirmed")
            Positioned(
              right: 10.w,
              bottom: 10.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      notifier.setEmploymentStatus(
                          employmentID: employment.id, status: "waiting");

                      ref.read(jobProvider).failure.fold(
                        () {
                          CustomDialog.success(
                            title: "Hizmet İptal Edildi",
                            subtitle: "Hizmet başarıyla iptal edildi",
                          ).show(context);
                        },
                        (r) {
                          CustomDialog.failure(
                            title: "Hizmet İptal Edilemedi",
                            subtitle: r.toString(),
                          ).show(context);
                        },
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4.r),
                          bottomLeft: Radius.circular(4.r),
                        ),
                      ),
                      child: Text(
                        "Token Ver",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: white,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      notifier.setEmploymentStatus(
                          employmentID: employment.id, status: "completed");

                      ref.read(jobProvider).failure.fold(
                        () {
                          CustomDialog.success(
                            title: "Hizmet Tamamlandı",
                            subtitle: "Hizmet başarıyla tamamlandı",
                          ).show(context);
                        },
                        (r) {
                          CustomDialog.failure(
                            title: "Hizmet Tamamlanamadı",
                            subtitle: r.toString(),
                          ).show(context);
                        },
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: apsiyonPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4.r),
                          bottomLeft: Radius.circular(4.r),
                        ),
                      ),
                      child: Text(
                        "İş Tamamla",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: white,
                            ),
                      ),
                    ),
                  ),
                ],
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
    final state = ref.watch(jobProvider);
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.confirmedList.length,
        itemBuilder: (context, index) {
          return _Employment(
            employment: state.confirmedList[index],
          );
        },
      ),
    );
  }
}

class _OfferreceivedAndWaitingEmploymentsPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobProvider);
    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.activeList.length,
        itemBuilder: (context, index) {
          return _Employment(
            employment: state.activeList[index],
          );
        },
      ),
    );
  }
}

class _PastConfirmedTokenPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobProvider);
    return SizedBox(
      height: 190.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.completedList.length,
        itemBuilder: (context, index) {
          return _Employment(
            employment: state.completedList[index],
          );
        },
      ),
    );
  }
}

String _timeStampToString(Timestamp timestamp) {
  final date = timestamp.toDate();

  //yazıyla türkçe gün ve ay isimlerini yazdırmak için

  return "${date.day} ${monthNames[date.month]} ${date.year}";
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
const List<String> jobList = [
  "Kurye",
  "Taksici",
  "Nakliyat",
  "EvTemizliği",
  "Çilingir",
  "Boyacı",
  "Eğitmen",
  "Çocuk Bakıcısı",
  "Halı Yıkama",
  "Tamirci",
  "Bahçıvan",
  "Elektrikçi",
  "Su Tesisatçısı",
  "Marangoz",
  "Diğer",
];
