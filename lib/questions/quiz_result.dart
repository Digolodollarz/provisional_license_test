import 'dart:convert';

import 'package:provisional_license_test/questions/question.dart';

import 'answer.dart';

class QuizResult {
  int id;
  DateTime date;
  int correct;
  int total;

  QuizResult({
    this.id,
    this.date,
    this.correct,
    this.total,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json['id'],
      date: json['date'],
      correct: json['correct'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'correct': correct,
        'total': total,
      };

  QuizResult.fromMap(Map<String, dynamic> map){
    id = map['id'];
    date = DateTime.parse(map['date']);
    correct = map['correct'];
    total = map['total'];
  }
}
