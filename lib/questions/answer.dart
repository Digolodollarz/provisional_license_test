class Answer {
  double id;
  String image;
  double questionId;
  String title;

  Answer({
    this.id,
    this.image,
    this.questionId,
    this.title,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => new Answer(
    id: json["id"].toDouble(),
    image: json["image"] == null ? null : json["image"],
    questionId: json["question_id"].toDouble(),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image == null ? null : image,
    "question_id": questionId,
    "title": title,
  };
}
