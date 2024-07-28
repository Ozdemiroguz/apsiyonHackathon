import 'package:apsiyon3/constants/colors.dart';
import 'package:apsiyon3/custom/custom_dialog.dart';
import 'package:apsiyon3/gen/assets.gen.dart';
import 'package:apsiyon3/router/router.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common/loading_overlay.dart';
import '../providers/register_provider.dart';

@RoutePage()
class JobPage extends ConsumerWidget {
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
      body: Column(
        children: [
          SizedBox(height: 70.h),
          Align(child: Assets.images.indir.image(height: 40.h)),
          Text(
            "3.Şahıs ",
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: apsiyonPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Sizi daha yakından tanımamız için bir iş seçin',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          _JobList(),
          SizedBox(height: 40.h),
          Text(
            '( Kaydırarak diğer işleri görebilirsiniz )',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: apsiyonPrimaryColor,
                ),
          ),
        ],
      ),
    );
  }
}

class _JobList extends ConsumerWidget {
  _JobList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(registerProvider.notifier);
    return SizedBox(
      height: 540.h,
      child: Scrollbar(
        thickness: 10.r,
        child: ListView.separated(
          itemCount: jobList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await notifier.setJob(jobList[index]);

                ref.read(registerProvider).failure.fold(() {
                  if (jobList[index] == 'Kurye') {
                    Future.delayed(Duration(seconds: 2), () {
                      context.router.replaceAll([const LoginRoute()]);
                    });

                    CustomDialog.success(
                      onClosedPressed: () => context.router.replaceAll(
                        [const LoginRoute()],
                      ),
                      title: "Başarılı",
                      subtitle:
                          "Kurye olarak kaydınız alınmıştır. Giriş yapabilirsiniz.",
                    ).show(context);
                  } else {
                    context.router.push(const DescriptionRoute());
                  }
                },
                    (a) => CustomDialog.failure(
                          title: "Hata",
                          subtitle: a.message,
                        ).show(context));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Text(
                  textAlign: TextAlign.start,
                  '${jobList[index]}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              child: Divider(
                color: gray,
                thickness: 1,
              ),
            );
          },
        ),
      ),
    );
  }
}

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
