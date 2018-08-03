import 'Flight.dart';
import 'Booking.dart';

class Trip {
  final int id;
  final Flight flight;
  final Booking booking;

  Trip({this.id, this.flight, this.booking});
}