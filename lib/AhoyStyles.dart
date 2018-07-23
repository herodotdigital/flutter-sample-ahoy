import 'package:flutter/material.dart';

class AhoyStyles {
  static final list = _StyleTicketsScreen();
  static final details = _StyleDetailsScreen();
}

class _BaseStyle {
  static final accentColor = Color.fromRGBO(211, 86, 165, 1.0);
  static final grey = Color.fromRGBO(155, 155, 155, 1.0);
  static final dark = Color.fromRGBO(74, 74, 74, 1.0);
  static final double scale = 2.0;
}

class _StyleTicketsScreen extends _BaseStyle {
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
      fontSize: 6.0 * _BaseStyle.scale,
    );
    this.titleStyle = baseTextStyle.copyWith(
      color: _BaseStyle.accentColor,
      fontSize: 9.0 * _BaseStyle.scale,
      fontWeight: FontWeight.w600
    );
    this.subtitleStyle = baseTextStyle.copyWith(
      color: _BaseStyle.grey,
      fontSize: 7.0 * _BaseStyle.scale,
    );
    this.headerDetailsStyle = subtitleStyle.copyWith(
      fontWeight: FontWeight.w600
    );
    this.captionStyle = baseTextStyle.copyWith(
      color: _BaseStyle.dark
    );
    this.valueStyle = baseTextStyle.copyWith(
      color: _BaseStyle.grey
    );
    this.accentedValueStyle = baseTextStyle.copyWith(
      color: _BaseStyle.accentColor
    );
  }
}

class _StyleDetailsScreen extends _BaseStyle {
  TextStyle headerStyle;
  TextStyle subtitleStyle;
  TextStyle titleStyle;
  TextStyle valueStyle;
  TextStyle accentedTitleStyle;

  _StyleDetailsScreen() {
    this.headerStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.w400,
      fontSize: 6.0 * _BaseStyle.scale,
      color: _BaseStyle.grey,
    );
    this.subtitleStyle = headerStyle.copyWith(
      fontSize: 7.0 * _BaseStyle.scale,
    );
    this.valueStyle = subtitleStyle.copyWith(
      color: _BaseStyle.dark,
    );
    this.titleStyle = subtitleStyle.copyWith(
      fontSize: 8.0 * _BaseStyle.scale,
      color: _BaseStyle.dark,
    );
    this.accentedTitleStyle = titleStyle.copyWith(
      color: _BaseStyle.accentColor,
      fontWeight: FontWeight.w600,
    );
  }
}