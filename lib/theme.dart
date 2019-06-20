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
        : Color(0xFFEEEEEE),
    textTheme: base.textTheme.copyWith(
      body1: base.textTheme.body1,
      body2: base.textTheme.body2.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: base.brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
      display1: base.textTheme.display1.copyWith(
        fontSize: 20,
        color: base.brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
      display2: base.textTheme.display2.copyWith(
        fontSize: 24,
        color: base.brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
      display3: base.textTheme.display3.copyWith(
        fontSize: 28,
        color: base.brightness == Brightness.dark ? Colors.white : Colors.black,
      )
    ),
  );
}
