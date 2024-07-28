import 'package:apsiyon3/custom/custom_dialog.dart';
import 'package:apsiyon3/custom/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../domain/models/employment.dart';
import '../providers/job_provider.dart';

//form key
final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

class JobsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyProvider = ref.watch(_keyProvider);
    final state = ref.watch(jobProvider);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: keyProvider,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                hintText: "Ara",
              ),
              SizedBox(
                height: 20.h,
              ),
              _JobsPart(),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobsPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobProvider);
    final formKey = ref.watch(_keyProvider);

    return Container(
      height: 800.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 10.w,
        ),
        itemCount: state.employmentList.length,
        itemBuilder: (context, index) {
          return _EmploymentPart(
              employment: state.employmentList[index], formKey: formKey);
        },
      ),
    );
  }
}

class _EmploymentPart extends ConsumerWidget {
  final Employment employment;
  final GlobalKey? formKey;

  _EmploymentPart({required this.employment, this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(jobProvider.notifier);
    // Her widget için yeni GlobalKey oluştur
    return Container(
      height: 250.h,
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
          if (employment.status == "waiting")
            Positioned(
              right: 10.w,
              bottom: 10.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120.w,
                    child: CustomTextField(
                        initialValue: "100",
                        hintText: "Fiyat",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Lütfen fiyat giriniz" : null,
                        onChanged: (value) {
                          ref.read(jobProvider.notifier).onPrice(value);
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (ref.read(_keyProvider).currentState!.validate()) {
                        notifier.setOffer(employmentId: employment.id);

                        ref.read(jobProvider).failure.fold(
                              () => CustomDialog.success(
                                title: "Başarılı",
                                subtitle: "Teklifiniz alındı",
                              ).show(context),
                              (a) => CustomDialog.failure(
                                title: "Hata",
                                subtitle: a.message,
                              ).show(context),
                            );
                      }
                    },
                    child: Container(
                      height: 50.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      decoration: BoxDecoration(
                        color: apsiyonPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4.r),
                          bottomLeft: Radius.circular(4.r),
                        ),
                      ),
                      child: Align(
                        child: Text(
                          "Teklif Ver",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
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
