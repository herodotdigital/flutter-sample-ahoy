import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/Bridge.dart';
import 'package:ahoy_sample/TicketDetailsData.dart';
import 'package:ahoy_sample/AhoyStyles.dart';

class TicketDetailsScreen extends StatelessWidget {
  final TicketDetailsData detailsData;

  TicketDetailsScreen(this.detailsData);

  @override Widget build(BuildContext context) {
    final navbarTitle = "${detailsData.departureLocationTitle} - ${detailsData.arrivalLocationTitle}";
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: _backButton(),
        middle: Text(navbarTitle),
        ),
      child: SafeArea(
        child: TicketDetails(detailsData),
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


class TicketDetails extends StatelessWidget {
  final captions = TicketDetailsLocalization.createEng();
  final TicketDetailsData data;

  TicketDetails(this.data);

  @override Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _referenceRow(),
    ],);
  }

  _referenceRow() {
    return Row(children: <Widget>[
      Column(children: <Widget>[
        Text(captions.bookingReference),
        Text(data.bookingReferenceValue),
      ],),
      Column(children: <Widget>[
        Text(captions.ticketNumber),
        Text(data.ticketNumberValue),
      ],),
    ],);
  }

}