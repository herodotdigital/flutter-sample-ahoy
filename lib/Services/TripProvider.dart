import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';

class TripProvider {
  static final _allTrips = [
    TripStubs.stubTodayTrip(),
    TripStubs.stubLaterTrip(),
  ];

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