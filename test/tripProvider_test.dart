import "package:test/test.dart";
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';
import 'package:ahoy_sample/UI/TripList/TripCellData.dart';

main() {
  test("Trip provider should return Trips", (){
    final sut = TripProvider();
    final result = sut.tripsNow();
    expect(result, isList);
    expect(result, isNotEmpty);
    expect(result, everyElement(isInstanceOf<Trip>()));
  });

  test("Call data should be instantinated from a flight", (){
    final exampleTrip = TripStubs.stubTodayTrip();
    final flightCell = TripCellData.withFlight(exampleTrip.flight, 13);
    expect(flightCell.tripId, 13);
    expect(flightCell.title, isNotNull);
    expect(flightCell.subtitle, isNotNull);
    expect(flightCell.iconName, isNotNull);
    expect(flightCell.topRightText, isNotNull);
    expect(flightCell.bottomRightCaption, isNotNull);
    expect(flightCell.bottomRightValue, isNotNull);
    expect(flightCell.bottomLeftCaption, isNotNull);
    expect(flightCell.bottomLeftValue, isNotNull);
  });

  test("Call data should be instantinated from a booking", (){
    final exampleTrip = TripStubs.stubTodayTrip();
    final bookingCell = TripCellData.withBooking(exampleTrip.booking, 26);
    expect(bookingCell.tripId, 26);
    expect(bookingCell.title, isNotNull);
    expect(bookingCell.subtitle, isNotNull);
    expect(bookingCell.iconName, isNotNull);
    expect(bookingCell.topRightText, isNotNull);
    expect(bookingCell.bottomRightCaption, isNotNull);
    expect(bookingCell.bottomRightValue, isNotNull);
    expect(bookingCell.bottomLeftCaption, isNotNull);
    expect(bookingCell.bottomLeftValue, isNotNull);
  });
}