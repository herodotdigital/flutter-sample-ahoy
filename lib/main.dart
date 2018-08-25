import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/UI/TripList/TripsScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ahoy_sample/l10n/AhoyLocalizations.dart';
import 'package:ahoy_sample/Services/Bridge.dart';
import 'package:ahoy_sample/UI/Shared/DidAppear.dart';
import 'package:ahoy_sample/UI/Shared/AhoyStyles.dart';

void main() {
  runApp(AhoyApp());
}

class AhoyApp extends MaterialApp {
  AhoyApp() : super(
    title: l10nGlobal().ahoySample,
    localizationsDelegates: [
      const AhoyLocalizationsDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', 'US'),
    ],
    theme: new ThemeData(primarySwatch: Colors.blue),
    home: Container(
      color: AhoyColors.backgroundColor,
      child:DidAppear(
        fadeInDuration: 1, //one milisecond, simulates -viewDidAppear:
        onDidAppear: () => Bridge().viewReady(),
        child:TripsScreen(),
      )
    ),
  );
}
