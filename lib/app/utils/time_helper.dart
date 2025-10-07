import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeHelper {
  TimeHelper._();

  static Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  static List<String> getSlots(
      {int start = 9, int end = 11, String period = '', int step = 15}) {
    // if(route == AppStrings.telemedicine) {
    final startTime = TimeOfDay(hour: start, minute: 0);
    final endTime = TimeOfDay(hour: end, minute: 30);
    final stepDuration = Duration(minutes: step);

    final times = getTimes(startTime, endTime, stepDuration)
        .map((tod) => DateFormat('hh:mm a', 'en').format(DateTime(
              2022,
              1,
              1,
              tod.hour,
              tod.minute,
            )))
        .toList();

    return times;
    //}
    // else{
    //   return [period];
    // }
  }

  static addZerosToDate(String date) {
    var dateParts = date.split('-');
    var month = dateParts[1].padLeft(2, '0');
    var day = dateParts[2].split(' ')[0].padLeft(2, '0');
    var hour = date.length > 10
        ? date.split(' ')[1].split(':')[0].padLeft(2, '0')
        : '00';
    var min = date.length > 10
        ? date.split(' ')[1].split(':')[1].padLeft(2, '0')
        : '00';
    // var min=date.length>10? date.substring(10,date.length).split(':')[1].padLeft(2,'0'):'00';

//   print(day);
    // print(hour);
    //print(min);

    var time =
        (('${dateParts[0]}-$month-$day $hour:$min')
            .trim());

    return DateTime.parse(time);
  }
}
