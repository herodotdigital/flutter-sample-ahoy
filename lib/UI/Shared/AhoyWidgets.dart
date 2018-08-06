import 'package:flutter/material.dart';
import 'AhoyDecorations.dart';

class AhoyWidgets {
  static Widget flexibleSpace() {
    return Expanded(child:Container());
  }

  static Widget cellWithShadow(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 9.0,
      ),
      padding: EdgeInsets.all(14.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[AhoyDecorations.bigShadow()],
      ),
      child: child
    );
  }
}