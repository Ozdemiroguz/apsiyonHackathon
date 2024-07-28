import 'package:apsiyon3/custom/custom_filled_button.dart';
import 'package:apsiyon3/custom/custom_text_field.dart';
import 'package:apsiyon3/features/kurye/presentation/providers/kuryepage_provider.dart';
import 'package:apsiyon3/services/kurye_service/kurye_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../gen/assets.gen.dart';

@RoutePage()
class KuryeHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kuryeProvider);

    return Scaffold(
      appBar: _TopPart(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text("Aktif Token",
                style: Theme.of(context).textTheme.displayMedium),
            SizedBox(height: 10.h),
            Stack(
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
                Container(
                  padding: const EdgeInsets.all(10.0),
                  color: white.withOpacity(0.8),
                  child: Text(
                    "Aktif Tokeniniz Bulunmamaktadır",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: apsiyonPrimaryColor,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _FilterInput(),
            SizedBox(height: 20.h),
            _ConstantlyOrders(),
          ],
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

class _FilterInput extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(kuryePageProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              Text(
                "Filrele",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: apsiyonPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              GestureDetector(
                child: Text(
                  "Tümünü Göster",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: apsiyonPrimaryColor),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        CustomTextField(
          hintText: "Token",
          onChanged: (value) => notifier.onChangedToken(value),
          validator: (value) => value!.isEmpty ? "Token boş olamaz" : null,
        ),
      ],
    );
  }
}

class _ConstantlyOrders extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(kuryePageProvider.notifier);
    final state = ref.watch(kuryePageProvider);
    return SizedBox(
        height: 300.h,
        child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 100.h,
                padding: EdgeInsets.all(10.w),
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(4.r),
                  boxShadow: [
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
                        Text("Apartman İsmi"),
                        Text("Adress"),
                        Text("Tarih"),
                      ],
                    ),
                    const Spacer(),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: apsiyonPrimaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            "Token Talep Et",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: white),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
