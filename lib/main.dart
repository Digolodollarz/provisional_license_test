import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provisional_license_test/theme.dart';
import 'package:provisional_license_test/widgets/home_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = getAppTheme();
    SystemChrome.setSystemUIOverlayStyle(appTheme.brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Learn to Drive',
      theme: getAppTheme(),
      home: MyHomePage(title: 'Learn to drive'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: HomeWidget(),
    );
  }
}

_startRandomQuiz() {}
