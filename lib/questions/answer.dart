import 'package:provisional_license_test/db/db_helper.dart';

class Option {
  int id;
  String image;
  int questionId;
  String title;
  String option;

  Option({
    this.id,
    this.image,
    this.questionId,
    this.title,
    this.option,
  });

  factory Option.fromJson(Map<String, dynamic> json) => new Option(
    id: json["id"].toDouble(),
    image: json["image"] == null ? null : json["image"],
    questionId: json["questionId"].toDouble(),
    title: json["title"],
  );

  Option.fromMap(Map<String, dynamic> map) {
  this.id = map[columnId];
  this.image = map[columnImage];
  this.title = map[columnTitle];
  this.option = map[columnOption];
  this.questionId = map[columnQuestionId];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image == null ? null : image,
    "questionId": questionId,
    "title": title,
  };
}
