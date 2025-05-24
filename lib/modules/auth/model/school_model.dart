class SchoolModel {
  late int id;
  late String name, number;

  SchoolModel(
    this.id,
    this.number,
    this.name,
  );

  factory SchoolModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      SchoolModel(
        json["id"] ?? 0,
        json["kurumKode"] ?? "",
        json["name"] ?? "",
      );
}

class SchoolListModel {
  late List<SchoolModel> schools;
  SchoolListModel(this.schools);

  factory SchoolListModel.fromJson(
    List<dynamic> json,
  ) =>
      SchoolListModel(
        json.map((e) => SchoolModel.fromJson(e)).toList(),
      );
}
