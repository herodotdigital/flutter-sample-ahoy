import 'package:ahoy_sample/Models/Flight.dart';
import 'package:ahoy_sample/Models/Booking.dart';
import 'package:ahoy_sample/Models/Person.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';

enum TripCellType {
  flight, booking
}

class TripCellData {
  int tripId = 0;
  TripCellType type;
  String title;
  String subtitle1;
  String subtitle2; //second line
  String iconName;
  String topRightText;
  String bottomRightCaption;
  String bottomRightValue;
  String bottomLeftCaption;
  String bottomLeftValue;
  DateTime sortingDate;
  Function onTap;
  Function onApprove;
  Function onDismiss;
  int indexInTable;

  TripCellData({
    this.type,
    this.title,
    this.subtitle1,
    this.subtitle2,
    this.iconName,
    this.topRightText,
    this.bottomRightCaption,
    this.bottomRightValue,
    this.bottomLeftCaption,
    this.bottomLeftValue,
    this.sortingDate,
    });

    TripCellData.withFlight(Flight flight, int tripId, Person person) {
      this.type = TripCellType.flight;
      this.tripId = tripId;
      if (person != null) {
        this.title = "${person.name} ${person.surname}";
        this.subtitle1 = "${flight.from.code.toUpperCase()} - ${flight.to.code.toUpperCase()}";
        this.subtitle2 = flight.from.fullName;
      } else {
        this.title = "${flight.from.code.toUpperCase()} - ${flight.to.code.toUpperCase()}";
        this.subtitle1 = flight.from.fullName;
      }
      this.iconName = "assets/images/planeGray.png";
      this.topRightText = DateHelper.when(flight.departureTime);
      this.bottomRightCaption = _FlightCaptions.gateClose;
      this.bottomRightValue = DateHelper.clock(flight.gateClose);
      this.bottomLeftCaption = _FlightCaptions.departure;
      this.bottomLeftValue = DateHelper.clock(flight.departureTime);
      this.sortingDate = flight.departureTime;
    }

    TripCellData.withBooking(Booking booking, int tripId, Person person) {
      this.type = TripCellType.booking;
      this.tripId = tripId;
      if (person != null) {
        this.title = "${person.name} ${person.surname}";
        this.subtitle1 = _howLong(booking);
        this.subtitle2 = "${booking.location}, ${booking.name}";
      } else {
        this.title = _howLong(booking);
        this.subtitle1 = "${booking.location}, ${booking.name}";
      }
      this.iconName = "assets/images/hotelGray.png";
      this.topRightText = DateHelper.when(booking.checkIn);
      this.bottomRightCaption = _BookingCaptions.checkIn;
      this.bottomRightValue = DateHelper.clock(booking.checkIn);
      this.bottomLeftCaption = "";
      this.bottomLeftValue = "";
      this.sortingDate = booking.checkIn;
    }

    String _howLong(Booking booking) {
      final days = DateHelper.howManyNights(booking.checkIn, booking.checkOut);
      return "$days ${_BookingCaptions.nightStay}";
    }

    String uniqueKey() {
      return "${tripId}_$type";
    }
}

class _FlightCaptions {
  static final departure = "Departure:";
  static final gateClose = "Gate closes:";
}

class _BookingCaptions {
  static final nightStay = "night stay";
  static final checkIn = "Check in after:";
}