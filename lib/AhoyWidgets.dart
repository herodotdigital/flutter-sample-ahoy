import 'package:flutter/material.dart';

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
}