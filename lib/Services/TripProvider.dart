import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';

class TripProvider {
  static List<Trip> _allTrips = _defaultTrips();

  static resetAll() {
    _allTrips = _defaultTrips();
  }

  static _defaultTrips() {
    return <Trip>[
      TripStubs.stubTodayTrip(id: 1),
      TripStubs.stubLaterTrip(id: 2),
    ];
  }

  List<Trip> allTrips() {
    return _allTrips;
  }

  Trip tripForId(int id) {
    return _allTrips.firstWhere((trip) {
      return trip.id == id;
    });
  }

  removeTrip({int id}) {
    _allTrips.removeWhere((t) => t.id == id);
  }
}