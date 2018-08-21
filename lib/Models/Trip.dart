import 'Flight.dart';
import 'Booking.dart';
import 'Person.dart';
import 'package:meta/meta.dart';

class Trip {
  final int id;
  final Flight flight;
  final Booking booking;
  final Person person;

  Trip({@required this.id, @required this.flight, @required this.booking, this.person}) {
    if (this.flight != null) {
      flight.parentTrip = this;
    }
    if (this.booking != null) {
      booking.parentTrip = this;
    }
  }
}