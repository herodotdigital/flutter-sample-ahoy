import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AhoyCellData {
  String title = "wro - waw";
  String subtitle = "Wrocław City Airport";
  String icon = "assets/images/planeGray.png";
  String topRightText = "in 30 mins";
  String bottomRightCaption = "Gate closes:";
  String bottomRightValue = "8:05 PM";
  String bottomLeftCaption = "Departure:";
  String bottomLeftValue = "8:35 PM";
}

class AhoyCell extends StatefulWidget {
  @override _AhoyCellState createState() {
    return _AhoyCellState();
  }
}

class _AhoyCellState extends State<AhoyCell> {
  @override Widget build(BuildContext context) {
    final data = AhoyCellData();
    final accentColor = Color.fromRGBO(211, 86, 165, 1.0);
    final grey = Color.fromRGBO(155, 155, 155, 1.0);
    final dark = Color.fromRGBO(74, 74, 74, 1.0);
    final double scale = 2.0;

    final baseTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 6.0 * scale,
    );
    final titleStyle = baseTextStyle.copyWith(
      color: accentColor,
      fontSize: 9.0 * scale,
      fontWeight: FontWeight.w600
    );
    final subtitleStyle = baseTextStyle.copyWith(
      color: grey,
      fontSize: 7.0 * scale,
    );
    final captionStyle = baseTextStyle.copyWith(
      color: dark
    );
    final valueStyle = baseTextStyle.copyWith(
      color:grey
    );
    final accentedValueStyle = baseTextStyle.copyWith(
      color: accentColor
    );

    return Container(
      // height: 55.5*2,
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
      child: Stack(
        children: <Widget>[
          Container(
            alignment: FractionalOffset.topLeft,
            child:new Image(
              image: new AssetImage(data.icon),
              height: 24.0,
              width: 24.0,
            ),
          ),
          Column(
            children: <Widget>[
              Text(data.title.toUpperCase(), style: titleStyle,),
              Container(
                margin: EdgeInsets.only(top: 7.0, bottom: 16.0,),
                child: Text(data.subtitle, style: subtitleStyle,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(data.bottomLeftCaption, style: captionStyle,),
                    Text(data.bottomLeftValue, style: valueStyle,),
                  ],),
                  Row(children: <Widget>[
                    Text(data.bottomRightCaption, style: captionStyle,),
                    Text(data.bottomRightValue, style: valueStyle,),
                  ],)
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(data.topRightText, style: valueStyle,),
                ],)
              )
            ],
          )
        ],
      ),      
      );
  }
}

