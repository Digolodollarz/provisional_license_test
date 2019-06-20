import 'package:flutter/widgets.dart';
import 'package:provisional_license_test/questions/answer.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final Answer correctAnswer;
  final List<Answer> answers;

  const QuestionWidget(
      {Key key, this.question, this.correctAnswer, this.answers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
