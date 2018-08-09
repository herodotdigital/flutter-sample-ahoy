import 'package:ahoy_sample/Models/Flight.dart';
import 'package:ahoy_sample/Models/Booking.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';

class TripCellData {
  int tripId = 0;
  String title;
  String subtitle;
  String iconName;
  String topRightText;
  String bottomRightCaption;
  String bottomRightValue;
  String bottomLeftCaption;
  String bottomLeftValue;
  DateTime sortingDate;

  TripCellData({
    this.title,
    this.subtitle,
    this.iconName,
    this.topRightText,
    this.bottomRightCaption,
    this.bottomRightValue,
    this.bottomLeftCaption,
    this.bottomLeftValue,
    this.sortingDate,
    });

    TripCellData.withFlight(Flight flight, int tripId) {
      this.tripId = tripId;
      this.title = "${flight.from.code.toUpperCase()} - ${flight.to.code.toUpperCase()}";
      this.subtitle = flight.from.fullName;
      this.iconName = "assets/images/planeGray.png";
      this.topRightText = DateHelper.when(flight.departureTime);
      this.bottomRightCaption = _FlightCaptions.gateClose;
      this.bottomRightValue = DateHelper.clock(flight.gateClose);
      this.bottomLeftCaption = _FlightCaptions.departure;
      this.bottomLeftValue = DateHelper.clock(flight.departureTime);
      this.sortingDate = flight.departureTime;
    }

    TripCellData.withBooking(Booking booking, int tripId) {
      this.tripId = tripId;
      this.title = _howLong(booking);
      this.subtitle = "${booking.location}, ${booking.name}";
      this.iconName = "assets/images/hotelGray.png";
      this.topRightText = DateHelper.when(booking.checkIn);
      this.bottomRightCaption = _BookingCaptions.checkIn;
      this.bottomRightValue = DateHelper.clock(booking.checkIn);
      this.bottomLeftCaption = "";
      this.bottomLeftValue = "";
      this.sortingDate = booking.checkIn;
    }

    String _howLong(Booking booking) {
      final days = DateHelper.howManyDays(booking.checkIn, booking.checkOut);
      return "$days ${_BookingCaptions.nightStay}";
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