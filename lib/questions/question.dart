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
  int id;
  List<Option> answers;
  Category category;
  String created;
  String title;
  Null image;

  Question(
      {this.id,
        this.answers,
        this.category,
        this.created,
        this.title,
        this.image});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['answers'] != null) {
      answers = new List<Option>();
      json['answers'].forEach((v) {
        answers.add(new Option.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    created = json['created'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['created'] = this.created;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}