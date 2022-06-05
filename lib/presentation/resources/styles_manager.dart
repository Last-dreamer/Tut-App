import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContants.fontFamily, FontWeightManger.regular, color);
}

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContants.fontFamily, FontWeightManger.light, color);
}

TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContants.fontFamily, FontWeightManger.bold, color);
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContants.fontFamily, FontWeightManger.semiBold, color);
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContants.fontFamily, FontWeightManger.medium, color);
}
