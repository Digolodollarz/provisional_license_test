import 'package:flutter/material.dart';

const _margin = 16.0;
const _marginVertical = 16.0;
const _marginHorizontal = 16.0;
const _cornerRadius = 8.0;

class AnswerWidget extends StatelessWidget {
  final String option;
  final String text;
  final bool selected;
  final bool cancelled;
  final VoidCallback select;

  const AnswerWidget({
    Key key,
    @required this.option,
    @required this.text,
    @required this.selected,
    @required this.cancelled,
    @required this.select,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: select,
      child: Card(
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
      ),
    );
  }
}
