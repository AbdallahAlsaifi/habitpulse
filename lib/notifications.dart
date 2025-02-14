import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habitpulse/constants.dart';
import 'package:habitpulse/generated/l10n.dart';

bool platformSupportsNotifications() => Platform.isAndroid || Platform.isIOS;

void initializeNotifications() {
  AwesomeNotifications().initialize(
    'resource://raw/res_app_icon',
    [
      NotificationChannel(
          channelKey: 'app_notifications_HabitPulse',
          channelName: 'App notifications',
          channelDescription:
              'Notification channel for application notifications',
          defaultColor: HabitPulseColors.primary,
          importance: NotificationImportance.Max,
          criticalAlerts: true),
      NotificationChannel(
          channelKey: 'habit_notifications_HabitPulse',
          channelName: 'Habit notifications',
          channelDescription: 'Notification channel for habit notifications',
          defaultColor: HabitPulseColors.primary,
          importance: NotificationImportance.Max,
          criticalAlerts: true)
    ],
  );
}

void resetAppNotificationIfMissing(TimeOfDay timeOfDay) async {
  AwesomeNotifications().listScheduledNotifications().then((notifications) {
    for (var not in notifications) {
      if (not.content?.id == 0) {
        return;
      }
    }
    setAppNotification(timeOfDay);
  });
}

void setAppNotification(TimeOfDay timeOfDay) async {
  _setupDailyNotification(0, timeOfDay, 'HabitPulse',
      S.current.doNotForgetToCheckYourHabits, 'app_notifications_HabitPulse');
}

void setHabitNotification(
    int id, TimeOfDay timeOfDay, String title, String desc) {
  _setupDailyNotification(
      id, timeOfDay, title, desc, 'habit_notifications_HabitPulse');
}

void disableHabitNotification(int id) {
  if (platformSupportsNotifications()) {
    AwesomeNotifications().cancel(id);
  }
}

void disableAppNotification() {
  AwesomeNotifications().cancel(0);
}

Future<void> _setupDailyNotification(int id, TimeOfDay timeOfDay, String title,
    String desc, String channel) async {
  if (platformSupportsNotifications()) {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channel,
        title: title,
        body: desc,
        wakeUpScreen: true,
        criticalAlert: true,
        category: NotificationCategory.Reminder,
      ),
      schedule: NotificationCalendar(
          hour: timeOfDay.hour,
          minute: timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
          preciseAlarm: true,
          timeZone: localTimeZone),
    );
  }
}
