import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flip_panel/flip_panel.dart';
import 'package:provisional_license_test/db/db_helper.dart';
import 'package:provisional_license_test/questions/question.dart';

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
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
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
                                child: Icon(Platform.isIOS
                                    ? CupertinoIcons.pause
                                    : Icons.pause),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tight(Size.zero),
                                child: FlipClock.countdown(
                                  duration: Duration(minutes: 8, seconds: 0),
                                  digitColor: Colors.white,
                                  backgroundColor: Theme.of(context).accentColor,
                                  digitSize: 28.0,
                                  width: 24.0,
                                  height: 32.0,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                  onDone: () => print('ih'),
                                ),
                              ),
                              Icon(Platform.isIOS
                                  ? CupertinoIcons.clear
                                  : Icons.clear)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: _marginHorizontal),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(_cornerRadius),
                              child: snapshot.data[position].image != null
                                  ? Image.network(
//                            'assets/img/questions/road-rules.jpg',
                                      snapshot.data[position].image,
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
                            'Which car goes first in the diagram above?',
                            style:
                                Theme.of(context).textTheme.display1.copyWith(
                                      height: 0.8,
                                    ),
                          ),
                        ),
                        AnswerWidget(
                          option: 'A',
                          text: 'Car Red',
                        ),
                        AnswerWidget(
                          option: 'B',
                          text: 'Car Blue',
                          selected: true,
                        ),
                        AnswerWidget(
                          option: 'C',
                          text: 'Car Green',
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
                                onPressed: () {},
                                textColor: Theme.of(context).accentColor,
                              ),
                              RaisedButton(
                                child: Text("next"),
                                onPressed: () {
                                  setState(() {
                                    position++;
                                  });
                                },
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .color,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(_cornerRadius * 2),
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
                                    '$position',
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  Text('/25'),
                                ],
                              ),
                              LinearProgressIndicator(value: position / 25),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
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

class AnswerWidget extends StatelessWidget {
  final String option;
  final String text;
  final bool selected;
  final bool cancelled;

  const AnswerWidget({
    Key key,
    @required this.option,
    @required this.text,
    this.selected = false,
    this.cancelled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: selected ? 8.0 : 2.0,
      margin: EdgeInsets.symmetric(
        vertical: _marginVertical / 4,
        horizontal: _marginHorizontal,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).primaryColor
                      : cancelled
                          ? Theme.of(context).accentColor
                          : Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
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
      ),
    );
  }
}
