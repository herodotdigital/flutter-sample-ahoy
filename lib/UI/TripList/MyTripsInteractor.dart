import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/Models/Trip.dart';
import 'package:ahoy_sample/UI/TripList/TripCellData.dart';
import 'TripCell.dart';
import 'TripCellFactory.dart';
import 'ListInteractorInterface.dart';

class MyTripsInteractor extends ListInteractor {
  final GlobalKey<AnimatedListState> listKey;
  final TripProvider tripProvider;
  List<TripCellData> viewModels;

  MyTripsInteractor({
    @required this.listKey,
    @required this.tripProvider,
  });

  int count() {
    _prepareIfNeeded();
    return viewModels.length;
  }

  Widget buildRow(BuildContext context, int index, Animation<double> animation) {
    _prepareIfNeeded();
    if (viewModels.length == 0 || index >= viewModels.length) {
      return null;
    }
    return TripCell(data: viewModels[index], onApprove: (){}, onDismiss: (){},);
  }

  _prepareIfNeeded() {
    if (viewModels != null) {
      return;
    }
    final trips = tripProvider.allTrips();
    if (trips.length > 0) {
      viewModels = TripCellFactory.cellDataListFrom(trips);
    } else {
      viewModels = [];
    }
  }
}