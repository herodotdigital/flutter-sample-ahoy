import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

// Format: https://pub.dartlang.org/documentation/intl/latest/intl/DateFormat-class.html

class DateHelper {
    static String when(DateTime time) {
      final String eta = howLong(DateTime.now(), time, pluralMinutes:true);
      return "in $eta";
    }

    static String clock(DateTime time) {
      return DateFormat.jm().format(time);
    }

    static int howManyDays(DateTime start, DateTime end) {
      return end.difference(start).inDays;
    }

    // format: "1d 3 h 21 min"
    static String howLong(DateTime start, DateTime end, {bool pluralMinutes = false}) {
      final diff = end.difference(start);
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

    static String localizedDate(DateTime date) {
      return DateFormat("EEE, d MMM").format(date); // "Fri, 22 Feb"
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
}