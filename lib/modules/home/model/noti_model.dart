class NotiModel {
  late int id;
  late String name, detail;

  NotiModel(
    this.id,
    this.name,
    this.detail,
  );

  factory NotiModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      NotiModel(
        json["id"] ?? "",
        json["title"] ?? "",
        json["message"] ?? "",
      );
}

class NotiListModel {
  late List<NotiModel> matches;
  NotiListModel(this.matches);

  factory NotiListModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      NotiListModel(
        List<NotiModel>.from(json["data"].map((e) => NotiModel.fromJson(e)))
            .toList(),
      );
}
