import 'package:ahoy_sample/Models/Flight.dart';
import 'package:ahoy_sample/Models/Booking.dart';

class AhoyCellData {
  String title;
  String subtitle;
  String iconName;
  String topRightText;
  String bottomRightCaption;
  String bottomRightValue;
  String bottomLeftCaption;
  String bottomLeftValue;

  AhoyCellData({
    this.title,
    this.subtitle,
    this.iconName,
    this.topRightText,
    this.bottomRightCaption,
    this.bottomRightValue,
    this.bottomLeftCaption,
    this.bottomLeftValue,
    });

    AhoyCellData.withFlight(Flight flight) {
      this.title = "${flight.from.code.toUpperCase()} - ${flight.to.code.toUpperCase()}";
      this.subtitle = flight.from.fullName;
      this.iconName = "assets/images/planeGray.png";
      this.topRightText = _when(flight.departureTime);
      this.bottomRightCaption = _FlightCaptions.gateClose;
      this.bottomRightValue = _clock(flight.gateClose);
      this.bottomLeftCaption = _FlightCaptions.departure;
      this.bottomLeftValue = _clock(flight.departureTime);
    }

    AhoyCellData.withBooking(Booking booking) {
      this.title = _howLong(booking);
      this.subtitle = "${booking.location}, ${booking.name}";
      this.iconName = "assets/images/hotelGray.png";
      this.topRightText = _when(booking.checkIn);
      this.bottomRightCaption = _BookingCaptions.checkIn;
      this.bottomRightValue = _clock(booking.checkIn);
      this.bottomLeftCaption = "";
      this.bottomLeftValue = "";
    }

    String _when(DateTime time) {
      // TODO: proper implementation
      return "in 30 mins";
    }

    String _clock(DateTime time) {
      // TODO: proper implementation using Intl package
      return "${time.hour}:${time.minute}";
    }

    String _howLong(Booking booking) {
      // TODO: fix edge cases
      final days = booking.checkOut.difference(booking.checkIn).inDays;
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