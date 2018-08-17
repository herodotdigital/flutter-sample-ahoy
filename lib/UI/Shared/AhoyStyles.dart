import 'package:flutter/material.dart';

class AhoyStyles {
  static final list = _StyleTripScreen();
  static final details = _StyleDetailsScreen();
}

class AhoyColors {
  static final accentColor = Color.fromRGBO(211, 86, 165, 1.0);
  static final darkAccentColor = Color.fromRGBO(179, 66, 138, 1.0);
  static final backgroundColor = Color.fromRGBO(255, 255, 255, 1.0);
  static final grey = Color.fromRGBO(155, 155, 155, 1.0);
  static final transparentGrey = Color.fromRGBO(155, 155, 155, 0.5);
  static final dark = Color.fromRGBO(74, 74, 74, 1.0);
  static final shadowColor = Color.fromRGBO(0, 0, 0, 0.06);
  static final declineColor = Color.fromRGBO(245, 81, 95, 1.0);
  static final declineDarkColor = Color.fromRGBO(159, 4, 27, 1.0);
  static final approveColor = Color.fromRGBO(86, 211, 101, 1.0);
  static final approveDarkColor = Color.fromRGBO(83, 179, 66, 1.0);
}

class _StyleTripScreen {
  TextStyle _base;
  TextStyle titleStyle;
  TextStyle subtitleStyle;
  TextStyle headerDetailsStyle;
  TextStyle captionStyle;
  TextStyle valueStyle;
  TextStyle accentedValueStyle;
  TextStyle bottomLayerStyle;

  _StyleTripScreen() {
    this._base = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
    );
    this.titleStyle = _base.copyWith(
      color: AhoyColors.accentColor,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );
    this.subtitleStyle = _base.copyWith(
      color: AhoyColors.grey,
      fontSize: 14.0,
    );
    this.headerDetailsStyle = _base.copyWith(
      color: AhoyColors.transparentGrey,
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    );
    this.captionStyle = _base.copyWith(
      color: AhoyColors.dark
    );
    this.valueStyle = _base.copyWith(
      color: AhoyColors.grey
    );
    this.accentedValueStyle = _base.copyWith(
      color: AhoyColors.accentColor
    );
    this.bottomLayerStyle = _base.copyWith(
      color: AhoyColors.backgroundColor,
    );
  }

TextStyle segmentedControlStyle({@required bool accented}) {
    return _base.copyWith(
      fontSize: 14.0,
      color: accented ? AhoyColors.accentColor : AhoyColors.backgroundColor
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