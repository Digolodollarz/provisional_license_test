import 'package:flutter/material.dart';

ThemeData base = ThemeData(
    //brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurpleAccent,
    primaryColorDark: Colors.deepPurple,
    primaryColorLight: Colors.purple,
    accentColor: Colors.deepOrangeAccent,
    fontFamily: 'Rubik');

ThemeData getAppTheme() {
  return base.copyWith(
    backgroundColor: base.brightness == Brightness.dark
        ? Color(0xFF222222)
        : Color(0xFFDDDDDD),
    textTheme: base.textTheme.copyWith(
      body1: base.textTheme.body1,
      body2: base.textTheme.body2.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: base.brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
    ),
  );
}
