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

}