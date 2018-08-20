import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/Services/Bridge.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/UI/Shared/AhoySegmentedControl.dart';
import 'MyTripsInteractor.dart';

enum _Mode {
  me, everyone
}

class TripsScreen extends StatefulWidget {
  @override State<StatefulWidget> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> with WidgetsBindingObserver {
  _Mode _mode = _Mode.me;
  bool isLoaded = false;
  final GlobalKey<AnimatedListState> _meKey = GlobalKey<AnimatedListState>();
  final GlobalKey<AnimatedListState> _everyoneKey = GlobalKey<AnimatedListState>();
  final TripProvider _meTripProvider = TripProvider();
  final TripProvider _everyoneTripProvider = TripProvider();
  MyTripsInteractor _meTripInteractor;
  MyTripsInteractor _everyoneTripInteractor;

  @override void initState() {
    WidgetsBinding.instance.addObserver(this);
    _meTripInteractor = MyTripsInteractor(listKey: _meKey, tripProvider: _meTripProvider);
    _everyoneTripInteractor = MyTripsInteractor(listKey: _everyoneKey, tripProvider: _everyoneTripProvider);
    super.initState();
  }

  @override void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !isLoaded) {
      isLoaded = true;
      _hideSplash();
    }
  }

  void _hideSplash() {
    Bridge().viewReady();
  }

  @override Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(leading: _backButton(),),
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            _listForCurrentMode(),
            Positioned(
              bottom: 13.0,
              width: 190.0,
              height: 40.0,
              child: AhoySegmentedControl(segments:[
                AhoySegmentData(text: "Me", callback: () => _switchModeTo(_Mode.me)),
                AhoySegmentData(text: "Everyone", callback: () => _switchModeTo(_Mode.everyone))
              ]),
            ),
          ],
        )
      ),
    );
  }

  _switchModeTo(_Mode mode) {
    setState(() {
      this._mode = mode;
    });
  }

  Widget _listForCurrentMode() {
    MyTripsInteractor anInteractor;
    GlobalKey aKey;
    switch (_mode) {
      case _Mode.me:
        anInteractor = _meTripInteractor;
        aKey = _meKey;
        break;
      case _Mode.everyone:
        anInteractor = _everyoneTripInteractor;
        aKey = _everyoneKey;
        break;
    }
    return Material(
        child: AnimatedList(
          key: aKey,
          initialItemCount: anInteractor.count(),
          itemBuilder: anInteractor.buildRow,
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