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
    return CupertinoPageScaffold(
      backgroundColor: AhoyColors.backgroundColor,
      child: Material(
        type: MaterialType.canvas,
        child: SafeArea(
          child: TicketDetails(detailsData),
        ),
      ),
    );
  }
}

class TicketDetails extends StatelessWidget {
  final captions = TicketDetailsLocalization.createEng();
  final TicketDetailsData data;
  final margin = 6.0 * 2.0;
  final verticalMargin = 14.0 * 2.0;

  TicketDetails(this.data);

  @override Widget build(BuildContext context) {
    final textBooking = captions.showEntireBooking.toUpperCase(); 
    final textBoarding = captions.showBoardingPass.toUpperCase(); 
    return Column(children: <Widget>[
      _navBar(context),
      Container(height: 12.0 * 2.0,),
      _referenceRow(),
      Container(height: 10.0 * 2.0,),
      AhoyWidgets.cellWithShadow(_flightDetails()),
      Spacer(flex: 1,),
      _bottomButton(accented: false, text: textBooking, onTap: _handleShowBooking),
      Container(height: margin,),
      _bottomButton(accented: true, text: textBoarding, onTap: _handleShowBoarding),
      Container(height: 16.0 * 2.0,),
    ],);
  }

  _handleGps() {
    print("Handle GPS button tap.");
    Bridge().dismiss();
  }

  _handleShowBooking() {
    print("Handle Booking button tap.");
  }

  _handleShowBoarding() {
    print("Handle Boarding button tap.");
  }

  _navBar(BuildContext context) {
    final navbarTitle = "${data.departureLocationTitle} - ${data.arrivalLocationTitle}";
    return Container(margin: EdgeInsets.symmetric(horizontal: 1.0 * 2), child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _barButton('assets/images/close.png', (){
            Navigator.pop(context); 
          }),
          Text(navbarTitle, style: AhoyStyles.details.navbarStyle,),
          _barButton('assets/images/pinFullCopy.png', _handleGps),
        ],
      ),
    );
  }

  _barButton(String imagePath, Function func) {
    // return _icon(imagePath);
    return CupertinoButton(
      padding: EdgeInsets.all(0.0),
      minSize: 28.0*2.0,
      child: _icon(imagePath),
      onPressed: func,
    );
  }

  _referenceRow() {
    return Container(margin: EdgeInsets.symmetric(horizontal: 16 * 2.0),child:
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
          Expanded(flex: 63,child: _flightDetailsLeft(),),
          _flightDetailsVerticalLine(),
          Expanded(flex: 107,child: _flightDetailsRight(),),
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
    final center = Text(data.travelTime, style: AhoyStyles.details.headerStyle,);
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
    return Column(
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
    );
  }
  Widget _flightDetailsVerticalLine() {
    return Column(children: <Widget>[
      Container(height: 5.0 * 2.0,),
      Image.asset('assets/images/oval6.png', width: 9.0 * 2,),
      Expanded(child: Container(color: Color.fromRGBO(155, 155, 155, 1.0), width: 1.5 * 2.0,),),
      Image.asset('assets/images/oval6.png', width: 9.0 * 2,),
      Container(height: 5.0 * 2.0,),
    ],);
  }

  Widget _icon(String imageName) {
    return Container(
      alignment: FractionalOffset.topLeft,
      child:new Image(
        image: new AssetImage(imageName),
        height: 24.0,
        width: 24.0,
      ),
    );
  }

  Widget _bottomButton({bool accented, String text, Function onTap}) {
    final style = accented ? AhoyStyles.details.buttonTitleOnAccentStyle : AhoyStyles.details.buttonTitleOnBackgroundStyle;
    final backgroundColor = accented ? AhoyColors.accentColor : AhoyColors.backgroundColor;
    final label = Text(text, style: style,);
    final decoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15.0,
          offset: Offset(4.5, 4.5)
        ),
      ],
    );
    final height = 22.5 * 2.0;
    final margin = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 0.0,
    );
    return Container(
      height: height,
      margin: margin,
      decoration: decoration,
      child: CupertinoButton(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        child: Center(child:label),
        onPressed: onTap,
        ),
    );
  }
}