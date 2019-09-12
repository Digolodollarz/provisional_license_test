// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

import 'package:provisional_license_test/db/db_helper.dart';
import 'package:provisional_license_test/questions/answer.dart';
import 'package:provisional_license_test/questions/category.dart';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  List<Option> answers;
  double correctAnswer;
  double id;
  String image;
  String title;
  Category category;

  Question({
    this.answers,
    this.correctAnswer,
    this.id,
    this.image,
    this.title,
    this.category,
  });

  factory Question.fromJson(Map<String, dynamic> json) => new Question(
        answers: new List<Option>.from(
            json["answers"].map((x) => Option.fromJson(x))),
        correctAnswer: json["correctAnswer"].toDouble(),
        id: json["id"].toDouble(),
        image: json["image"] == null ? null : json["image"],
        title: json["title"],
        category: Category.fromJson(json["category"]),
      );

  Question.fromMap(Map<String, dynamic> map) {
    this.answers = map[answers];
    this.correctAnswer = map[correctAnswer];
    this.id = map[columnId];
    this.image = map[columnImage];
    this.title = map[columnTitle];
    this.category = map[category];
  }

  Map<String, dynamic> toJson() => {
        "answers": new List<dynamic>.from(answers.map((x) => x.toJson())),
        "correctAnswer": correctAnswer,
        "id": id,
        "image": image == null ? null : image,
        "title": title,
        "category": category.toJson(),
      };
}
