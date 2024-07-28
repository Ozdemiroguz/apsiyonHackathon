import 'package:apsiyon/core/extensions/context_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/colors.dart';
import '../../../../custom/custom_dialog.dart';
import '../../../../custom/custom_filled_button.dart';
import '../../../../custom/custom_text_field.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../router/router.dart';
import '../../../../services/user_service/user_service_provider.dart';
import '../../domain/models/meeting.dart';
import '../providers/meeting_home_providers.dart';

//form key
final _keyProvider = Provider.autoDispose((ref) => GlobalKey<FormState>());

@RoutePage()
class MeetingHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meetingHomeProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: Container(
      //   width: 70.w,
      //   height: 160.h,
      //   padding: EdgeInsets.only(bottom: 90.h),
      //   child: CustomFilledButton(
      //     color: apsiyonPrimaryColor,
      //     onPressed: () {
      //       showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return SelectionDialog();
      //         },
      //       );
      //     },
      //     child: Container(
      //       decoration: BoxDecoration(
      //         boxShadow: [
      //           BoxShadow(
      //             color: black.withOpacity(0.1),
      //             offset: const Offset(0, 5),
      //             blurRadius: 10,
      //           ),
      //         ],
      //       ),
      //       child: const Icon(
      //         Icons.calendar_month,
      //         color: white,
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        shadowColor: red,
        backgroundColor: Colors.white,
        title: Text(
          'Toplantılar',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: black,
              ),
        ),
      ),
      body: Center(
        child: state.isLoading
            ? const CircularProgressIndicator.adaptive()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Aktif Toplantı",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (state.activeMeeting.isEmpty)
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
                            child: Assets.images.meeting.image(
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            color: white.withOpacity(0.8),
                            child: Text(
                              "Aktif Toplantınız Bulunmamaktadır",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: apsiyonPrimaryColor,
                                  ),
                            ),
                          ),
                        ],
                      )
                    else
                      _ActiveMeetingsPart(),
                    SizedBox(height: 30.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gelecek Toplantılar",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    _UpcomingMeetingsPart(),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Geçmiş Toplantılar",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _PastMeetingsPart(),
                  ],
                ),
              ),
      ),
    );
  }
}

class _ActiveMeetingsPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meetingHomeProvider);
    return SizedBox(
      height: 170.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 15.h),
        scrollDirection: Axis.horizontal,
        itemCount: state.activeMeeting.length,
        itemBuilder: (context, index) {
          return _ActiveMeetingCard(
            meeting: state.activeMeeting[index],
          );
        },
      ),
    );
  }
}

class _UpcomingMeetingsPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meetingHomeProvider);
    return SizedBox(
      height: 170.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 15.h),
        scrollDirection: Axis.horizontal,
        itemCount: state.meetingListUpcoming.length,
        itemBuilder: (context, index) {
          return _MeetingCard(
            meeting: state.meetingListUpcoming[index],
          );
        },
      ),
    );
  }
}

class _PastMeetingsPart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meetingHomeProvider);
    return SizedBox(
      height: 170.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 15.h),
        scrollDirection: Axis.horizontal,
        itemCount:
            state.meetingListPast.length < 3 ? state.meetingListPast.length : 3,
        itemBuilder: (context, index) {
          return _MeetingCard(
            meeting: state.meetingListPast[index],
          );
        },
      ),
    );
  }
}

class _MeetingCard extends ConsumerWidget {
  final Meeting meeting;

