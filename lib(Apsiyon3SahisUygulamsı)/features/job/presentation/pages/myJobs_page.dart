import 'dart:math';

import 'package:apsiyon3/core/extensions/context_extensions.dart';
import 'package:apsiyon3/features/job/presentation/pages/jobs_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../domain/models/employment.dart';
import '../providers/job_provider.dart';

class MyjobsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Aktif İşler",
                    style: Theme.of(context).textTheme.displaySmall),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.confirmedList.isEmpty)
                const _EmptylistPart(
                  text: "Aktif işiniz bulunmamaktadır",
                )
              else
                _EmploymentListPartActive(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Onay Bekleyen İşler",
                    style: Theme.of(context).textTheme.displaySmall),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state.personalEmploymentList.isEmpty)
                const _EmptylistPart(
                  text: "Aktif işiniz bulunmamaktadır",
                )
              else
                _EmploymentListPart(),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Tamamlanan İşler",
                    style: Theme.of(context).textTheme.displaySmall),
              ),
              if (state.completedEmploymentList.isEmpty)
                const _EmptylistPart(
                  text: "Tamamlanan işiniz bulunmamaktadır",
                )
              else
                _EmploymentListPart(),
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

class _ActiveEmployments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _EmploymentListPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobProvider);
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.personalEmploymentList.length,
        itemBuilder: (context, index) {
          return SizedBox(
              width: context.screenWidth - 40.w,
              child: _EmploymentPart(
                  employment: state.personalEmploymentList[index]));
        },
      ),
    );
  }
}

class _EmploymentListPartActive extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobProvider);
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.confirmedList.length,
        itemBuilder: (context, index) {
          return SizedBox(
              width: context.screenWidth - 40.w,
              child: _EmploymentPart(employment: state.confirmedList[index]));
        },
      ),
    );
  }
}

class _CompletedeList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobProvider);

    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.completedEmploymentList.length,
        itemBuilder: (context, index) {
          return SizedBox(
              width: context.screenWidth - 40.w,
              child: _EmploymentPart(
                  employment: state.completedEmploymentList[index]));
        },
      ),
    );
  }
}

class _EmploymentPart extends ConsumerWidget {
  final Employment employment;

  const _EmploymentPart({Key? key, required this.employment}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(jobProvider.notifier);
    // Her widget için yeni GlobalKey oluştur
    return Container(
      height: 220.h,
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
                    Icons.location_on_outlined,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      employment.employerAddress,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: gray,
                          ),
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
                    Icons.person_outlined,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    employment.employerName,
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
            ],
          ),
          if (employment.status == "Completed")
            Positioned(
              right: 0,
              bottom: 0,
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
                  "Tamamlandı",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: white,
                      ),
                ),
              ),
            ),
          if (employment.status == "confirmed")
            Positioned(
              right: 10,
              bottom: 10,
              child: Column(
                children: [
                  Text("Fiyat :${employment.price} ₺"),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
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
                      "Onaylandı",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          if (employment.status == "offerreceived")
            Positioned(
              right: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Teklifedilen fiyat :${employment.price} ₺"),
                    ],
                  ),
                  Container(
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
                      "İşveren cevabı bekleniyor",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: white,
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
