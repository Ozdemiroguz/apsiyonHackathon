import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import 'jobs_page.dart';
import 'myJobs_page.dart';

class PageChangeNotifier extends StateNotifier<bool> {
  PageChangeNotifier() : super(false);

  void setPage(bool value) {
    state = value;
  }
}

final pageChangeProvider = StateNotifierProvider<PageChangeNotifier, bool>(
  (ref) => PageChangeNotifier(),
);

@RoutePage()
class JobManagePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pageChangeProvider);

    return Scaffold(
      appBar: AppBar(
        shadowColor: red,
        backgroundColor: Colors.white,
        title: Text(
          "Apsyion 3.Şahıs",
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: black,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(pageChangeProvider.notifier).setPage(false);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: state ? white : apsiyonPrimaryColor,
                            width: 2.w,
                          ),
                        ),
                      ),
                      child: Text(
                        "İş İlanlari",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: apsiyonPrimaryColor,
                                ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(pageChangeProvider.notifier).setPage(true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: state ? apsiyonPrimaryColor : white,
                            width: 2.w,
                          ),
                        ),
                      ),
                      child: Text(
                        "İşlerim",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: apsiyonPrimaryColor,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: !state ? JobsPage() : MyjobsPage(),
    );
  }
}
