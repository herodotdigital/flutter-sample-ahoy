import 'Flight.dart';
import 'Booking.dart';
import 'Person.dart';
import 'package:meta/meta.dart';

class Trip {
  final int id;
  final Flight flight;
  final Booking booking;
  final Person person;
  final bool needsApproval;

  Trip({@required this.id, @required this.flight, @required this.booking, @required this.needsApproval, this.person}) {
    if (this.flight != null) {
      flight.parentTrip = this;
    }
    if (this.booking != null) {
      booking.parentTrip = this;
    }
  }
}