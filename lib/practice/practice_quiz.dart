import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:provisional_license_test/db/db_helper.dart';
import 'package:provisional_license_test/practice/practice_results.dart';
import 'package:provisional_license_test/questions/answer.dart';
import 'package:provisional_license_test/questions/question.dart';
import 'package:provisional_license_test/questions/quiz_result.dart';

import 'answer_widget.dart';

const _margin = 16.0;
const _marginVertical = 16.0;
const _marginHorizontal = 16.0;
const _cornerRadius = 8.0;

class PracticeQuizPage extends StatefulWidget {
  @override
  _PracticeQuizPageState createState() => _PracticeQuizPageState();
}

class _PracticeQuizPageState extends State<PracticeQuizPage> {
  int position = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          minimum: EdgeInsets.only(),
          child: FutureBuilder<List<Question>>(
              future:
                  DBHelper().db.then((db) => DBHelper().getRandomQuestions()),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Question>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                }
                return QuizWidget(questions: snapshot.data);
              }),
        ),
      ),
    );
  }
}

class QuizWidget extends StatefulWidget {
  final List<Question> questions;

  const QuizWidget({Key key, this.questions}) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int _position = 0;
  Map<int, Option> answers = Map();
  Map<int, Option> cancelledOptions = Map();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    maintainInteractivity: true,
                    child: Icon(
                        Platform.isIOS ? CupertinoIcons.pause : Icons.pause),
                  ),
//                  FlipClock.countdown(
//                    duration: Duration(minutes: 8, seconds: 0),
//                    digitColor: Colors.white,
//                    backgroundColor: Theme.of(context).accentColor,
//                    digitSize: 28.0,
//                    width: 24.0,
//                    height: 32.0,
//                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//                    onDone: () => print('ih'),
//                  ),
                  Icon(Platform.isIOS ? CupertinoIcons.clear : Icons.clear)
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: _marginHorizontal),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_cornerRadius),
                  child: widget.questions[_position].image != null
                      ? Image.network(
//                            'assets/img/questions/road-rules.jpg',
                          widget.questions[_position].image,
                          fit: BoxFit.cover,
                        )
                      : Text("No Image"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _marginHorizontal,
                vertical: _marginVertical / 2,
              ),
              child: Text(
                widget.questions[_position].title,
                style: Theme.of(context).textTheme.display1.copyWith(
                      height: 0.8,
                    ),
              ),
            ),
            ListView.builder(
              itemBuilder: (BuildContext context, int pos) {
                final option = widget.questions[_position].answers[pos];
                final questionId = widget.questions[_position].id;
                return AnswerWidget(
                    option: option.option,
                    text: option.title,
                    selected: answers[questionId] != null &&
                        answers[questionId].id == option.id,
                    cancelled: cancelledOptions[questionId] != null &&
                        cancelledOptions[questionId].id == option.id,
                    select: () {
                      print('Le Select');
                      if (answers[questionId] != null) {
                        if (answers[questionId].id == option.id) return;
                        if (cancelledOptions[questionId] != null) return;
                      }
                      setState(() {
                        cancelledOptions[questionId] = answers[questionId];
                        answers[questionId] = option;
                      });
                    });
              },
              itemCount: widget.questions[_position].answers.length,
              shrinkWrap: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _marginHorizontal,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text("previous"),
                    onPressed: () {
                      setState(() {
                        _position =
                            _position - 1 >= 0 ? _position - 1 : _position;
                      });
                    },
                    textColor: Theme.of(context).accentColor,
                  ),
                  RaisedButton(
                    child: Text(_position + 1 == widget.questions.length
                        ? "Finish"
                        : "next"),
                    onPressed: () {
                      setState(() {
                        if (_position + 2 > widget.questions.length) {
                          saveResult();
                        }
                        _position = _position + 1 < widget.questions.length
                            ? _position + 1
                            : _position;
                      });
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.body1.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_cornerRadius * 2),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${_position + 1}',
                        style: Theme.of(context).textTheme.display1.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      Text('/${widget.questions.length}'),
                    ],
                  ),
                  LinearProgressIndicator(
                      value: (_position + 1) / widget.questions.length),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  saveResult() async {
    final _db = DBHelper();
    await _db.initDb();

    int correct = 0;
    answers.forEach((q, a) {
      if (a.correct) correct++;
    });

    QuizResult result = QuizResult(
        date: DateTime.now(), correct: correct, total: widget.questions.length);

    await _db.saveTest(result);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PracticeResultsPage(
        questions: widget.questions,
        answers: answers,
        cancelledAnswers: cancelledOptions,
      );
    }));
  }
}

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '06:55',
        style:
            Theme.of(context).textTheme.display1.copyWith(color: Colors.black),
      ),
    );
  }
}
