import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahoy_sample/AhoyStyles.dart';
import 'package:ahoy_sample/AhoyWidgets.dart';

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

  AhoyCell(this.data);

  @override Widget build(BuildContext context) {
    return _background(
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
    );
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