import 'package:flutter/material.dart';
import 'package:ahoy_sample/UI/Shared/AhoyStyles.dart';
import 'package:ahoy_sample/UI/Shared/AhoyWidgets.dart';

class TripHeaderData {
  final String title;
  final String details;

  TripHeaderData({@required this.title, this.details});
}

class TripHeader extends StatelessWidget {
  final TripHeaderData data;

  TripHeader({@required this.data});

  @override Widget build(BuildContext context) {
    List<Widget> children = [
      Text(data.title, style: AhoyStyles.list.titleStyle,),
      AhoyWidgets.flexibleSpace(),
    ];
    if (data.details != null) {
      children.add(Text(data.details, style: AhoyStyles.list.headerDetailsStyle,));
    }
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: Row(children: children),
    );
  }
}