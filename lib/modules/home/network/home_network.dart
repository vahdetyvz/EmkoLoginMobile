import 'dart:convert';
import 'dart:developer';

import 'package:boardlock/helpers/extansions/string_extensions.dart';
import 'package:boardlock/modules/auth/model/school_model.dart';
import 'package:boardlock/modules/home/model/about_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../helpers/singleton/base_singelton.dart';

import '../../auth/model/auth_model.dart';
import '../model/history_model.dart';
import '../model/home_model.dart';
import '../model/noti_model.dart';

class HomeNetwork with BaseSingleton {
  Future<HomeListModel?> getHome() async {
    final response = await customDio.dio.get("matches".toApi);
    if (response.statusCode == 200) {
      return HomeListModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<NotiListModel?> getNotis() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("userData");
    AuthModel? model;
    if (data != null) {
      var converted = json.decode(data);
      model = AuthModel.fromJson2(converted);
    }
    final response = await customDio.dio.get("notifications".toApi, data: {
      "role": model != null ? model.role : "Kullanıcı",
    });

    if (response.statusCode == 200) {
      return NotiListModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<SchoolModel?> getSchoolDetail(int institutionId) async {
    final response = await customDio.dio.post("getSchoolDetail".toApi, data: {
      "institutionId": institutionId,
    });
    if (response.statusCode == 200) {
      return SchoolModel.fromJson(response.data[0]);
    } else {
      return null;
    }
  }

  Future<AboutModel?> getAbout(String language) async {
    final response =
        await customDio.dio.get("pages/hakkimizda/$language".toApi);
    if (response.statusCode == 200) {
      return AboutModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<bool?> resetUserPassword(
    String userId,
    String password,
  ) async {
    log("users/$userId/update".toApi);
    final response =
        await customDio.dio.put("users/$userId/update".toApi, data: {
      "password": password,
    });
    log(response.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool?> setMasterKey(String newMasterKey) async {
    final response = await customDio.dio.post(
      "masterKey/setMasterKey".toApi,
      data: {
        "master_key": newMasterKey,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  Future<List<dynamic>?> getTeachers() async {
    log("getTeachers");
    final response = await customDio.dio.get("users/getTeachers".toApi);
    log(response.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return response.data
          .map(
            (e) => AuthModel.fromJson3(
              e,
            ),
          )
          .toList();
    } else {
      return null;
    }
  }

  Future<bool?> setHistory(HistoryEventModel model, String userId) async {
    final response = await customDio.dio.post(
      "board/setLog".toApi,
      data: {"macAddress": model.macAdrress, "onOff": "on"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }
}
