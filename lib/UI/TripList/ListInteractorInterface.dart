import 'package:flutter/material.dart';
// import 'package:ahoy_sample/Services/TripProvider.dart'; // TODO: Uset trip provider in constructor

abstract class ListInteractor {
  int count();
  Widget buildRow(BuildContext context, int index, Animation<double> animation);
}