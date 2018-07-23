import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ahoy_sample/Bridge.dart';
import 'package:ahoy_sample/TicketDetailsData.dart';
import 'package:ahoy_sample/AhoyStyles.dart';
import 'package:ahoy_sample/AhoyWidgets.dart';

enum TextPairVariant { normal, accented, small }

class TicketDetailsScreen extends StatelessWidget {
  final TicketDetailsData detailsData;

  TicketDetailsScreen(this.detailsData);

  @override Widget build(BuildContext context) {
    final navbarTitle = "${detailsData.departureLocationTitle} - ${detailsData.arrivalLocationTitle}";
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: _backButton(),
        middle: Text(navbarTitle,),
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
      AhoyWidgets.cellWithShadow(_flightDetails())
    ],);
  }

  _referenceRow() {
    return Row(children: <Widget>[
      Column(children: <Widget>[
        Text(captions.bookingReference, style: AhoyStyles.details.headerStyle),
        Text(data.bookingReferenceValue, style: AhoyStyles.details.valueStyle,),
      ],),
      AhoyWidgets.flexibleSpace(),
      Column(children: <Widget>[
        Text(captions.ticketNumber, style: AhoyStyles.details.headerStyle,),
        Text(data.ticketNumberValue, style: AhoyStyles.details.valueStyle,),
      ],),
    ],);
  }

  Widget _flightDetails() {
    return Row(
      children: <Widget>[
      Expanded(flex: 63,child: _flightDetailsLeft(),),
      _flightDetailsVerticalLine(),
      Expanded(flex: 107,child: _flightDetailsRight(),),
      // _flightDetailsLeft(),
      // _flightDetailsRight(),
    ],);
  }

  Widget _textPairView(String header, String value, TextPairVariant variant, CrossAxisAlignment alignment) {
    TextStyle headerStyle;
    TextStyle subtitleStyle;
    switch(variant) {
      case TextPairVariant.normal:
        headerStyle = AhoyStyles.details.titleStyle;
        subtitleStyle = AhoyStyles.details.subtitleStyle;
        break;
      case TextPairVariant.accented:
        headerStyle = AhoyStyles.details.accentedTitleStyle;
        subtitleStyle = AhoyStyles.details.subtitleStyle;
        break;
      case TextPairVariant.small:
        headerStyle = AhoyStyles.details.headerStyle;
        subtitleStyle = AhoyStyles.details.valueStyle;
        break;
    }
    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Text(header, style: headerStyle),
        Text(value, style: subtitleStyle),
      ],
    );
  }

  Widget _flightDetailsLeft() {
    final alignment = CrossAxisAlignment.end;
    final variant = TextPairVariant.accented;
    final top = _textPairView(data.departureTime, data.departureDate, variant, alignment);
    final center = Text(data.travelTime, style: AhoyStyles.details.headerStyle,);
    final bottom = _textPairView(data.arrivalTime, data.arrivalDate, variant, alignment);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        top,
        center,
        bottom,
      ],
    );
  }

  Widget _uniformFilledRow(List<Widget> children) {
    final expandedChildren = children.map((child){
      return Expanded(flex: 1, child:child);
    }).toList();
    return Row(children: expandedChildren);
  }

  Widget _flightDetailsRight() {
    final alignment = CrossAxisAlignment.start;
    final smallVariant = TextPairVariant.small;
    final normalVariant = TextPairVariant.normal;
    final flightNumber = _textPairView(captions.flightNumber, data.flightNumberValue, smallVariant, alignment); 
    final seat = _textPairView(captions.seat, data.seatValue, smallVariant, alignment);
    final terminal = _textPairView(captions.terminal, data.terminalValue, smallVariant, alignment);
    final gate = _textPairView(captions.gate, data.gateValue, smallVariant, alignment);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _textPairView(data.departureLocationTitle, data.departureLocationSubtitle, normalVariant, alignment),
        _uniformFilledRow([flightNumber, seat]),
        _uniformFilledRow([terminal, gate]),
        _textPairView(data.arrivalLocationTitle, data.arrivalLocationSubtitle, normalVariant, alignment),
      ],
    );
  }
  Widget _flightDetailsVerticalLine() {
    return Center(child:Text("|"));
  }
}