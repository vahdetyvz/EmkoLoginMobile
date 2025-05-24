import 'dart:developer';

import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/modules/auth/model/school_model.dart';
import 'package:custom_platform_device_id/platform_device_id.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../../helpers/singleton/base_singelton.dart';
import '../model/auth_model.dart';

class AuthNetwork with BaseSingleton {
  Future<AuthModel?> getUserDetail() async {
    final response = await customDio.dio.get("getTeacher".toApi);
    log(response.data);
    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data, "");
    } else {
      return null;
    }
  }

  Future<AuthModel?> login(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uuid = const Uuid();

    String deviceId = sharedPreferences.getString("devideId") ??
        await PlatformDeviceId.getDeviceId ??
        uuid.v4();
    sharedPreferences.setString("devideId", deviceId);
    final response = await customDio.dio.post(
      "auth/login".toApi,
      data: {
        "email": email,
        "password": password,
        "products": "Emko API",
        "deviceId": deviceId
      },
      //0db872db7e21a6ae
    );
    log(response.data.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      //if (response.data["user"]["status"] != 0) {
      return AuthModel.fromJson(response.data, password);
      /*}
      return AuthModel(-1, -1, "", "", "", "", false, "");*/
    } else {
      return null;
    }
  }

  Future<int?> register(
    String name,
    String email,
    String schoolID,
    String phone,
    String password,
  ) async {
    log("register");
    log({
      "name": name,
      "email": email,
      "institutionId": schoolID,
      "phone": phone,
      "password": password,
      "role": "Kullanıcı",
    }.toString());
    final response = await customDio.dio.post("users/store".toApi, data: {
      "name": name,
      "email": email,
      "institutionId": schoolID,
      "phone": phone,
      "password": password,
      "role": "Kullanıcı",
    });
    log(response.data.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      return 4;
    } else if (response.statusCode == 500) {
      return 3;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateUser(
      int id, String fullName, String oldPassword, String password) async {
    log("users/$id/update".toApi);
    final response = await customDio.dio.put("users/$id/update".toApi, data: {
      "name": fullName,
      "password": password,
    });
    log(response.toString());
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<SchoolListModel?> getSchoolList() async {
    final response = await customDio.dio.get("getSchoolList".toApi);
    if (response.statusCode == 200) {
      return SchoolListModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<bool?> setProfilePicture(String path) async {
    var map = {
      "image": await MultipartFile.fromFile(
        path,
      ),
    };
    final response = await customDio.dio.post(
      "users/getImageUpload".toApi,
      data: FormData.fromMap(map),
    );
    log(response.data.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool?> deleteAccount(int id) async {
    log("users/$id/delete".toApi);

    final response = await customDio.dio.delete("users/$id/delete".toApi);
    if (response.statusCode == 200 || response.statusCode == 200) {
      final prefences = await SharedPreferences.getInstance();
      await prefences.clear();

      return true;
    } else {
      return null;
    }
  }

  Future<bool?> sendInvate(String email) async {
    final response = await customDio.dio.post("davet-gonder".toApi, data: {
      "emails": email,
      "turs": "Temsilci",
      "lang": "tr",
    });
    log(response.toString(), name: "response");
    log(response.statusCode.toString(), name: "status");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return null;
    }
  }
}
