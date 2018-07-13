import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/AhoyCell.dart';
import 'package:ahoy_sample/AhoyCellMockData.dart';
import 'package:ahoy_sample/AhoyStyles.dart';

class TicketsScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return new CupertinoPageScaffold(
      navigationBar: new CupertinoNavigationBar(leading: Icon(CupertinoIcons.back),),
      child: SafeArea(
        child: TicketList(),
        ),
    );
  }
}

class TicketList extends StatefulWidget {
  TicketList({Key key}) : super(key: key);

  @override State<StatefulWidget> createState() {
      return _TicketListState();
    }
}

class _TicketListState extends State<TicketList> {
  @override Widget build(BuildContext context) {
    return new Material(
        child: ListView(
        children: _getListData(),
      )
    );
  }

  _getListData() {
      List<Widget> widgets = [];
      widgets.add(_headerFor("Now", "12 March"));
      for (var item in AhoyCellMockData.now()) {
        widgets.add(AhoyCell(item));
      }
      widgets.add(_headerFor("Later", ""));
      for (var item in AhoyCellMockData.later()) {
        widgets.add(AhoyCell(item));
      }
      return widgets;
    }

  _headerFor(String title, String date) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: Row(
      children: <Widget>[
        Text(title, style: AhoyStyles.titleStyle,),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(date, style: AhoyStyles.headerDetailsStyle,)
            ],
          ),
        )
      ],
    ),
    );
  }
}