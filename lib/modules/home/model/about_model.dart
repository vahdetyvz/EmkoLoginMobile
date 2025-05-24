class AboutModel {
  late String title, content;

  AboutModel(
    this.title,
    this.content,
  );

  factory AboutModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      AboutModel(
        json["title"] ?? "",
        json["content"] ?? "",
      );
}
