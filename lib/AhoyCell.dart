import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahoy_sample/AhoyStyles.dart';

class AhoyCellData {
  final String title;
  final String subtitle;
  final String iconName;
  final String topRightText;
  final String bottomRightCaption;
  final String bottomRightValue;
  final String bottomLeftCaption;
  final String bottomLeftValue;

  const AhoyCellData({
    this.title,
    this.subtitle,
    this.iconName,
    this.topRightText,
    this.bottomRightCaption,
    this.bottomRightValue,
    this.bottomLeftCaption,
    this.bottomLeftValue,
    });
}

class AhoyCell extends StatelessWidget {
  final AhoyCellData data;

  AhoyCell(this.data)

  @override Widget build(BuildContext context) {
    final double scale = 2.0;
    final accentColor = AhoyStyles.accentColor;
    final grey = AhoyStyles.grey;
    final dark = AhoyStyles.dark;
    final baseTextStyle = AhoyStyles.baseTextStyle;
    final titleStyle = AhoyStyles.titleStyle;
    final subtitleStyle = AhoyStyles.subtitleStyle;
    final captionStyle = AhoyStyles.captionStyle;
    final valueStyle = AhoyStyles.valueStyle;
    final accentedValueStyle = AhoyStyles.accentedValueStyle;

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
              image: new AssetImage(data.iconName),
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                      child: Text(data.bottomLeftCaption, style: captionStyle,),
                    ),
                    Text(data.bottomLeftValue, style: valueStyle,),
                  ],),
                  Row(children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                      child: Text(data.bottomRightCaption, style: captionStyle,),
                    ),
                    Text(data.bottomRightValue, style: accentedValueStyle,),
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

