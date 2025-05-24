class HomeModel {
  late int id;
  

  HomeModel(
    this.id,
  
  );

  factory HomeModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      HomeModel(
        json["id"] ?? "",
       
      );
}

class HomeListModel {
  late List<HomeModel> matches;
  HomeListModel(this.matches);

  factory HomeListModel.fromJson(
    List<dynamic> json,
  ) =>
      HomeListModel(
        json.map((e) => HomeModel.fromJson(e)).toList(),
      );
}
