import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/AhoyCellMockData.dart';
import 'package:ahoy_sample/AhoyStyles.dart';
import 'package:ahoy_sample/AhoyWidgets.dart';

class TicketsScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(leading: Icon(CupertinoIcons.back),),
      child: SafeArea(
        child: TicketList(),
        ),
    );
  }
}

class TicketList extends StatelessWidget {
  
  @override Widget build(BuildContext context) {
    return Material(
        child: ListView(
        children: _allCells(),
    ));
  }

  _allCells() {
      List<Widget> widgets = [];
      widgets.add(_headerFor("Now", "12 March"));
      widgets.addAll(AhoyCellMockData.nowCells());
      widgets.add(_headerFor("Later", ""));
      widgets.addAll(AhoyCellMockData.laterCells());
      return widgets;
    }

  _headerFor(String title, String date) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: Row(children: <Widget>[
        Text(title, style: AhoyStyles.titleStyle,),
        AhoyWidgets.flexibleSpace(),
        Text(date, style: AhoyStyles.headerDetailsStyle,),
      ],),
    );
  }
}