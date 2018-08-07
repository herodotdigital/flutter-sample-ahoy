import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahoy_sample/Services/TripProvider.dart';
import '../Shared/AhoyStyles.dart';
import '../Shared/AhoyWidgets.dart';
import '../FlightDetails/FlightDetailsDataFactory.dart';
import '../FlightDetails/FlightDetailsScreen.dart';
import 'TripCellData.dart';
import 'DraggableCell.dart';

class TripCell extends StatelessWidget {
  final TripCellData data;
  Function onApprove;
  Function onDismiss;

  TripCell({
    @required this.data,
    @required this.onApprove,
    @required this.onDismiss,
  });

  static List<TripCell> forData(List<TripCellData> input) {
    return input.map(
      (data){ return TripCell(data:data, onApprove: (){}, onDismiss: (){}); }
    ).toList();
  }

  @override Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) => _createDetailsScreen(),
        )
      ),
      child: DraggableCell(
        onAccept: _onApprove,
        onDelete: _onDismiss,
        child: Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Stack(children: <Widget>[
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
      ),
    );
  }

  _onApprove() {
    onApprove();
  }

  _onDismiss() {
    onDismiss();
  }

  FlightDetailsScreen _createDetailsScreen() {
    final trip = TripProvider().tripForId(this.data.tripId);
    final data = FlightDetailsDataFactory.fromTrip(trip);
    return FlightDetailsScreen(data);
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
    return Text(text, style: titleStyle,);
  }

  Widget _subtitle(String text) {
    final subtitleStyle = AhoyStyles.list.subtitleStyle;
    return Container(
      margin: EdgeInsets.only(top: 7.0, bottom: 16.0,),
      child: Text(text, style: subtitleStyle,),
    );
  }
}