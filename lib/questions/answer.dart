class Option {
  double id;
  String image;
  double questionId;
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image == null ? null : image,
    "questionId": questionId,
    "title": title,
  };
}
