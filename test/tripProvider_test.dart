import "package:test/test.dart";
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';
import 'package:ahoy_sample/UI/TripList/TripCellData.dart';

TripProvider sut;

main() {

  group("TripProvider tests", (){

    setUp((){
      TripProvider.resetAll();
      sut = TripProvider();
    });

    test("Trip provider should return Trips", (){
      final result = sut.allTrips();
      expect(result, isList);
      expect(result, isNotEmpty);
      expect(result, everyElement(isInstanceOf<Trip>()));
    });

    test("Remove whole trip by Id", () {
      expect(sut.allTrips(), anyElement(predicate<Trip>((value) => value.id == 1)));
      sut.removeTrip(id: 1);
      expect(sut.allTrips(), everyElement(predicate<Trip>((value) => value.id != 1)));
    });

    test("Remove flight on trip with given Id", (){
      expect(sut.allTrips(), anyElement(predicate<Trip>((t) => t.id == 1 && t.flight != null)));
      sut.removeFlight(tripId:1);
      expect(sut.allTrips(), anyElement(predicate<Trip>((t) => t.id == 1 && t.flight == null)));
    });

    test("Remove booking on trip with given Id", (){
      expect(sut.allTrips(), anyElement(predicate<Trip>((t) => t.id == 1 && t.booking != null)));
      sut.removeBooking(tripId:1);
      expect(sut.allTrips(), anyElement(predicate<Trip>((t) => t.id == 1 && t.booking == null)));
    });
    
  });

  group("TripCellData generation", (){

    test("Call data should be instantinated from a flight", (){
      final exampleTrip = TripStubs.stubTodayTrip(id: 13);
      final flightCell = TripCellData.withFlight(exampleTrip.flight, exampleTrip.id);
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
      final exampleTrip = TripStubs.stubTodayTrip(id: 26);
      final bookingCell = TripCellData.withBooking(exampleTrip.booking, exampleTrip.id);
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

  });
}