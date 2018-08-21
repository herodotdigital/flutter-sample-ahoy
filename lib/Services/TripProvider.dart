import 'package:ahoy_sample/Models/Trip.dart';
import 'package:meta/meta.dart';

class TripProvider {
  List<Trip> trips;

  TripProvider({@required this.trips});

  List<Trip> allTrips() {
    return trips;
  }

  Trip tripForId(int id) {
    return trips.firstWhere((trip) {
      return trip.id == id;
    });
  }

  removeTrip({int id}) {
    trips.removeWhere((t) => t.id == id);
  }

  removeFlight({int tripId}) {
    Trip oldTrip = tripForId(tripId);
    int index = trips.indexOf(oldTrip);
    trips.removeAt(index);
    Trip newTrip = Trip(id: oldTrip.id, needsApproval: oldTrip.needsApproval, booking: oldTrip.booking, flight: null);
    trips.insert(index, newTrip);
  }

  removeBooking({int tripId}) {
    Trip oldTrip = tripForId(tripId);
    int index = trips.indexOf(oldTrip);
    trips.removeAt(index);
    Trip newTrip = Trip(id: oldTrip.id, needsApproval: oldTrip.needsApproval, flight: oldTrip.flight, booking: null);
    trips.insert(index, newTrip);
  }
}