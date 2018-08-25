import '../Trip.dart';
import '../Flight.dart';
import '../Booking.dart';
import '../Person.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';
import 'package:meta/meta.dart';

class TripStubs {
  static List<Trip> stubMyTrips() {
    return [
      stubTodayTrip(id: 1),
      stubLaterTrip(id: 2),
    ];
  }

  static List<Trip> stubEveryoneTrips() {
    return [
      stubJohnTrip(id:3),
      stubLukaTrip(id:4),
    ];
  }

  static Trip stubTodayTrip({@required int id}) {
    return Trip(
      id: id,
      needsApproval: true,
      flight: Flight(
        gateClose: DateHelper.after(minutes: 5),
        departureTime: DateHelper.after(minutes: 15),
        arrivalTime: DateHelper.after(hours: 1, minutes: 25),
        flightNumber: "FR8406",
        seat: "13C",
        terminal: "A",
        gate: "12",
        from: Airport(code: "wro", fullName: "Wroclaw City Airport"),
        to: Airport(code: "waw", fullName: "Warsaw Chopin Airport"),
      ),
      booking: Booking(
        checkIn: DateHelper.after(hours: 3),
        checkOut: DateHelper.after(hours: 4, days: 2),//_createTime(hour: 10, minute: 0, daysLater: 2),
        location: "Warsaw",
        name: "Doubletree by Hilton",
      ),
    );
  }

  static Trip stubLaterTrip({@required int id, bool appendId = false}) {
    final int daysLater = 30 + ( appendId ? id : 0);
    return Trip(
      id: id,
      needsApproval: true,
      flight: Flight(
        gateClose: _createTime(hour: 8, minute: 5, daysLater: daysLater),
        departureTime: _createTime(hour: 8, minute: 15, daysLater: daysLater),
        arrivalTime: _createTime(hour: 8, minute: 35, daysLater: daysLater),
        flightNumber: "FR8305",
        seat: "15A",
        terminal: "B",
        gate: "9",
        from: Airport(code: "waw", fullName: "Warsaw"),
        to: Airport(code: "bcn", fullName: "Barcelona"),
      ),
      booking: Booking(
        checkIn: _createTime(hour: 12, minute: 0, daysLater: daysLater),
        checkOut: _createTime(hour: 9, minute: 0, daysLater: daysLater+1),
        location: "Barcelona",
        name: "Some Apartments",
      ),
    );
  }

  static Trip stubJohnTrip({@required int id, bool appendId = false}) {
    final int daysLater = 0 + ( appendId ? id : 0);
    return Trip(
      id: id,
      needsApproval: true,
      flight: Flight(
        gateClose: DateHelper.after(days: daysLater, minutes: 5),
        departureTime: DateHelper.after(days: daysLater, minutes: 15),
        arrivalTime: DateHelper.after(days: daysLater, hours: 1, minutes: 25),
        flightNumber: "FR8406",
        seat: "13C",
        terminal: "A",
        gate: "12",
        from: Airport(code: "wro", fullName: "Wroclaw City Airport"),
        to: Airport(code: "waw", fullName: "Warsaw Chopin Airport"),
      ),
      booking: Booking(
        checkIn: _createTime(hour: 12, minute: 0, daysLater: daysLater+1),
        checkOut: _createTime(hour: 9, minute: 0, daysLater: daysLater+2),
        location: "Warsaw",
        name: "Doubletree by Hilton",
      ),
      person: Person(name:"John", surname:"Smith"),
    );
  }

  static Trip stubLukaTrip({@required int id}) {
    return Trip(
      id: id,
      needsApproval: false,
      flight: Flight(
        gateClose: DateHelper.after(minutes: 5),
        departureTime: DateHelper.after(minutes: 15),
        arrivalTime: DateHelper.after(hours: 1, minutes: 25),
        flightNumber: "FR8305",
        seat: "15A",
        terminal: "B",
        gate: "9",
        from: Airport(code: "waw", fullName: "Warsaw"),
        to: Airport(code: "bcn", fullName: "Barcelona"),
      ),
      booking: Booking(
        checkIn: _createTime(hour: 12, minute: 0, daysLater: 1),
        checkOut: _createTime(hour: 9, minute: 0, daysLater: 2),
        location: "Barcelona",
        name: "Some Apartments",
      ),
      person: Person(name:"Luka", surname:"Modric"),
    );
  }

  static DateTime _createTime({int hour, int minute, int daysLater}) {
    var output = DateHelper.today(hour, minute);
    if (daysLater > 0) {
      output = output.add(Duration(days: daysLater));
    }
    return output;
  }
}