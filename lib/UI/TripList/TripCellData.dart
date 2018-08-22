import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Models/Booking.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';
import 'package:ahoy_sample/l10n/AhoyLocalizations.dart';

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
  bool swipeable;

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
    this.swipeable,
    });

    TripCellData.forFlight(Trip trip) {
      this.type = TripCellType.flight;
      this.tripId = trip.id;
      if (trip.person != null) {
        this.title = "${trip.person.name} ${trip.person.surname}";
        this.subtitle1 = "${trip.flight.from.code.toUpperCase()} - ${trip.flight.to.code.toUpperCase()}";
        this.subtitle2 = trip.flight.from.fullName;
      } else {
        this.title = "${trip.flight.from.code.toUpperCase()} - ${trip.flight.to.code.toUpperCase()}";
        this.subtitle1 = trip.flight.from.fullName;
      }
      this.iconName = "assets/images/planeGray.png";
      this.topRightText = DateHelper.when(trip.flight.departureTime);
      this.bottomRightCaption = _FlightCaptions.gateClose;
      this.bottomRightValue = DateHelper.clock(trip.flight.gateClose);
      this.bottomLeftCaption = _FlightCaptions.departure;
      this.bottomLeftValue = DateHelper.clock(trip.flight.departureTime);
      this.sortingDate = trip.flight.departureTime;
      this.swipeable = trip.needsApproval;
    }

    TripCellData.forBooking(trip) {
      this.type = TripCellType.booking;
      this.tripId = trip.id;
      if (trip.person != null) {
        this.title = "${trip.person.name} ${trip.person.surname}";
        this.subtitle1 = _howLong(trip.booking);
        this.subtitle2 = "${trip.booking.location}, ${trip.booking.name}";
      } else {
        this.title = _howLong(trip.booking);
        this.subtitle1 = "${trip.booking.location}, ${trip.booking.name}";
      }
      this.iconName = "assets/images/hotelGray.png";
      this.topRightText = DateHelper.when(trip.booking.checkIn);
      this.bottomRightCaption = _BookingCaptions.checkIn;
      this.bottomRightValue = DateHelper.clock(trip.booking.checkIn);
      this.bottomLeftCaption = "";
      this.bottomLeftValue = "";
      this.sortingDate = trip.booking.checkIn;
      this.swipeable = trip.needsApproval;
    }

    String _howLong(Booking booking) {
      final nights = DateHelper.howManyNights(booking.checkIn, booking.checkOut);
      return l10nGlobal().nNightsStay(nights);
    }

    String uniqueKey() {
      return "${tripId}_$type";
    }
}

class _FlightCaptions {
  static final departure = "${l10nGlobal().departure}:";
  static final gateClose = "${l10nGlobal().gateClose}:";
}

class _BookingCaptions {
  static final checkIn = "${l10nGlobal().checkIn}:";
}