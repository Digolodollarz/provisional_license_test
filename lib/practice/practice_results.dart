import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provisional_license_test/questions/question.dart';

class PracticeResults extends StatelessWidget {
  final List<Question> questions;
  final List<int> answers;

  const PracticeResults({Key key, this.questions, this.answers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("Your Results"),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionResultWidget extends StatelessWidget {
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

