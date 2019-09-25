import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provisional_license_test/questions/answer.dart';
import 'package:provisional_license_test/questions/question.dart';

const _borderRadius = 8.0;
const _horizontalMargin = 16.0;
const _verticalMargin = 16.0;

class PracticeResultsPage extends StatelessWidget {
  final List<Question> questions;
  final Map<double, Option> answers;

  const PracticeResultsPage(
      {Key key, @required this.questions, @required this.answers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final incorrect = _getIncorrect();
    final total = this.questions.length;
    return Material(
      child: SafeArea(
        bottom: false,
        child: Container(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: _horizontalMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Platform.isIOS
                                ? CupertinoIcons.back
                                : Icons.arrow_back),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(_horizontalMargin),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_borderRadius)),
                      child: Container(
                        padding: EdgeInsets.all(_horizontalMargin),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Your result',
                                style: Theme.of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Text(
                              "${total - incorrect}"
                              "/$total",
                              style: Theme.of(context)
                                  .textTheme
                                  .display3
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                            LinearProgressIndicator(
                              value: (total - incorrect) / total,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  incorrect < 4 ? Colors.green : Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              index -= 1;
              return QuestionResultWidget(
                question: this.questions[index],
                answer: this.answers[this.questions[index].id],
                number: index + 1,
              );
            },
            itemCount: this.questions.length + 1,
          ),
        ),
      ),
    );
  }

  _getIncorrect() {
    int incorrect = 0;
    for (var question in this.questions) {
      if (!this.answers[question.id].correct) incorrect++;
    }
    return incorrect;
  }
}

class QuestionResultWidget extends StatelessWidget {
  final Question question;
  final Option answer;
  final int number;

  const QuestionResultWidget({
    Key key,
    this.question,
    this.answer,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: _verticalMargin / 2,
        horizontal: _horizontalMargin,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: _horizontalMargin,
              right: _horizontalMargin,
              top: _verticalMargin,
            ),
            child: Text(
              '$number. ${question.title}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: _horizontalMargin),
              child: question.image == null
                  ? Container()
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_borderRadius),
                        child: Image.asset(
                          question.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
          ),
        ]
          ..addAll(
            question.answers.map(
              (option) => AnswerWidgetResults(
                    option: option.option,
                    text: option.title,
                    selected: this.answer.id == option.id,
                    correct: option.correct,
                  ),
            ),
          )
          ..add(Padding(
            padding: EdgeInsets.only(top: 0.75 * _verticalMargin),
          )),
      ),
    );
  }
}

class AnswerWidgetResults extends StatelessWidget {
  final String option;
  final String text;
  final bool selected;
  final bool cancelled;
  final bool correct;

  const AnswerWidgetResults({
    Key key,
    @required this.option,
    @required this.text,
    this.selected = false,
    this.cancelled = false,
    this.correct = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: _horizontalMargin, vertical: _verticalMargin / 4),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: selected
                  ? correct ? Colors.green : Colors.red
                  : Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
              border: Border.all(
                color: selected && !correct
                    ? Colors.red
                    : correct ? Colors.green : Colors.transparent,
              ),
            ),
            child: Text(
              '$option',
              style: Theme.of(context).textTheme.body2.copyWith(
                    color: selected ? Colors.white : Colors.black,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$text',
              style: Theme.of(context).textTheme.body2,
            ),
          ),
        ],
      ),
    );
  }
}
