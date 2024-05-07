import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeClass {
  Color darkPrimaryColor = HexColor('#113164');
  Color secondaryColor = HexColor('#f9f9fb');
  Color lightPrimaryColor = HexColor('#133f85');
  Color lightSecondaryColor = HexColor('#08224d');

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _themeClass.secondaryColor,
    primaryColor: _themeClass.lightPrimaryColor,
    shadowColor: _themeClass.lightPrimaryColor.withAlpha(100),
    colorScheme: ColorScheme.light(background: _themeClass.secondaryColor),
    iconTheme: IconThemeData(color: _themeClass.lightPrimaryColor),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 40,
          color: _themeClass.lightPrimaryColor,
          fontWeight: FontWeight.w700),
      labelLarge: TextStyle(
          fontSize: 35,
          color: _themeClass.secondaryColor,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
        fontSize: 20,
        color: _themeClass.lightPrimaryColor,
      ),
      labelMedium:
          TextStyle(fontSize: 25, color: _themeClass.lightPrimaryColor),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _themeClass.darkPrimaryColor,
    primaryColor: _themeClass.secondaryColor,
    shadowColor: _themeClass.lightSecondaryColor,
    colorScheme: ColorScheme.dark(background: _themeClass.secondaryColor),
    iconTheme: IconThemeData(color: _themeClass.secondaryColor),
    textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 40,
            color: _themeClass.darkPrimaryColor,
            fontWeight: FontWeight.w700),
        labelLarge: TextStyle(
            fontSize: 35,
            color: _themeClass.darkPrimaryColor,
            fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(
          fontSize: 20,
          color: _themeClass.secondaryColor,
        ),
        labelMedium:
            TextStyle(fontSize: 25, color: _themeClass.secondaryColor)),
  );
}

ThemeClass _themeClass = ThemeClass();
