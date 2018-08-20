import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';

class TripProvider {
  List<Trip> _trips = _defaultTrips();

  resetAll() {
    _trips = _defaultTrips();
  }

  static _defaultTrips() {
    return <Trip>[
      TripStubs.stubTodayTrip(id: 1),
      TripStubs.stubLaterTrip(id: 2),
    ];
  }

  List<Trip> allTrips() {
    return _trips;
  }

  Trip tripForId(int id) {
    return _trips.firstWhere((trip) {
      return trip.id == id;
    });
  }

  removeTrip({int id}) {
    _trips.removeWhere((t) => t.id == id);
  }

  removeFlight({int tripId}) {
    Trip oldTrip = tripForId(tripId);
    int index = _trips.indexOf(oldTrip);
    _trips.removeAt(index);
    Trip newTrip = Trip(id: oldTrip.id, booking: oldTrip.booking, flight: null);
    _trips.insert(index, newTrip);
  }

  removeBooking({int tripId}) {
    Trip oldTrip = tripForId(tripId);
    int index = _trips.indexOf(oldTrip);
    _trips.removeAt(index);
    Trip newTrip = Trip(id: oldTrip.id, flight: oldTrip.flight, booking: null);
    _trips.insert(index, newTrip);
  }
}