import 'package:ahoy_sample/AhoyCell.dart';
import 'package:ahoy_sample/UI/AhoyCellData.dart';
import 'package:ahoy_sample/Models/Trip.dart';

class AhoyCellFactory {
  static List<AhoyCell> fromTrips(List<Trip> trips) {
    return AhoyCell.forData(
      trips.expand((trip){
        return [
          AhoyCellData.withFlight(trip.flight, trip.id),
          AhoyCellData.withBooking(trip.booking, trip.id),
        ];
      }).toList()
    );
  }
}