import 'package:ahoy_sample/Models/Trip.dart';
import 'TripCell.dart';
import 'TripCellData.dart';

abstract class TripCellFactory {
  static List<TripCell> fromTrips(List<Trip> trips) {
    return TripCell.forData(cellDataListFrom(trips));
  }

  static List<TripCellData> cellDataListFrom(List<Trip> trips) {
    if (trips == null || trips.isEmpty) {
      return [];
    }
    return trips.expand((trip){
      return [
        TripCellData.withFlight(trip.flight, trip.id),
        TripCellData.withBooking(trip.booking, trip.id),
      ];
    }).toList();
  }
}