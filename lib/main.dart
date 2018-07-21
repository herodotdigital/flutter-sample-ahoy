import 'package:flutter/material.dart';
import 'package:ahoy_sample/TicketsScreen.dart';
import 'package:ahoy_sample/TicketDetailsScreen.dart';
import 'package:ahoy_sample/TicketDetailsData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  final stub = TicketDetailsData.stub();
  runApp(new MaterialApp(
    title: "Ahoy Sample",
    theme: new ThemeData(primarySwatch: Colors.blue),
    // home: new TicketsScreen(),
    home: TicketDetailsScreen(stub),
  ));
}