import 'package:ahoy_sample/l10n/AhoyLocalizations.dart';

class FlightDetailsLocalization {
  final String bookingReference;
  final String ticketNumber;
  final String flightNumber;
  final String seat;
  final String terminal;
  final String gate;
  final String showEntireBooking;
  final String showBoardingPass;

  const FlightDetailsLocalization({
    this.bookingReference,
    this.ticketNumber,
    this.flightNumber,
    this.seat,
    this.terminal,
    this.gate,
    this.showEntireBooking,
    this.showBoardingPass,
  });

  static FlightDetailsLocalization createEng() {
    return FlightDetailsLocalization(
      bookingReference: "${l10nGlobal().bookingReference}:",
      ticketNumber: "${l10nGlobal().ticketNumber}:",
      flightNumber: l10nGlobal().flightNumber,
      seat: l10nGlobal().seat,
      terminal: l10nGlobal().terminal,
      gate: l10nGlobal().gate,
      showEntireBooking: l10nGlobal().showEntireBooking,
      showBoardingPass: l10nGlobal().showBoardingPass,
    );
  }
}

class FlightDetailsData {
  final String bookingReferenceValue;
  final String ticketNumberValue;
  final String departureTime;
  final String departureDate;
  final String departureLocationTitle;
  final String departureLocationSubtitle;
  final String travelTime;
  final String flightNumberValue;
  final String seatValue;
  final String terminalValue;
  final String gateValue;
  final String arrivalTime;
  final String arrivalDate;
  final String arrivalLocationTitle;
  final String arrivalLocationSubtitle;

  const FlightDetailsData({
    this.bookingReferenceValue,
    this.ticketNumberValue,
    this.departureTime,
    this.departureDate,
    this.departureLocationTitle,
    this.departureLocationSubtitle,
    this.travelTime,
    this.flightNumberValue,
    this.seatValue,
    this.terminalValue,
    this.gateValue,
    this.arrivalTime,
    this.arrivalDate,
    this.arrivalLocationTitle,
    this.arrivalLocationSubtitle,
  });

  static FlightDetailsData stub() {
    return FlightDetailsData(
      bookingReferenceValue: "NLJP6T (BA)",
      ticketNumberValue: "125-5328235118",
      departureTime: "9:50",
      departureDate: "Tue, 22 Feb",
      departureLocationTitle: "WAW",
      departureLocationSubtitle: "Warsaw Chopin Airport",
      travelTime: "1 h 10 min",
      flightNumberValue: "FR8406",
      seatValue: "13C",
      terminalValue: "A",
      gateValue: "12",
      arrivalTime: "11:00",
      arrivalDate: "Tue, 22 Feb",
      arrivalLocationTitle: "CPH",
      arrivalLocationSubtitle: "Copenhagen Airport",);
  }
}