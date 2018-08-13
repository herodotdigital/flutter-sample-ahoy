import 'package:ahoy_sample/Models/Trip.dart';
import 'TripCellData.dart';

abstract class TripCellFactory {
  static List<TripCellData> cellDataListFrom(List<Trip> trips) {
    if (trips == null || trips.isEmpty) {
      return [];
    }
    return trips.expand((trip){
      List<TripCellData> list = [];
      if (trip.flight != null) {
        list.add(TripCellData.withFlight(trip.flight, trip.id));
      }
      if (trip.booking != null) {
        list.add(TripCellData.withBooking(trip.booking, trip.id));
      }
      return list;
    }).toList();
  }
}