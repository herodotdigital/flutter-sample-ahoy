import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

AhoyLocalizations l10n(BuildContext context) {
  return AhoyLocalizations.of(context);
}
AhoyLocalizations l10nGlobal() {
  return AhoyLocalizations.sharedInstance;
}

class AhoyLocalizations {
  static final sharedInstance = AhoyLocalizations(); //for usage when build context is unavailable

  static Future<AhoyLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AhoyLocalizations();
    });
  }

  static AhoyLocalizations of(BuildContext context) {
    return Localizations.of<AhoyLocalizations>(context, AhoyLocalizations);
  }

  //App title
  String get ahoySample => Intl.message('Ahoy Sample', desc: 'Button on segmented control');

  //Segmented control
  String get me => Intl.message('Me', desc: 'Button on segmented control');
  String get everyone => Intl.message('Everyone', desc: 'Button on segmented control');

  //Time
  String get today => Intl.message('Today', desc: '');
  String get tomorrow => Intl.message('Tomorrow', desc: '');
  String get past => Intl.message('Past', desc: '');
  String inEta(String eta) => Intl.message("in $eta", args: [eta], desc: '');
  String nDays(int days) => Intl.message("$days d", args: [days], desc: '');
  String nHours(int hours) => Intl.message("$hours h", args: [hours], desc: '');
  String nMinutes(int minutes) => Intl.message("$minutes min", args: [minutes], desc: '');
  String nMinutesPlural(int howMany) => Intl.message("${Intl.plural(howMany, one: "$howMany min", other: "$howMany mins")}", args: [howMany]);

  // Details
  String get bookingReference => Intl.message('Booking reference', desc: '');
  String get ticketNumber => Intl.message('Ticket number', desc: '');
  String get flightNumber => Intl.message('Flight number', desc: '');
  String get seat => Intl.message('Seat', desc: '');
  String get terminal => Intl.message('Terminal', desc: '');
  String get gate => Intl.message('Gate', desc: '');
  String get showEntireBooking => Intl.message('Show entire booking', desc: '');
  String get showBoardingPass => Intl.message('Show boarding pass', desc: '');

  // Cells
  String get departure => Intl.message('Departure', desc: '');
  String get gateClose => Intl.message('Gate closes', desc: '');
  String nNightsStay(int howMany) => Intl.message("${Intl.plural(howMany, one: "$howMany night stay", other: "$howMany nights stay")}", args: [howMany]);
  String get checkIn => Intl.message('Check in after', desc: '');

  // Trip sections
  String get now => Intl.message('Now', desc: '');
  String get later => Intl.message('Later', desc: '');
  String get approvals => Intl.message('Approvals', desc: '');
  String get trips => Intl.message('Trips', desc: '');

  // Stub alert
  String get stubBookingsText => Intl.message('Bookings are not implemented in this demo.');
  String get stubBoardingPassText => Intl.message('Boarding pass is not implemented in this demo.');
  String get stubOk => Intl.message('Ok');
}

class AhoyLocalizationsDelegate extends LocalizationsDelegate<AhoyLocalizations> {
  const AhoyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AhoyLocalizations> load(Locale locale) => AhoyLocalizations.load(locale);

  @override
  bool shouldReload(AhoyLocalizationsDelegate old) => false;
}