import 'package:flutter/material.dart';
import 'package:ahoy_sample/Models/Stubs/TripStubs.dart';
import '../Shared/AhoyStyles.dart';
import '../Shared/AhoyWidgets.dart';
import 'TripCellFactory.dart';
import 'ListInteractorInterface.dart';

class LegacyTripsInteractor extends ListInteractor {
  final GlobalKey<AnimatedListState> listKey;
  final List<Widget> _cells = _allCells();

  LegacyTripsInteractor({@required this.listKey});

  int count() {
    return _cells.length;
  }

  Widget buildRow(BuildContext context, int index, Animation<double> animation) {
    return _cells[index];
  }

  static _allCells() {
      List<Widget> widgets = [];
      widgets.add(_headerFor("Now", "12 March"));
      widgets.addAll(TripCellFactory.fromTrips([TripStubs.stubTodayTrip(id: 1)]));
      widgets.add(_headerFor("Later", ""));
      widgets.addAll(TripCellFactory.fromTrips([TripStubs.stubLaterTrip(id: 2)]));
      return widgets;
    }

  static _headerFor(String title, String date) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: Row(children: <Widget>[
        Text(title, style: AhoyStyles.list.titleStyle,),
        AhoyWidgets.flexibleSpace(),
        Text(date, style: AhoyStyles.list.headerDetailsStyle,),
      ],),
    );
  }
}