import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';
import 'TicketDetailsData.dart';

class TicketDetailsDataFactory {
  static TicketDetailsData fromTrip(Trip trip) {
    final flight = trip.flight;
    return TicketDetailsData(
      bookingReferenceValue: "NLJP6T (BA)", // TODO: move this to proper model class
      ticketNumberValue: "125-5328235118", // TODO: move this to proper model class
      departureTime: DateHelper.clock(flight.departureTime),
      departureDate: DateHelper.localizedDate(flight.departureTime),
      departureLocationTitle: flight.from.code.toUpperCase(),
      departureLocationSubtitle: flight.from.fullName,
      travelTime: DateHelper.howLong(flight.departureTime, flight.arrivalTime),
      flightNumberValue: flight.flightNumber,
      seatValue: flight.seat,
      terminalValue: flight.terminal,
      gateValue: flight.gate,
      arrivalTime: DateHelper.clock(flight.arrivalTime),
      arrivalDate: DateHelper.localizedDate(flight.arrivalTime),
      arrivalLocationTitle: flight.to.code.toUpperCase(),
      arrivalLocationSubtitle: flight.to.fullName,
    );
  }
}