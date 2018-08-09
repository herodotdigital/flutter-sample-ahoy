import "package:test/test.dart";
import 'package:ahoy_sample/Helpers/DateHelper.dart';

main() {
  
  test("Is same day", (){
    DateTime morning = DateTime.utc(2018, 1, 2, 8, 15);
    DateTime afternoon = DateTime.utc(2018, 1, 2, 12, 15);
    DateTime nextDay = DateTime.utc(2018, 1, 3, 0, 1);
    DateTime dayBefore = DateTime.utc(2018, 1, 1, 23, 59);

    expect(DateHelper.isSameDay(morning, afternoon), isTrue);
    expect(DateHelper.isSameDay(morning, nextDay), isFalse);
    expect(DateHelper.isSameDay(morning, dayBefore), isFalse);
  });

  test("Format using custom format",(){
    DateTime day = DateTime.utc(2018, 3, 9);

    expect(DateHelper.formatted(format: "d MMMM", date: day), "9 March");
  });

  test("Format using custom format",(){
    DateTime day = DateTime.utc(2018, 3, 9);

    expect(DateHelper.formatted(format: "d MMMM", date: day), "9 March");
  });

  test("Format using localizedDate", (){
    DateTime day = DateTime.utc(2018, 2, 2);

    expect(DateHelper.localizedDate(day), "Fri, 2 Feb");
  });

  test("How long in '1 h 10 mins' format",(){
    DateTime from = DateTime.utc(2018, 2, 2, 8);
    DateTime to = DateTime.utc(2018, 2, 3, 9, 15);

    expect(DateHelper.howLong(from, to, pluralMinutes: true), "1 d 1 h 15 mins");
    expect(DateHelper.howLong(from, to, pluralMinutes: false), "1 d 1 h 15 min");
    expect(DateHelper.howLong(from, to), "1 d 1 h 15 min");
  });

  test("Format date as clock", (){
    DateTime hour_6_30 = DateTime.utc(2018, 2, 2, 6, 30);
    DateTime hour_13_15 = DateTime.utc(2018, 2, 2, 13, 15);

    expect(DateHelper.clock(hour_6_30), "6:30 AM");
    expect(DateHelper.clock(hour_13_15), "1:15 PM");
  });

  test("Get difference in days", (){
    DateTime from = DateTime.utc(2018, 2, 2, 8);
    DateTime to = DateTime.utc(2018, 2, 3, 9, 15);

    expect(DateHelper.howManyDays(from, to), 1);
  });

  test("Human readable 'when' format", (){
    DateTime fakeNow = DateHelper.today(18, 00);
    DateTime nearFuture = DateTime.now().add(Duration(minutes: 15, seconds: 5));
    DateTime laterToday = fakeNow.add(Duration(hours: 5, seconds: 5));
    DateTime earlyTomorrow = fakeNow.add(Duration(hours: 8, seconds: 5));
    DateTime farFuture = DateTime.now().add(Duration(days: 30));

    expect(DateHelper.when(nearFuture), "in 15 mins");
    expect(DateHelper.when(laterToday, referenceDate: fakeNow), "Today");
    expect(DateHelper.when(earlyTomorrow, referenceDate: fakeNow), "Tomorrow");
    expect(DateHelper.when(farFuture), allOf(
      contains(", "),
    ));
  });
}