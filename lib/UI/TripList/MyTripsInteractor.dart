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
import 'package:ahoy_sample/UI/Shared/TableSection.dart';

class MyTripsInteractor extends ListInteractor {
  final GlobalKey<AnimatedListState> listKey;
  final TripProvider tripProvider;
  List<TableSection<TripHeaderData,TripCellData,Widget>> sections;

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
    final nowSection = _createSection(headerText: "Now", detailText: when, viewModels: todayModels);
    final laterSection = _createSection(headerText: "Later", viewModels: laterModels);
    sections = [nowSection, laterSection];
  }

  bool _isWithin24hPredicate(TripCellData model) {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return model.sortingDate.isBefore(tomorrow);
  }

  TableSection<TripHeaderData,TripCellData,Widget> _createSection({@required List<TripCellData> viewModels, @required String headerText, String detailText,}) {
    final header = (viewModels.length > 0) ? TripHeaderData(title: headerText, details: detailText) : null;
    return TableSection<TripHeaderData,TripCellData,Widget>(headerData: header, rows: viewModels);
  }
  
  List<TripCellData> _allViewmodels() {
    final trips = tripProvider.allTrips();
    var cellDatas = TripCellFactory.cellDataListFrom(trips);

    return cellDatas;
  }

  Widget _widgetFor(BuildContext context, int index, Animation<double> animation) {
    int indexLeft = index;
    for (var i = 0; i < sections.length; i++) {
      Widget potentialWidget = sections[i].query(indexLeft, (TableSectionElement type, TripHeaderData headerData, TripCellData rowData){
        return _createWidget(type, headerData, rowData, context, animation);
      });
      if (potentialWidget != null) {
        return potentialWidget;
      }
      indexLeft -= sections[i].itemCount();
    }
    return null;
  }

  Widget _createWidget(TableSectionElement type, TripHeaderData headerData, TripCellData rowData, BuildContext context, Animation<double> animation) {
    switch (type) {
      case TableSectionElement.header:
        return TripHeader(data: headerData);
      case TableSectionElement.row:
        return _createTripCell(context, rowData, animation);
      default:
        return null;
    }
  }

  Widget _createTripCell(BuildContext context, TripCellData data, Animation<double> animation) {
    data.onTap = () => _pushDetails(data, context);
    data.onApprove = () {
      print("Approved");
    };
    data.onDismiss = () {
      print("Dismissed");
    };
    return TripCell(data: data, animation: animation);
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
        final trip = TripProvider().tripForId(inData.tripId);
        final flightData = FlightDetailsDataFactory.fromTrip(trip);
        return FlightDetailsScreen(flightData);
      case TripCellType.booking:
        print("Tapped Booking");
        break;
    }
  }

}