import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/AhoyCellMockData.dart';
import 'package:ahoy_sample/AhoyStyles.dart';
import 'package:ahoy_sample/AhoyWidgets.dart';
import 'package:ahoy_sample/Bridge.dart';

class TicketsScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(leading: _backButton(),),
      child: SafeArea(
        child: TicketList(),
        ),
    );
  }

  _backButton() {
    return CupertinoButton(
      child: Icon(CupertinoIcons.back),
      onPressed: (){
        Bridge().dismiss();
      },
    );
  }
}

class TicketList extends StatefulWidget {
  @override _TicketListState createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> with WidgetsBindingObserver {
  
  bool isLoaded = false;

  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !isLoaded) {
      isLoaded = true;
      _hideSplash();
    }
  }

  void _hideSplash() {
    Bridge().viewReady();
  }

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
        Text(title, style: AhoyStyles.list.titleStyle,),
        AhoyWidgets.flexibleSpace(),
        Text(date, style: AhoyStyles.list.headerDetailsStyle,),
      ],),
    );
  }
}
