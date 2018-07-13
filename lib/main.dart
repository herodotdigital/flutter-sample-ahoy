import 'package:flutter/material.dart';
import 'package:ahoy_sample/TicketsScreen.dart';

void main() {
  runApp(new MaterialApp(
    title: "Ahoy Sample",
    theme: new ThemeData(primarySwatch: Colors.blue),
    home: new TicketsScreen(),
  ));
}