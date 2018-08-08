import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';

abstract class TripProvider {
  List<Trip> allTrips();
}

class MyTripProvider extends TripProvider {
  static final _allTrips = [
    TripStubs.stubTodayTrip(id: 1),
    TripStubs.stubLaterTrip(id: 2),
  ];

  List<Trip> allTrips() {
    return _allTrips;
  }

  List<Trip> tripsNow() {
    return [_allTrips[0]];
  }
  List<Trip> tripsLater() {
    return [_allTrips[1]];
  }

  Trip tripForId(int id) {
    return _allTrips.firstWhere((trip) {
      return trip.id == id;
    });
  }
}