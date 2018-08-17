import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/Services/Bridge.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/UI/Shared/AhoySegmentedControl.dart';
import 'ListInteractorInterface.dart';
import 'MyTripsInteractor.dart';

class TripsScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(leading: _backButton(),),
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            TripList(),
            Positioned(
              bottom: 13.0,
              width: 190.0,
              height: 40.0,
              child: AhoySegmentedControl(segments:[
                AhoySegmentData(text: "Me", callback: () => print("Tapped: Me")),
                AhoySegmentData(text: "Everyone", callback: () => print("Tapped: Everyone"))
              ]),
            ),
          ],
        )
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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool isLoaded = false;
  ListInteractor myTrips;
  TripProvider tripProvider = TripProvider();

  @override void initState() {
    super.initState();
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
