import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import '../Shared/AhoyStyles.dart';
import '../Shared/AhoyWidgets.dart';
import 'TripCellFactory.dart';
import 'ListInteractorInterface.dart';

class MyTripsInteractor extends ListInteractor {
  final GlobalKey<AnimatedListState> listKey;
  static final _tripProvider = TripProvider();
  final List<Widget> _cells = _allCells();

  MyTripsInteractor({@required this.listKey});

  int count() {
    return _cells.length;
  }

  Widget buildRow(BuildContext context, int index, Animation<double> animation) {
    return _cells[index];
  }

  static _allCells() {
      List<Widget> widgets = [];
      widgets.add(_headerFor("Now", "12 March"));
      widgets.addAll(TripCellFactory.fromTrips(_tripProvider.tripsNow()));
      widgets.add(_headerFor("Later", ""));
      widgets.addAll(TripCellFactory.fromTrips(_tripProvider.tripsLater()));
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