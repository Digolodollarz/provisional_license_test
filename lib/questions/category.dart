class Category {
  int id;
  String title;

  Category({
    this.title,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
        id: json["id"].toDouble(),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
