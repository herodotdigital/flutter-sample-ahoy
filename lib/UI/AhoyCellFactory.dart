import 'package:ahoy_sample/Models/Trip.dart';
import 'AhoyCell.dart';
import 'AhoyCellData.dart';

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