import 'package:flutter/material.dart';
import 'package:ahoy_sample/UI/Shared/TableSection.dart';
import 'TripCellData.dart';
import 'TripHeader.dart';
import 'package:ahoy_sample/Helpers/DateHelper.dart';
import 'package:ahoy_sample/l10n/AhoyLocalizations.dart';

abstract class TripsSectionBuilder {
  List<TableSection<TripHeaderData,TripCellData,Widget>> buildSectionsFrom(List<TripCellData> viewModels);
}

class MyTripsSectionBuilder extends TripsSectionBuilder {
  @override List<TableSection<TripHeaderData, TripCellData, Widget>> buildSectionsFrom(List<TripCellData> viewModels) {
    final todayModels = viewModels.where((m) => _isWithin24hPredicate(m)).toList();
    final laterModels = viewModels.where((m) => !_isWithin24hPredicate(m)).toList();
    final when = DateHelper.formatted(format: "d MMMM", date: DateTime.now());
    final nowSection = _createSection(headerText: l10nGlobal().now, detailText: when, viewModels: todayModels);
    final laterSection = _createSection(headerText: l10nGlobal().later, viewModels: laterModels);
    return [nowSection, laterSection];
  }

  bool _isWithin24hPredicate(TripCellData model) {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return model.sortingDate.isBefore(tomorrow);
  }

  TableSection<TripHeaderData,TripCellData,Widget> _createSection({@required List<TripCellData> viewModels, @required String headerText, String detailText,}) {
    final header = (viewModels.length > 0) ? TripHeaderData(title: headerText, details: detailText) : null;
    return TableSection<TripHeaderData,TripCellData,Widget>(headerData: header, rows: viewModels);
  }

}

class EveryoneTripsSectionBuilder extends MyTripsSectionBuilder {
  @override List<TableSection<TripHeaderData, TripCellData, Widget>> buildSectionsFrom(List<TripCellData> viewModels) {
    final modelsToApprove = viewModels.where((m) => _needsApprovalPredicate(m)).toList();
    final otherModels = viewModels.where((m) => !_needsApprovalPredicate(m)).toList();
    final when = DateHelper.formatted(format: "d MMMM", date: DateTime.now());
    final toApproveSection = _createSection(headerText: l10nGlobal().approvals, detailText: when, viewModels: modelsToApprove);
    final otherSection = _createSection(headerText: l10nGlobal().trips, viewModels: otherModels);
    return [toApproveSection, otherSection];
  }

  bool _needsApprovalPredicate(TripCellData model) {
    return model.swipeable;
  }
}