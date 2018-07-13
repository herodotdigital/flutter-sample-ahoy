import 'package:flutter/material.dart';

class AhoyStyles {
  static final accentColor = Color.fromRGBO(211, 86, 165, 1.0);
  static final grey = Color.fromRGBO(155, 155, 155, 1.0);
  static final dark = Color.fromRGBO(74, 74, 74, 1.0);
  static final double scale = 2.0;

  static final baseTextStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 6.0 * scale,
  );
  static final titleStyle = baseTextStyle.copyWith(
    color: accentColor,
    fontSize: 9.0 * scale,
    fontWeight: FontWeight.w600
  );
  static final subtitleStyle = baseTextStyle.copyWith(
    color: grey,
    fontSize: 7.0 * scale,
  );
  static final headerDetailsStyle = subtitleStyle.copyWith(
    fontWeight: FontWeight.w600
  );
  static final captionStyle = baseTextStyle.copyWith(
    color: dark
  );
  static final valueStyle = baseTextStyle.copyWith(
    color:grey
  );
  static final accentedValueStyle = baseTextStyle.copyWith(
    color: accentColor
  );
}