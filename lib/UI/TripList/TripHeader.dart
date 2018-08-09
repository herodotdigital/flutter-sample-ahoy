import 'package:flutter/material.dart';
import 'package:ahoy_sample/UI/Shared/AhoyStyles.dart';
import 'package:ahoy_sample/UI/Shared/AhoyWidgets.dart';

class TripHeader extends StatelessWidget {
  final String title;
  final String details;

  TripHeader({@required this.title, this.details});

  @override Widget build(BuildContext context) {
    List<Widget> children = [
      Text(title, style: AhoyStyles.list.titleStyle,),
      AhoyWidgets.flexibleSpace(),
    ];
    if (details != null) {
      children.add(Text(details, style: AhoyStyles.list.headerDetailsStyle,));
    }
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
      child: Row(children: children),
    );
  }
}