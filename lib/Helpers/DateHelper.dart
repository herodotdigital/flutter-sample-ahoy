import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

// Format: https://pub.dartlang.org/documentation/intl/latest/intl/DateFormat-class.html

class DateHelper {
    static String when(DateTime time, {DateTime referenceDate}) {
      final now = referenceDate ?? DateTime.now();
      final endOfToday = now.add(Duration(days: 1, hours: -now.hour, minutes: -now.minute, seconds: -now.second));
      final endOfTomorrow = endOfToday.add(Duration(days: 1));
      final moreThan4h = time.isAfter(now.add(Duration(hours: 4)));
      if (time.isAfter(endOfTomorrow)) {
        return DateHelper.localizedDate(time);
      } else if(time.isAfter(endOfToday) && moreThan4h) {
        return "Tomorrow";
      } else if(moreThan4h) {
        return "Today";
      } else {
        final String eta = howLong(now, time, pluralMinutes:true);
        return "in $eta";
      }
    }

    static String clock(DateTime time) {
      return DateFormat.jm().format(time);
    }

    static int howManyNights(DateTime start, DateTime end) {
      final diff = end.difference(start); 
      final incompleteDay = start.hour > end.hour ? 1 : 0;
      return diff.inDays + incompleteDay;
    }

    /// format: "1d 3 h 21 min"
    static String howLong(DateTime start, DateTime end, {bool pluralMinutes = false}) {
      final diff = end.difference(start);
      if (diff.isNegative) {
        return "Past";
      }
      final days = diff.inDays;
      final hours = diff.inHours.remainder(24);
      final minutes = diff.inMinutes.remainder(60);
      List<String> parts = [];
      if (days > 0) {
        parts.add("$days d");
      }
      if (hours > 0) {
        parts.add("$hours h");
      }
      if (minutes > 0) {
        final suffix = (minutes > 1 && pluralMinutes) ? "mins" : "min"; 
        parts.add("$minutes $suffix");
      }
      return parts.join(" ");
    }

    /// Format: "Fri, 22 Feb"
    static String localizedDate(DateTime date) {
      return DateFormat("EEE, d MMM").format(date);
    }

    static String formatted({@required String format, @required DateTime date}) {
      var formatter = DateFormat(format);
      return formatter.format(date);
    }

    static bool isSameDay(DateTime dateA, DateTime dateB) {
      return dateA.year == dateB.year && 
        dateA.month == dateB.month && 
        dateA.day == dateB.day;
    }

    static DateTime after({int days, int hours, int minutes, bool addMargin = true}) {
      return DateTime.now().add(Duration(
        days: days ?? 0,
        hours: hours ?? 0,
        minutes: minutes ?? 0,
        seconds: addMargin ? 2 : 0,
      ));
    }

    static DateTime today(int hour, int minute) {
      final now = DateTime.now();
      return DateTime.utc(now.year, now.month, now.day, hour, minute);
    }
}