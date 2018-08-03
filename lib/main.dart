import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/UI/TripList/TripsScreen.dart';

void main() {
  runApp(new AhoyApp());
}

class AhoyApp extends MaterialApp {
  AhoyApp() : super(
    title: "Ahoy Sample",
    theme: new ThemeData(primarySwatch: Colors.blue),
    home: new TripsScreen(),
  );
}