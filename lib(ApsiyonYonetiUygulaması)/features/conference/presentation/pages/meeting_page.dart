import 'package:apsiyonY/services/user_service/user_service_provider.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

final zegoUIKitPrebuiltVideoConferenceController =
    ZegoUIKitPrebuiltVideoConferenceController();

@RoutePage()
class VideoConferencePage extends ConsumerWidget {
  final String conferenceID;
  final String userID;

  const VideoConferencePage({
    super.key,
    required this.conferenceID,
    required this.userID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //gelen mesajo yakalamak için

    return Stack(
      children: [
        SafeArea(
          child: ZegoUIKitPrebuiltVideoConference(
            appID: 1999385078 /*input your AppID*/,
            appSign:
                "4cceb3b7ba4370e2662a3b4bf3129b9b65c14f8b8b8bc845804f3d69b9c3f61d" /*input your AppSign*/,
            userID: userID,
            userName: ref.read(userService).userData.name,
            conferenceID: conferenceID,
            config: ZegoUIKitPrebuiltVideoConferenceConfig(
              chatViewConfig: ZegoInRoomChatViewConfig(
                itemBuilder: (context, message, extraInfo) {
                  print("Message: ${message.toString()}");
                  final List<Widget> widgets = [];

                  widgets.add(
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          message.user.name[0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                  widgets.add(
                    SizedBox(
                      width: 8,
                    ),
                  );
                  widgets.add(
                    Column(
                      crossAxisAlignment: userID == message.user.id
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              message.user.name,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              " ${getHour(message.timestamp)}",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: message.user.id == userID
                                ? Colors.blue[800]
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            message.message,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                  return Row(
                    mainAxisAlignment: userID == message.user.id
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: userID == message.user.id
                        ? widgets.reversed.toList()
                        : widgets,
                  );
                },
              ),
            ),
            controller: zegoUIKitPrebuiltVideoConferenceController,
          ),
        ),
      ],
    );
  }
}

String getHour(int timestamp) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final String hour = date.hour.toString();
  final String minute = date.minute.toString();

  //pm or am
  final String period = date.hour > 12 ? "PM" : "AM";

  return "$hour:$minute $period";
}
