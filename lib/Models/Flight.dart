class Flight {
  Airport from;
  Airport to;
  DateTime gateClose;
  DateTime departureTime;
  DateTime arrivalTime;

  Flight({
    this.from,
    this.to,
    this.gateClose,
    this.departureTime,
    this.arrivalTime,
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