import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../custom/custom_text_field.dart';
import '../../../../router/router.dart';

//gloval text editing controller
final meetingIDController = TextEditingController();
final userIDController = TextEditingController();

@RoutePage()
class MeetingEnterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Meeting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Enter Meeting ID and User ID:${userIDController.text}, ${meetingIDController.text}'),
            CustomTextField(
              hintText: 'Meeting ID',
              controller: meetingIDController,
              onChanged: (value) => meetingIDController.text = value,
            ),
            CustomTextField(
              hintText: 'User ID',
              controller: userIDController,
              onChanged: (value) => userIDController.text = value,
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(
                    VideoConferenceRoute(conferenceID: "777", userID: "oguz"));
              },
              child: Text('Enter'),
            ),
            ElevatedButton(
                onPressed: () {
                  print('Meeting ID: ${meetingIDController.text}');
                  print('User ID: ${userIDController.text}');
                },
                child: Text('Print Meeting ID and User ID')),
          ],
        ),
      ),
    );
  }
}
