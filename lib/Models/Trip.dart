import 'package:ahoy_sample/Models/Flight.dart';
import 'package:ahoy_sample/Models/Booking.dart';

class Trip {
  final int id;
  final Flight flight;
  final Booking booking;

  Trip({this.id, this.flight, this.booking});
}