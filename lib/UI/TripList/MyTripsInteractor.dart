import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'ListInteractorInterface.dart';

class MyTripsInteractor extends ListInteractor {
  final GlobalKey<AnimatedListState> listKey;
  final TripProvider tripProvider;
  

  MyTripsInteractor({
    @required this.listKey,
    @required this.tripProvider,
  });

  int count() {
    return 0;
  }

  Widget buildRow(BuildContext context, int index, Animation<double> animation) {
    return null;
  }
}