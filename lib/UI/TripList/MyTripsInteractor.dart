import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import 'package:ahoy_sample/UI/TripList/TripCellData.dart';
import 'TripHeader.dart';
import 'TripCell.dart';
import 'TripCellFactory.dart';
import 'ListInteractorInterface.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';

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

  Widget widgetFor({int index}) {
    assert(index >= 0);
    if (_hasHeader() && index == 0) {
      return TripHeader(title: headerText, details: headerDetails);
    } else {
      int shiftedIndex = _hasHeader() ? index - 1 : index;
      if (shiftedIndex < rows.length) {
        return TripCell(data: rows[shiftedIndex], onApprove: (){}, onDismiss: (){},);
      }
    }
    return null;
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
    _prepareIfNeeded();
    int sum = 0;
    for (var section in sections) {
      sum += section.itemCount();
    }
    return sum;
  }

  Widget buildRow(BuildContext context, int index, Animation<double> animation) {
    _prepareIfNeeded();
    return _widgetFor(index: index);
  }

  _prepareIfNeeded() {
    if (sections != null) {
      return;
    }
    List<TripCellData> viewModels = _allViewmodels();
    final todayModels = viewModels.where((m) => _isSameDayPredicate(m)).toList();
    final laterModels = viewModels.where((m) => !_isSameDayPredicate(m)).toList();
    _Section nowSection = createSection(headerText: "Now", detailText: "12 March", viewModels: todayModels);
    _Section laterSection = createSection(headerText: "Later", viewModels: laterModels);
    sections = [nowSection, laterSection];
  }

  bool _isSameDayPredicate(TripCellData model) {
    DateTime now = DateTime.now();
    return DateHelper.isSameDay(model.sortingDate, now);
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

  Widget _widgetFor({@required int index}) {
    int indexLeft = index;
    for (var i = 0; i < sections.length; i++) {
      Widget potentialWidget = sections[i].widgetFor(index: indexLeft);
      if (potentialWidget != null) {
        return potentialWidget;
      }
      indexLeft -= sections[i].itemCount();
    }
    return null;
  }
}