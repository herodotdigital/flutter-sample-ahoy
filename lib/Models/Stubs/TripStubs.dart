import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Flight.dart';
import 'package:ahoy_sample/Models/Booking.dart';

class TripStubs {
  static int nextId = 1;
  static Trip stubTodayTrip() {
    return Trip(
      id: nextId++,
      flight: Flight(
        gateClose: _today(8, 5),
        departureTime: _today(8, 15),
        arrivalTime: _today(8, 35),
        flightNumber: "FR8406",
        seat: "13C",
        terminal: "A",
        gate: "12",
        from: Airport(code: "wro", fullName: "Wroclaw City Airport"),
        to: Airport(code: "waw", fullName: "Warsaw Chopin Airport"),
      ),
      booking: Booking(
        checkIn: _today(13, 0),
        checkOut: _createTime(hour: 10, minute: 0, daysLater: 2),
        location: "Warsaw",
        name: "Doubletree by Hilton",
      ),
    );
  }

  static Trip stubLaterTrip() {
    return Trip(
      flight: Flight(
        gateClose: _createTime(hour: 8, minute: 5, daysLater: 30),
        departureTime: _createTime(hour: 8, minute: 15, daysLater: 30),
        arrivalTime: _createTime(hour: 8, minute: 35, daysLater: 30),
        flightNumber: "FR8305",
        seat: "15A",
        terminal: "B",
        gate: "9",
        from: Airport(code: "waw", fullName: "Warsaw"),
        to: Airport(code: "bcn", fullName: "Barcelona"),
      ),
      booking: Booking(
        checkIn: _createTime(hour: 12, minute: 0, daysLater: 30),
        checkOut: _createTime(hour: 9, minute: 0, daysLater: 31),
        location: "Barcelona",
        name: "Some Apartments",
      ),
    );
  }

  static DateTime _today(int hour, int minute) {
    final now = DateTime.now();
    return DateTime.utc(now.year, now.month, now.day, 8, 15);
  }

  static DateTime _createTime({int hour, int minute, int daysLater}) {
    var output = _today(hour, minute);
    if (daysLater > 0) {
      output = output.add(Duration(days: daysLater));
    }
    return output;
  }
}