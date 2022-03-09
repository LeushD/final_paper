import 'package:flutter/material.dart';

ThemeData globalTheme() => ThemeData(
  fontFamily: 'Georgia',
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light,).copyWith(
    secondary: Colors.lightBlue,
    surface: Colors.black12,
    onSurface: Colors.white,),

  textTheme: const TextTheme(
    headline4: TextStyle(fontSize: 33),
    headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.black),
    bodyText1: TextStyle(fontSize: 18.0, color: Colors.black),
  ),

);