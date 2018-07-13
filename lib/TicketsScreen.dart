import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/AhoyCell.dart';

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
    List<AhoyCellData> data = [AhoyCellData(),AhoyCellData()];
    List<Widget> widgets = [];
    for (var item in data) {
      AhoyCell cell = AhoyCell();
      widgets.add(cell);
    }
    return widgets;
  }
}