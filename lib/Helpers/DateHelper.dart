class DateHelper {
    static String when(DateTime time) {
      // TODO: proper implementation
      return "in 30 mins";
    }

    static String clock(DateTime time) {
      // TODO: proper implementation using Intl package
      return "${time.hour}:${time.minute} PM";
    }

    static int howManyDays(DateTime start, DateTime end) {
      // TODO: fix edge cases
      return end.difference(start).inDays;
    }

    static String howLong(DateTime start, DateTime end) {
      // TODO: desired format: "3 h 21 min"
      // return end.difference(start).inMinutes;
      return "1 h 10 min";
    }

    static String localizedDate(DateTime date) {
      // TODO: proper implementation
      return "Tue, 22 Feb";
    }

    static bool isSameDay(DateTime dateA, DateTime dateB) {
      return dateA.year == dateB.year && 
        dateA.month == dateB.month && 
        dateA.day == dateB.day;
    }
}