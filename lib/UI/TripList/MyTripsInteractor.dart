import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/UI/TripList/TripCellData.dart';
import 'TripHeader.dart';
import 'TripCell.dart';
import 'TripCellFactory.dart';
import 'ListInteractorInterface.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';
import 'package:flutter/cupertino.dart';
import '../FlightDetails/FlightDetailsScreen.dart';
import '../FlightDetails/FlightDetailsDataFactory.dart';

class _Section {
  String headerText;
  String headerDetails;
  List<TripCellData> rows = [];

  int itemCount() {
    return rows.length + (_hasHeader() ? 1 : 0);
  }

  bool _hasHeader() {
    return headerText != null;
  }

  Widget widgetFor(BuildContext context, int index, Animation<double> animation) {
    assert(index >= 0);
    if (_hasHeader() && index == 0) {
      return TripHeader(title: headerText, details: headerDetails);
    } else {
      int shiftedIndex = _hasHeader() ? index - 1 : index;
      if (shiftedIndex < rows.length) {
        var data = rows[shiftedIndex];
        data.onTap = () => _pushDetails(data, context);
        data.onApprove = () {
          print("Approved");
        };
        data.onDismiss = () {
          print("Dismissed");
        };
        return TripCell(data: data, animation: animation);
      }
    }
    return null;
  }

  _pushDetails(TripCellData data, BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        builder: (BuildContext context) => _createDetailsScreen(data),
      )
    );
  }

  Widget _createDetailsScreen(TripCellData inData) {
    switch (inData.type) {
      case TripCellType.flight:
        final trip = MyTripProvider().tripForId(inData.tripId);
        final flightData = FlightDetailsDataFactory.fromTrip(trip);
        return FlightDetailsScreen(flightData);
      case TripCellType.booking:
        print("Tapped Booking");
        break;
    }
  }
}

class MyTripsInteractor extends ListInteractor {
  final GlobalKey<AnimatedListState> listKey;
  final TripProvider tripProvider;
  List<_Section> sections;

  MyTripsInteractor({
    @required this.listKey,
    @required this.tripProvider,
  });

  int count() {
    _prepareSectionsIfNeeded();
    int sum = 0;
    for (var section in sections) {
      sum += section.itemCount();
    }
    return sum;
  }

  Widget buildRow(BuildContext context, int index, Animation<double> animation) {
    _prepareSectionsIfNeeded();
    return _widgetFor(context,index,animation);
  }

  _prepareSectionsIfNeeded() {
    if (sections != null) {
      return;
    }
    List<TripCellData> viewModels = _allViewmodels();
    final todayModels = viewModels.where((m) => _isWithin24hPredicate(m)).toList();
    final laterModels = viewModels.where((m) => !_isWithin24hPredicate(m)).toList();
    final when = DateHelper.formatted(format: "d MMMM", date: DateTime.now());
    _Section nowSection = createSection(headerText: "Now", detailText: when, viewModels: todayModels);
    _Section laterSection = createSection(headerText: "Later", viewModels: laterModels);
    sections = [nowSection, laterSection];
  }

  bool _isWithin24hPredicate(TripCellData model) {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return model.sortingDate.isBefore(tomorrow);
  }

  _Section createSection({@required List<TripCellData> viewModels, @required String headerText, String detailText,}) {
    _Section newSection = _Section();
    newSection.rows = viewModels;
    if (newSection.rows.length > 0) {
      newSection.headerText = headerText;
      newSection.headerDetails = detailText;
    }
    return newSection;
  }
  
  List<TripCellData> _allViewmodels() {
    final trips = tripProvider.allTrips();
    return TripCellFactory.cellDataListFrom(trips);
  }

  Widget _widgetFor(BuildContext context, int index, Animation<double> animation) {
    int indexLeft = index;
    for (var i = 0; i < sections.length; i++) {
      Widget potentialWidget = sections[i].widgetFor(context, indexLeft, animation);
      if (potentialWidget != null) {
        return potentialWidget;
      }
      indexLeft -= sections[i].itemCount();
    }
    return null;
  }
}