  const _MeetingCard({required this.meeting});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 170.h,
      width: 220.w,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10.0),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                meeting.title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: apsiyonPrimaryColor,
                    ),
              ),
              const Spacer(),
              const Icon(
                Icons.more_horiz,
                color: apsiyonPrimaryColor,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Text(
            meeting.description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: black,
                ),
          ),
          SizedBox(height: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    timestamptoDate(meeting.date),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: gray,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    meeting.location,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: gray,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Icon(
                    meeting.type == 'online'
                        ? Icons.video_call
                        : Icons.camera_outdoor,
                    color: apsiyonPrimaryColor,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    meeting.type == 'online'
                        ? 'Online'
                        : meeting.type == "hybrid"
                            ? 'Hibrit'
                            : 'Yüz Yüze',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

class _ActiveMeetingCard extends ConsumerWidget {
  final Meeting meeting;

  const _ActiveMeetingCard({required this.meeting});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 170.h,
      width: context.screenWidth - 30.w,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10.0),
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
          Positioned(
            bottom: 20.h,
            right: 10.w,
            child: SizedBox(
              width: 100.w,
              child: CustomFilledButton(
                color: apsiyonPrimaryColor,
                onPressed: () {
                  context.router.push(
                    VideoConferenceRoute(
                      conferenceID: meeting.meetingID,
                      userID: ref.read(userService).userData.uid[0] +
                          ref.read(userService).userData.uid[1],
                    ),
                  );
                },
                buttonText: "Katıl",
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    meeting.title,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: apsiyonPrimaryColor,
                        ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_horiz,
                    color: apsiyonPrimaryColor,
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Text(
                meeting.description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: black,
                    ),
              ),
              SizedBox(height: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: apsiyonPrimaryColor,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        timestamptoDate(meeting.date),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: gray,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: apsiyonPrimaryColor,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        meeting.location,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: gray,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Icon(
                        meeting.type == 'online'
                            ? Icons.video_call
                            : Icons.camera_outdoor,
                        color: apsiyonPrimaryColor,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        meeting.type == 'online'
                            ? 'Online'
                            : meeting.title == "hybrid"
                                ? 'Hibrit'
                                : 'Yüz Yüze',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: gray,
                            ),
                      ),
                    ],
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
    final state = ref.watch(meetingHomeProvider);
    return Form(
      key: ref.watch(_keyProvider),
      child: AlertDialog(
        title: const Text('Site/Apartman Seçimi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              hintText: 'Toplantı Başlığı',
              onChanged: (value) =>
                  ref.read(meetingHomeProvider.notifier).onChangedTitle(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir başlık giriniz';
                }
                return null;
              },
            ),

            SizedBox(height: 10.h),
            //toplantı türü seçimi
            CustomTextField(
              hintText: 'Toplantı Açıklaması',
              onChanged: (value) => ref
                  .read(meetingHomeProvider.notifier)
                  .onChangedDescription(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir açıklama giriniz';
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 200.w,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Toplantı Türü"),
                  value: state.selectedMeetingType,
                  items: <String>['Online', 'Yüz Yüze', 'Hibrit']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    ref
                        .read(meetingHomeProvider.notifier)
                        .onChangedSelectedMeeting(
                          value,
                        );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),

            Visibility(
              visible: state.selectedMeetingType == 'Yüz Yüze' ||
                  state.selectedMeetingType == 'Hibrit',
              child: CustomTextField(
                hintText: 'Location',
                onChanged: (value) => ref
                    .read(meetingHomeProvider.notifier)
                    .onChangedLocation(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir lokasyon giriniz';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10.h),
            //display date picker
            Visibility(
              visible: state.selectedMeetingType != null,
              child: SizedBox(
                width: 200.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: //birgün sonrası
                              DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day + 1,
                          ),
                          firstDate: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day + 1,
                          ),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null) {
                          ref
                              .read(meetingHomeProvider.notifier)
                              .onChangedDate(picked);
                        }
                      },
                      child: Text(
                        style: Theme.of(context).textTheme.bodyLarge,
                        state.date == null
                            ? 'Tarih Seç'
                            : "Tarih: ${state.date!.day}.${state.date!.month}.${state.date!.year}",
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              width: 200.w,
              child: Visibility(
                visible: state.date != null,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        ref
                            .read(meetingHomeProvider.notifier)
                            .onChangedTimeOfDay(picked);
                      }
                    },
                    child: Text(
                      style: Theme.of(context).textTheme.bodyLarge,
                      state.timeOfDay == null
                          ? 'Saat Seç'
                          : "Saat:${state.timeOfDay!.hour}:${state.timeOfDay!.minute}",
                    ),
                  ),
                ),
              ),
            ),
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
                  child: CustomFilledButton(
                    onPressed: () async {
                      final notifier = ref.read(meetingHomeProvider.notifier);
                      final state = ref.read(meetingHomeProvider);
                      if (ref.read(_keyProvider).currentState!.validate()) {
                        if (state.selectedMeetingType == null) {
                          return const CustomDialog.failure(
                            title: "Hata",
                            subtitle: "Toplantı Türü Seçiniz",
                          ).show(context);
                        }
                        if (state.selectedMeetingType == 'Yüzyüze' ||
                            state.selectedMeetingType == 'Hibrit') {
                          if (state.location == null) {
                            return const CustomDialog.failure(
                              title: "Hata",
                              subtitle: "Lokasyon Seçiniz",
                            ).show(context);
                          }
                        }

                        if (state.date == null) {
                          return const CustomDialog.failure(
                            title: "Hata",
                            subtitle: "Tarih Seçiniz",
                          ).show(context);
                        }
                        if (state.timeOfDay == null) {
                          return const CustomDialog.failure(
                            title: "Hata",
                            subtitle: "Saat Seçiniz",
                          ).show(context);
                        }

                        await notifier.setMeeting();

                        ref.read(meetingHomeProvider).failure.fold(
                          () {
                            Future.delayed(const Duration(seconds: 2), () {
                              //scaffol ile bilgilendirme yapılabilir
                              //contexti kontrol et
                              if (context.mounted) {
                                print("Toplantı Oluşturuldu");
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
                              subtitle: "Toplantı Oluşturuldu",
                            ).show(context);
                          },
                          (a) => CustomDialog.failure(
                            title: "Hata",
                            subtitle: a.message,
                          ).show(context),
                        );
                      }
                    },
                    buttonText: "Toplantı Oluştur",
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

String timestamptoDate(Timestamp timestamp) {
  final date = timestamp.toDate();
  return "${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}";
}
