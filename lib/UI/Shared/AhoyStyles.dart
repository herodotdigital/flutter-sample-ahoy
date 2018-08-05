import 'package:flutter/material.dart';

class AhoyStyles {
  static final list = _StyleTicketsScreen();
  static final details = _StyleDetailsScreen();
}

class AhoyColors {
  static final accentColor = Color.fromRGBO(211, 86, 165, 1.0);
  static final darkAccentColor = Color.fromRGBO(179, 66, 138, 1.0);
  static final backgroundColor = Color.fromRGBO(255, 255, 255, 1.0);
  static final grey = Color.fromRGBO(155, 155, 155, 1.0);
  static final dark = Color.fromRGBO(74, 74, 74, 1.0);
  static final shadowColor = Color.fromRGBO(0, 0, 0, 0.06);
}

class _StyleTicketsScreen {
  TextStyle titleStyle;
  TextStyle subtitleStyle;
  TextStyle headerDetailsStyle;
  TextStyle captionStyle;
  TextStyle valueStyle;
  TextStyle accentedValueStyle;

  _StyleTicketsScreen() {
    TextStyle base = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
    );
    this.titleStyle = base.copyWith(
      color: AhoyColors.accentColor,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
    );
    this.subtitleStyle = base.copyWith(
      color: AhoyColors.grey,
      fontSize: 14.0,
    );
    this.headerDetailsStyle = base.copyWith(
      color: AhoyColors.grey,
      fontSize: 14.0,
      fontWeight: FontWeight.w600
    );
    this.captionStyle = base.copyWith(
      color: AhoyColors.dark
    );
    this.valueStyle = base.copyWith(
      color: AhoyColors.grey
    );
    this.accentedValueStyle = base.copyWith(
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
    TextStyle base = TextStyle(
      fontFamily: 'OpenSans',
    );
    this.headerStyle = base.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      color: AhoyColors.grey,
      letterSpacing: 0.1,
    );
    this.subtitleStyle = base.copyWith(
      fontWeight: FontWeight.w400,
      color: AhoyColors.grey,
      fontSize: 14.0,
    );
    this.valueStyle = base.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      color: AhoyColors.dark,
      letterSpacing: 0.2,
    );
    this.titleStyle = subtitleStyle.copyWith(
      fontSize: 16.0,
      color: AhoyColors.dark,
    );
    this.accentedTitleStyle = titleStyle.copyWith(
      color: AhoyColors.accentColor,
      fontWeight: FontWeight.w600,
    );
    this.buttonTitleOnBackgroundStyle = base.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: AhoyColors.accentColor,
    );
    this.buttonTitleOnAccentStyle = buttonTitleOnBackgroundStyle.copyWith(
      color: AhoyColors.backgroundColor,
    );
    this.navbarStyle = base.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: AhoyColors.dark,
    );
  }
}