import 'package:flutter/material.dart';
import 'AhoyStyles.dart';

class AhoyDecorations {
  static BoxDecoration wideButton(bool accented) {
    final backgroundColor = accented ? null : AhoyColors.backgroundColor;
    final gradient = accented ? accentedGradient() : null;
    return BoxDecoration(
      color: backgroundColor,
      gradient: gradient,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [_mediumShadow()],
    );
  }

  static BoxShadow bigShadow() {
    return _shadow(radius: 30.0 ,offset: 9.0);
  }

  static BoxShadow _mediumShadow() {
    return _shadow(radius: 20.0 ,offset: 4.0);
  }

  static BoxShadow _shadow({double radius, double offset}) {
    return BoxShadow(
      color: AhoyColors.shadowColor,
      blurRadius: radius,
      offset: Offset(offset, offset)
    );
  }

  static LinearGradient accentedGradient() {
    return LinearGradient(colors: [AhoyColors.accentColor, AhoyColors.darkAccentColor]);
  }
}