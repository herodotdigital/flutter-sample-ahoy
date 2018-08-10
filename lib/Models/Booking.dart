import 'Trip.dart';

class Booking {
  Trip parentTrip;
  String name;
  String location;
  DateTime checkIn;
  DateTime checkOut;

  Booking({
    this.name,
    this.location,
    this.checkIn,
    this.checkOut
  });
}