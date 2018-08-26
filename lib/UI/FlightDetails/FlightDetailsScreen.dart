import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Shared/AhoyStyles.dart';
import '../Shared/AhoyWidgets.dart';
import '../Shared/AhoyDecorations.dart';
import 'FlightDetailsData.dart';
import 'package:ahoy_sample/l10n/AhoyLocalizations.dart';
import 'package:ahoy_sample/UI/Shared/AhoyBarButton.dart';

enum TextPairVariant { normal, accented, small }

class FlightDetailsScreen extends StatelessWidget {
  final FlightDetailsData detailsData;

  FlightDetailsScreen(this.detailsData);

  @override Widget build(BuildContext context) {
    final navbarTitle = "${detailsData.departureLocationTitle} - ${detailsData.arrivalLocationTitle}";
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: AhoyBarButton.close(onTap: () => Navigator.pop(context)),
        middle: Text(navbarTitle, style: AhoyStyles.details.navbarStyle,),
        border: Border(),
        padding: EdgeInsetsDirectional.only(start: 18.0, end: 18.0, top: 18.0),
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
      ),
      backgroundColor: AhoyColors.backgroundColor,
      child: Material(
        type: MaterialType.canvas,
        child: SafeArea(
          child: FlightDetails(detailsData),
        ),
      ),
    );
  }
}

class FlightDetails extends StatelessWidget {
  final captions = FlightDetailsLocalization.createEng();
  final FlightDetailsData data;
  final margin = 12.0;
  final verticalMargin = 28.5;

  FlightDetails(this.data);

  @override Widget build(BuildContext context) {
    final textBoarding = captions.showBoardingPass.toUpperCase();
    return Column(children: <Widget>[
//      _navBar(context),
      Container(height: 40.0,),
      _referenceRow(),
      Container(height: 20.0,),
      AhoyWidgets.cellWithShadow(
        Container(padding: EdgeInsets.only(top: 7.0, bottom: 18.0,),
          child: _flightDetails(),
        )
      ),
      Spacer(flex: 1,),
      _bottomButton(
          accented: true,
          text: textBoarding,
          onTap: () => _showStub(
            title: l10n(context).stubBoardingPassText,
            context: context,
          )
      ),
      Container(height: 32.0,),
    ],);
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

  _referenceRow() {
    return Container(margin: EdgeInsets.symmetric(horizontal: 32.0),child:
      Row(children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(captions.bookingReference, style: AhoyStyles.details.headerStyle),
            Text(data.bookingReferenceValue, style: AhoyStyles.details.valueStyle,),
          ],
        ),
        AhoyWidgets.flexibleSpace(),
        Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(captions.ticketNumber, style: AhoyStyles.details.headerStyle,),
            Text(data.ticketNumberValue, style: AhoyStyles.details.valueStyle,),
          ],
        ),
      ],)
    );
  }

  Widget _flightDetails() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(flex: 111,child: _flightDetailsLeft(),),
          Expanded(flex: 20, child: _flightDetailsVerticalLine(),),
          Expanded(flex: 206,child: _flightDetailsRight(),),
        ],
      ),
    );
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
    final center = Padding(padding: EdgeInsets.only(right: 3.0), child:
      Text(data.travelTime, style: AhoyStyles.details.headerStyle,)
    );
    final top = Padding(padding: EdgeInsets.only(right: margin), child:
      _textPairView(data.departureTime, data.departureDate, variant, alignment)
    );
    final bottom = Padding(padding: EdgeInsets.only(right: margin), child:
      _textPairView(data.arrivalTime, data.arrivalDate, variant, alignment)
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
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
    final departure = Padding(padding: EdgeInsets.only(left: margin), child: 
          _textPairView(data.departureLocationTitle, data.departureLocationSubtitle, normalVariant, alignment),
        );
    final arrival = Padding(padding: EdgeInsets.only(left: margin), child: 
          _textPairView(data.arrivalLocationTitle, data.arrivalLocationSubtitle, normalVariant, alignment),
        );
    return Container(margin: EdgeInsets.only(left: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          departure,
          Container(height: verticalMargin,),
          _uniformFilledRow([flightNumber, seat]),
          Container(height: verticalMargin,),
          _uniformFilledRow([terminal, gate]),
          Container(height: verticalMargin,),
          arrival,
        ],
      ),
    );
  }

  Widget _flightDetailsVerticalLine() {
    return Column(children: <Widget>[
      Container(height: 10.0,),
      Image.asset('assets/images/oval6.png', width: 20.0,),
      Expanded(child: Container(color: Color.fromRGBO(155, 155, 155, 1.0), width: 3.0,),),
      Image.asset('assets/images/oval6.png', width: 20.0,),
      Container(height: 10.0,),
    ],);
  }

  Widget _bottomButton({bool accented, String text, Function onTap}) {
    final style = accented ? AhoyStyles.details.buttonTitleOnAccentStyle : AhoyStyles.details.buttonTitleOnBackgroundStyle;
    final label = Text(text, style: style,);
    final height = 45.0;
    final margin = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 0.0,
    );
    return Container(
      height: height,
      margin: margin,
      decoration: AhoyDecorations.wideButton(accented),
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(10.0),
        padding: EdgeInsets.all(0.0),
        child: Center(child:label),
        onPressed: onTap,
        ),
    );
  }
}