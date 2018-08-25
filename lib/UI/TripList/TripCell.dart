import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Shared/AhoyStyles.dart';
import '../Shared/AhoyWidgets.dart';
import 'TripCellData.dart';
import 'DraggableCell.dart';

enum _SubtitlePosition {
  standalone, upper, lower
}

class TripCell extends StatelessWidget {
  final TripCellData data;
  final bool interactive;
  final Animation<double> animation;

  TripCell({
    @required this.data,
    this.animation,
    this.interactive = true,
  });

  @override Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: DraggableCell(
          key: new Key(data.uniqueKey()),
          onAccept: data.dismissMode == TripCellDismissMode.approveAndDecline ? _onApprove : null,
          onDecline: data.dismissMode == TripCellDismissMode.approveAndDecline ? _onDecline : null,
          onSlide: data.dismissMode == TripCellDismissMode.simpleSwipe ? _onSlide : null,
          child: Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Stack(children: <Widget>[
              _icon(data.iconName),
              _topRightText(data.topRightText),
              _buildColumn(),
            ],),
          ),
        ),
      ),
    );
  }

  Widget _buildColumn() {
    bool hasTwoLineSubtitle = data.subtitle2 != null;
    List<Widget> columnChildren = <Widget>[
      _title(data.title),
      _subtitle(data.subtitle1, hasTwoLineSubtitle ? _SubtitlePosition.upper : _SubtitlePosition.standalone),
      Row(children: <Widget>[
        _bottomText(data.bottomLeftCaption, data.bottomLeftValue, false),
        AhoyWidgets.flexibleSpace(),
        _bottomText(data.bottomRightCaption, data.bottomRightValue, true),
      ],),
    ];
    if (hasTwoLineSubtitle) {
      columnChildren.insert(2, _subtitle(data.subtitle2, _SubtitlePosition.lower));
    }
    return Column(children: columnChildren);
  }

  _onTap() {
    if (interactive) {
      data.onTap();
    }
  }

  _onApprove() {
    if (interactive) {
      data.onApprove();
    }
  }

  _onDecline() {
    if (interactive) {
      data.onDecline();
    }
  }

  _onSlide() {
    if (interactive) {
      data.onSlide();
    }
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

  Widget _subtitle(String text, _SubtitlePosition position) {
    final subtitleStyle = AhoyStyles.list.subtitleStyle;
    return Container(
      margin: _insetsFor(position),
      child: Text(text, style: subtitleStyle,),
    );
  }

  EdgeInsets _insetsFor(_SubtitlePosition position) {
    switch (position) {
      case _SubtitlePosition.standalone: return EdgeInsets.only(top: 7.0, bottom: 16.0,);
      case _SubtitlePosition.upper: return EdgeInsets.only(top: 7.0, bottom: 2.0,);
      case _SubtitlePosition.lower: return EdgeInsets.only(top: 2.0, bottom: 11.0,);
    }
  }
}