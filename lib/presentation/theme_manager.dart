import 'package:flutter/material.dart';
import 'package:tut_app/presentation/color_manager.dart';
import 'package:tut_app/presentation/font_manager.dart';
import 'package:tut_app/presentation/styles_manager.dart';
import 'package:tut_app/presentation/value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrmary,
    disabledColor: ColorManager.grey1,
    accentColor: ColorManager.grey,
    splashColor: ColorManager.primaryOpacity70,
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
        titleTextStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16)),
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white),
          primary: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12))),
    ),
    textTheme: TextTheme(
        headline1: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: AppSize.s16),
        subtitle1: getMediumStyle(
            color: ColorManager.lightGrey, fontSize: AppSize.s14),
        caption: getRegularStyle(color: ColorManager.grey1),
        bodyText1: getRegularStyle(color: ColorManager.grey)),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppSize.s8),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      labelStyle: getMediumStyle(color: ColorManager.darkGrey),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    ),
  );
}
