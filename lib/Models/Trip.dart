import 'Flight.dart';
import 'Booking.dart';
import 'package:meta/meta.dart';

class Trip {
  final int id;
  final Flight flight;
  final Booking booking;

  Trip({@required this.id, @required this.flight, @required this.booking}) {
    flight.parentTrip = this;
    booking.parentTrip = this;
  }
}