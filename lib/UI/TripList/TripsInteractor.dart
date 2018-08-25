import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/UI/TripList/TripCellData.dart';
import 'TripHeader.dart';
import 'TripCell.dart';
import 'TripCellFactory.dart';
import 'TripsSectionBuilder.dart';
import 'package:flutter/cupertino.dart';
import '../FlightDetails/FlightDetailsScreen.dart';
import '../FlightDetails/FlightDetailsDataFactory.dart';
import 'package:ahoy_sample/UI/Shared/TableSection.dart';
import 'package:ahoy_sample/l10n/AhoyLocalizations.dart';

class TripsInteractor {
  final GlobalKey<AnimatedListState> listKey;
  final TripProvider tripProvider;
  List<TableSection<TripHeaderData,TripCellData,Widget>> sections;
  final TripsSectionBuilder sectionBuilder;


  TripsInteractor({
    @required this.listKey,
    @required this.tripProvider,
    @required this.sectionBuilder,
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

  _reloadSections() {
    sections = null;
    _prepareSectionsIfNeeded();
  }

  _prepareSectionsIfNeeded() {
    if (sections != null) {
      return;
    }
    List<TripCellData> viewModels = _allViewmodels();
    sections = sectionBuilder.buildSectionsFrom(viewModels);
  }
  
  List<TripCellData> _allViewmodels() {
    final trips = tripProvider.allTrips();
    var cellDatas = TripCellFactory.cellDataListFrom(trips);
    return cellDatas;
  }

  Widget _widgetFor(BuildContext context, int globalIndex, Animation<double> animation) {
    int indexLeft = globalIndex;
    for (var i = 0; i < sections.length; i++) {
      Widget potentialWidget = sections[i].query(indexLeft, (TableSectionElement type, TripHeaderData headerData, TripCellData rowData){
        if (type == TableSectionElement.row) {
          rowData.indexInTable = globalIndex;
        }
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

  AnimatedListState get _animatedList => listKey.currentState;

  Widget _createTripCell(BuildContext context, TripCellData data, Animation<double> animation) {
    data.onTap = () => _handleTap(data, context);
    Function removeCellAction = () {
      switch (data.type) {
        case TripCellType.flight:
          tripProvider.removeFlight(tripId: data.tripId);
          break;
        case TripCellType.booking:
          tripProvider.removeBooking(tripId: data.tripId);
          break;
        default:
      }
      _reloadSections();
      _animatedList.removeItem(data.indexInTable, (BuildContext context, Animation<double> animation){
        return TripCell(data: data, animation: animation, interactive: false);
      });
    };
    data.onApprove = removeCellAction;
    data.onDismiss = removeCellAction;
    return TripCell(data: data, animation: animation);
  }

  _handleTap(TripCellData data, BuildContext context) {
    if (data.type == TripCellType.flight) {
      _pushDetails(data, context);
    } else {
      _showStub(title: l10n(context).stubBookingsText, context: context);
    }
  }

  _showStub({String title, BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        actions: <Widget>[
          new CupertinoDialogAction(
            child: Text(l10n(context).stubOk),
            isDestructiveAction: false,
            onPressed: () => Navigator.pop(context, 'Discard'),
          ),
        ],
      ),
    );
  }

  _pushDetails(TripCellData data, BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) => _createDetailsScreen(data),
      )
    );
  }

  Widget _createDetailsScreen(TripCellData inData) {
    switch (inData.type) {
      case TripCellType.flight:
        final trip = tripProvider.tripForId(inData.tripId);
        final flightData = FlightDetailsDataFactory.fromTrip(trip);
        return FlightDetailsScreen(flightData);
      case TripCellType.booking:
        print("Tapped Booking");
        break;
    }
  }

}