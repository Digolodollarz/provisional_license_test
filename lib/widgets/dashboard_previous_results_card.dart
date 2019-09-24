import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provisional_license_test/practice/practice_quiz.dart';
import 'package:provisional_license_test/practice/practice_results.dart';
import 'package:provisional_license_test/questions/answer.dart';
import 'package:provisional_license_test/questions/question.dart';

class DashboardPreviousResultsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openRandomTest(context),
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Align(
                child: Text(
                  "Previous results",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Theme.of(context).primaryColorDark),
                ),
                alignment: Alignment(-1, 0),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "History",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: SizedBox(
                        child: Image.asset(
                          'assets/img/home_icons/gym-angled.png',
                          color: Theme.of(context).primaryColor,
                        ),
                        width: 64,
                        height: 64,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Revist your previous results",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(color: Color(0xAA000000)),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xAA000000),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_openRandomTest(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    final _mockQuestions = <Question>[];
    final _mockResults = Map<double, double>();
    final _random = Random();
    for (int i = 1; i <= 25; i++) {
      _mockQuestions.add(
        Question(
          id: i,
          image:
              _random.nextBool() ? 'assets/img/questions/road-rules.jpg' : null,
          title: 'Which car goes first in the diagram?',
          answers: <Option>[
            Option(id: 1, title: 'Car A', option: 'A'),
            Option(id: 2, title: 'Car C', option: 'B'),
            Option(id: 3, title: 'Car B', option: 'C'),
          ],
          correctAnswer: (1 + _random.nextInt(3)).toDouble(),
        ),
      );
      _mockResults.addAll(
          Map.from({i.toDouble(): (1 + _random.nextInt(3)).toDouble()}));
    }
    print("Ndasheedzwa");
    return PracticeResultsPage(
      questions: _mockQuestions,
      answers: _mockResults,
    );
  }));
}
