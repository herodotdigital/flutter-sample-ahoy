import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import '../Shared/AhoyStyles.dart';
import '../Shared/AhoyWidgets.dart';
import '../FlightDetails/TicketDetailsDataFactory.dart';
import '../FlightDetails/TicketDetailsScreen.dart';
import 'AhoyCellData.dart';

class AhoyCell extends StatelessWidget {
  final AhoyCellData data;

  AhoyCell(this.data);

  static List<AhoyCell> forData(List<AhoyCellData> input) {
    return input.map(
      (data){ return AhoyCell(data); }
    ).toList();
  }

  @override Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) => _createDetailsScreen(),
        )
      ),
      child: _background(
        Stack(children: <Widget>[
          _icon(data.iconName),
          _topRightText(data.topRightText),
          Column(children: <Widget>[
            _title(data.title),
            _subtitle(data.subtitle),
            Row(children: <Widget>[
              _bottomText(data.bottomLeftCaption, data.bottomLeftValue, false),
              AhoyWidgets.flexibleSpace(),
              _bottomText(data.bottomRightCaption, data.bottomRightValue, true),
            ],),
          ],),
        ],),      
      ),
    );
  }

  TicketDetailsScreen _createDetailsScreen() {
    final trip = TripProvider().tripForId(this.data.tripId);
    final data = TicketDetailsDataFactory.fromTrip(trip);
    return TicketDetailsScreen(data);
  }

  _bottomText(String caption, String value, bool accented) {
    final captionStyle = AhoyStyles.list.captionStyle;
    final style = accented == true ? AhoyStyles.list.accentedValueStyle : AhoyStyles.list.valueStyle;
    return Row(children: <Widget>[
      Container(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
        child: Text(caption, style: captionStyle,),
      ),
      Text(value, style: style,),
    ],);
  }

  _topRightText(String text) {
    final valueStyle = AhoyStyles.list.valueStyle;
    return Container(alignment: Alignment.topRight,
      child:Text(text, style: valueStyle,),
    );
  }

  Widget _background(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 9.0,
      ),
      padding: EdgeInsets.all(14.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(4.5, 4.5)
          ),
        ],
      ),
      child: child
    );
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
  
  Widget _title(String text) {
    final titleStyle = AhoyStyles.list.titleStyle;
    return Text(text.toUpperCase(), style: titleStyle,);
  }

  Widget _subtitle(String text) {
    final subtitleStyle = AhoyStyles.list.subtitleStyle;
    return Container(
      margin: EdgeInsets.only(top: 7.0, bottom: 16.0,),
      child: Text(text, style: subtitleStyle,),
    );
  }
}