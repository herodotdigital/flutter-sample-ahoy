import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/Services/Bridge.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'ListInteractorInterface.dart';
import 'MyTripsInteractor.dart';

class TripsScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(leading: _backButton(),),
      child: SafeArea(
        // child: Padding(padding: EdgeInsets.only(top: 4.0), child: TripList(),), //uncommenting simulates android statusbar
        child: TripList(),
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

class TripList extends StatefulWidget {
  @override _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> with WidgetsBindingObserver {
  GlobalKey<AnimatedListState> _listKey;
  bool isLoaded = false;
  ListInteractor myTrips;
  TripProvider tripProvider = MyTripProvider();

  @override void initState() {
    super.initState();
    _listKey = GlobalKey<AnimatedListState>();
    myTrips = MyTripsInteractor(listKey: _listKey, tripProvider: tripProvider);
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
        child: AnimatedList(
          key: _listKey,
          initialItemCount: myTrips.count(),
          itemBuilder: myTrips.buildRow,
        ),
    );
  }
}
