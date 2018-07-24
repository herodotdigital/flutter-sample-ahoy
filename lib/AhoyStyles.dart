import 'package:flutter/material.dart';

class AhoyStyles {
  static final list = _StyleTicketsScreen();
  static final details = _StyleDetailsScreen();
}

class AhoyColors {
  static final accentColor = Color.fromRGBO(211, 86, 165, 1.0);
  static final backgroundColor = Color.fromRGBO(255, 255, 255, 1.0);
  static final grey = Color.fromRGBO(155, 155, 155, 1.0);
  static final dark = Color.fromRGBO(74, 74, 74, 1.0);
  static final double scale = 2.0;
}

class _StyleTicketsScreen {
  TextStyle baseTextStyle;
  TextStyle titleStyle;
  TextStyle subtitleStyle;
  TextStyle headerDetailsStyle;
  TextStyle captionStyle;
  TextStyle valueStyle;
  TextStyle accentedValueStyle;

  _StyleTicketsScreen() {
    this.baseTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 6.0 * AhoyColors.scale,
    );
    this.titleStyle = baseTextStyle.copyWith(
      color: AhoyColors.accentColor,
      fontSize: 9.0 * AhoyColors.scale,
      fontWeight: FontWeight.w600
    );
    this.subtitleStyle = baseTextStyle.copyWith(
      color: AhoyColors.grey,
      fontSize: 7.0 * AhoyColors.scale,
    );
    this.headerDetailsStyle = subtitleStyle.copyWith(
      fontWeight: FontWeight.w600
    );
    this.captionStyle = baseTextStyle.copyWith(
      color: AhoyColors.dark
    );
    this.valueStyle = baseTextStyle.copyWith(
      color: AhoyColors.grey
    );
    this.accentedValueStyle = baseTextStyle.copyWith(
      color: AhoyColors.accentColor
    );
  }
}

class _StyleDetailsScreen {
  TextStyle headerStyle;
  TextStyle subtitleStyle;
  TextStyle titleStyle;
  TextStyle valueStyle;
  TextStyle accentedTitleStyle;
  TextStyle buttonTitleOnBackgroundStyle;
  TextStyle buttonTitleOnAccentStyle;
  TextStyle navbarStyle;

  _StyleDetailsScreen() {
    this.headerStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 6.0 * AhoyColors.scale,
      color: AhoyColors.grey,
    );
    this.subtitleStyle = headerStyle.copyWith(
      fontSize: 7.0 * AhoyColors.scale,
    );
    this.valueStyle = subtitleStyle.copyWith(
      color: AhoyColors.dark,
    );
    this.titleStyle = subtitleStyle.copyWith(
      fontSize: 8.0 * AhoyColors.scale,
      color: AhoyColors.dark,
    );
    this.accentedTitleStyle = titleStyle.copyWith(
      color: AhoyColors.accentColor,
      fontWeight: FontWeight.w600,
    );
    this.buttonTitleOnBackgroundStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 7.0 * AhoyColors.scale,
      color: AhoyColors.accentColor,
    );
    this.buttonTitleOnAccentStyle = buttonTitleOnBackgroundStyle.copyWith(
      color: AhoyColors.backgroundColor,
    );
    this.navbarStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w600,
      fontSize: 9.0 * AhoyColors.scale,
      color: AhoyColors.dark,
    );
  }
}