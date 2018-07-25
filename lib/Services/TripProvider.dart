import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';

class TripProvider {
  List<Trip> tripsNow() {
    return [TripStubs.stubTodayTrip()];
  }
  List<Trip> tripsLater() {
    return [TripStubs.stubLaterTrip()];
  }
}