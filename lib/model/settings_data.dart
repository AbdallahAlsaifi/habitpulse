import 'package:flutter/material.dart';
import 'package:habitpulse/constants.dart';
import 'package:habitpulse/helpers.dart';
import 'package:table_calendar/table_calendar.dart';

class SettingsData {
  Themes theme = Themes.device;
  StartingDayOfWeek weekStart = StartingDayOfWeek.monday;
  TimeOfDay dailyNotTime = const TimeOfDay(hour: 20, minute: 0);
  bool showDailyNot = true;
  bool soundEffects = true;
  bool showMonthName = true;
  bool seenOnboarding = false;
  Color checkColor = HabitPulseColors.primary;
  Color failColor = HabitPulseColors.red;
  Color skipColor = HabitPulseColors.skip;

  SettingsData();

  SettingsData.fromJson(Map<String, dynamic> json)
      : theme = Themes.values[json['theme']],
        weekStart = StartingDayOfWeek.values[json['weekStart']],
        showDailyNot =
            (json['showDailyNot'] != null) ? json['showDailyNot'] : true,
        soundEffects =
            (json['soundEffects'] != null) ? json['soundEffects'] : true,
        showMonthName =
            (json['showMonthName'] != null) ? json['showMonthName'] : true,
        dailyNotTime = (json['notTime'] != null)
            ? parseTimeOfDay(json['notTime'])
            : const TimeOfDay(hour: 20, minute: 0),
        seenOnboarding =
            (json['seenOnboarding'] != null) ? json['seenOnboarding'] : false,
        checkColor = (json['checkColor'] != null)
            ? Color(json['checkColor'])
            : HabitPulseColors.primary,
        failColor = (json['failColor'] != null)
            ? Color(json['failColor'])
            : HabitPulseColors.red,
        skipColor = (json['skipColor'] != null)
            ? Color(json['skipColor'])
            : HabitPulseColors.skip;

  Map<String, dynamic> toJson() => {
        'theme': theme.index,
        'weekStart': weekStart.index,
        'notTime':
            '${dailyNotTime.hour.toString().padLeft(2, '0')}:${dailyNotTime.minute.toString().padLeft(2, '0')}',
        'showDailyNot': showDailyNot,
        'soundEffects': soundEffects,
        'showMonthName': showMonthName,
        'seenOnboarding': seenOnboarding,
        'checkColor': checkColor.value,
        'failColor': failColor.value,
        'skipColor': skipColor.value,
      };
}
