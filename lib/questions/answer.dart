import 'package:provisional_license_test/db/db_helper.dart';

class Option {
  int id;
  String created;
  bool correct;
  String title;
  String option;
  String image;
  int question;

  Option(
      {this.id,
        this.created,
        this.correct,
        this.title,
        this.option,
        this.image,
        this.question});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    correct = json['correct'];
    title = json['title'];
    option = json['option'];
    image = json['image'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['correct'] = this.correct;
    data['title'] = this.title;
    data['option'] = this.option;
    data['image'] = this.image;
    data['question'] = this.question;
    return data;
  }
}
