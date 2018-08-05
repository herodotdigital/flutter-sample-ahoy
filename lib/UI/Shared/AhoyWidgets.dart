import 'package:flutter/material.dart';
import 'AhoyStyles.dart';

class AhoyWidgets {
  static Widget flexibleSpace() {
    return Expanded(child:Container());
  }

  static Widget cellWithShadow(Widget child) {
    return Container(
      // height: 55.5*2,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 9.0,
      ),
      padding: EdgeInsets.all(14.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AhoyColors.shadowColor,
            blurRadius: 30.0,
            offset: Offset(9.0, 9.0)
          ),
        ],
      ),
      child: child
    );
  }
}