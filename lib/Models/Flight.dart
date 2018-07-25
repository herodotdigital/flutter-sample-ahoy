class Flight {
  Airport from;
  Airport to;
  DateTime gateClose;
  DateTime departureTime;
  DateTime arrivalTime;
  String flightNumber;
  String seat;
  String terminal;
  String gate;

  Flight({
    this.from,
    this.to,
    this.gateClose,
    this.departureTime,
    this.arrivalTime,
    this.flightNumber,
    this.seat,
    this.terminal,
    this.gate,
  });
}

class Airport {
  String code;
  String fullName;

  Airport({
    this.code, 
    this.fullName
  });
}