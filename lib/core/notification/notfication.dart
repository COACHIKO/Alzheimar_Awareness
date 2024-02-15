import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';


class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,

    );

    await AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');


  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    if (receivedAction.buttonKeyPressed == "add30sec") {
      Future.delayed(Duration(seconds: 30.toInt()), () async{
//i=30;
      showNotification(title: "You Have To keep Going Bro", body: "Dont Forget Your Dream , You Had A Big Rest",
          actionButtons: [
       NotificationActionButton(key: "more15", label: "More 15 Sec"),
       NotificationActionButton(key: "last30", label: "More 30 Sec"),
       NotificationActionButton(key: "Go", label: "Go Now !"),
     ]);
      });
    }else if(receivedAction.buttonKeyPressed == "add60sec"){
      Future.delayed(Duration(seconds: 30.toInt()), () async{
       // i=30;

        showNotification(title: "You Have To keep Going Bro", body: "Dont Forget Your Dream, You Had A Huge Rest, Go OFF!",);

      });


    }else if(receivedAction.buttonKeyPressed == "add30sec"){
      Future.delayed(Duration(seconds: 30.toInt()), () async{
       // i=30;


      showNotification(title: "You Have To keep Going Bro", body: "Dont Forget Your Dream , You Had A Big Rest",
          actionButtons: [
          NotificationActionButton(key: "last15", label: "More 15 Sec"),
          NotificationActionButton(key: "Go", label: "Go Now !"),
        ]);
      });



    }else if(receivedAction.buttonKeyPressed == "last30"){
      Future.delayed(Duration(seconds: 30.toInt()), () async{
      //  i=30;

        showNotification(title: "You Have To keep Going Bro", body: "Dont Forget Your Dream, You Had A Huge Rest, Go OFF!",);

      });


    }else if (receivedAction.buttonKeyPressed == "last15"){
      Future.delayed(Duration(seconds: 15.toInt()), () async{
       // i=15;

        showNotification(title: "You Have To keep Going Bro", body: "Dont Forget Your Dream, You Had A Huge Rest, Go OFF!",);
      });


    }



  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
        interval: interval,
        timeZone:
        await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
      )
          : null,
    );
  }















}