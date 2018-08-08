import 'package:flutter/material.dart';

abstract class ListInteractor {
  int count();
  Widget buildRow(BuildContext context, int index, Animation<double> animation);
}