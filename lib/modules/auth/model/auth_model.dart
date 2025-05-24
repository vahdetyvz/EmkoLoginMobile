class AuthModel {
  late int id, schoolId;
  late String token, fullName, email, password, image, role;
  late bool canEditTeacher;

  AuthModel(
    this.id,
    this.schoolId,
    this.token,
    this.fullName,
    this.email,
    this.password,
    this.canEditTeacher,
    this.image,
    this.role,
  );

  factory AuthModel.fromJson2(
    Map<String, dynamic> json,
  ) {
    return AuthModel(
      json["userData"]["id"] ?? 0,
      json["userData"]["school_id"] ?? 0,
      json["access_token"] ?? "",
      json["userData"]["fullname"] ?? 0,
      json["userData"]["email"] ?? 0,
      json["userData"]["password"] ?? "",
      (json["userData"]["yetkiler"]["Öğretmenler"] ?? "off") == "on",
      json["userData"]["image"] ?? "",
      json["userData"]["role"] ?? "",
    );
  }

  factory AuthModel.fromJson(
    Map<String, dynamic> json,
    String password,
  ) =>
      AuthModel(
        json["user"]["id"] ?? 0,
        json["user"]["institutionId"] ?? 0,
        json["token"] ?? "",
        json["user"]["name"] ?? "",
        json["user"]["email"] ?? "",
        password,
        (json["user"]["role"] == "Admin" || json["user"]["role"] == "Yönetici")
            ? true
            : false,
        json["user"]["images"].length > 0 ? json["user"]["images"][0] : "",
        json["user"]["role"] ?? "",
      );

  factory AuthModel.fromJson3(
    Map<String, dynamic> json,
  ) =>
      AuthModel(
        json["id"] ?? 0,
        json["institutionId"] ?? 0,
        "",
        json["name"] ?? 0,
        json["email"] ?? 0,
        "",
        false,
        "",
        "",
      );
  Map<String, dynamic> toJson() {
    return {
      "userData": {
        "id": id,
        "school_id": schoolId,
        "fullname": fullName,
        "email": email,
        "password": password,
        "yetkiler": {"Öğretmenler": canEditTeacher ? "on" : "off"},
        "image": image,
        "role": role,
      },
      "access_token": token,
    };
  }
}
