import 'package:flutter/material.dart';

class PracticeQuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: SafeArea(
          minimum: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TimerWidget(),
              FractionallySizedBox(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    'assets/img/questions/road-rules.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  'Which car goes first in the diagram above?',
                  style: Theme.of(context).textTheme.display1.copyWith(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text("previous"),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text("next"),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '13',
                    style: Theme.of(context).textTheme.display1.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  Text('/25'),
                ],
              ),
              LinearProgressIndicator(value: 13 / 25),
            ],
          ),
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
      margin: EdgeInsets.symmetric(vertical: 8.0),
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
