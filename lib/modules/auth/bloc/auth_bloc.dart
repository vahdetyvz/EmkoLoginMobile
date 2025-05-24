import 'dart:convert';
import 'dart:developer';

import 'package:boardlock/modules/auth/model/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/auth_network.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  var api = AuthNetwork();

  AuthBloc() : super(AuthLoading()) {
    on<GetAuth>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          var data = preferences.getString("userData");

          if (data != null) {
            var converted = json.decode(data);
            var model = AuthModel.fromJson2(converted);
            var response = await api.login(model.email, model.password);
            if (response != null) {
              preferences.setString("token", response.token);
              preferences.setString("userData", json.encode(response.toJson()));
              emit(AuthLoaded(response));
            } else {
              emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
            }
          } else {
            emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
          }
        } on DioException catch (e) {
          if (e.response?.statusCode == 404) {
            emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
          }
        } catch (e) {
          log(e.toString());
          emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
        }
      },
    );
    on<Login>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final response = await api.login(event.email, event.password);
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();

          if (response != null) {
            if (response.id > 0) {
              preferences.setString("token", response.token);

              preferences.setString("userData", json.encode(response.toJson()));
              emit(AuthLoaded(response));
            } else {
              emit(AuthFailed("4"));
            }
          } else {
            emit(AuthFailed("1"));
          }
        } on DioException catch (e) {
          log(e.toString(), name: "bloc log");
          log(e.response!.statusCode.toString(), name: "bloc log");
          log(e.response!.data.toString(), name: "bloc log");
          if (e.response != null) {
            emit(AuthFailed(
                "${e.response!.data.toString().contains("Şifreniz") ? 3 : e.response!.data.toString().contains("mail") ? 2 : e.response!.data.toString().contains("aktif") ? 4 : e.response!.data.toString().contains("cihaz") ? 8 : 1}"));
          } else {
            emit(AuthFailed("1"));
          }
        } catch (e) {
          log(e.toString(), name: "bloc log");

          emit(AuthFailed("1"));
        }
      },
    );
    on<Register>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final response = await api.register(event.name, event.email,
              event.schoolId, event.phone, event.password);
          if (response != null) {
            if (response == 4) {
              emit(RegisterSuccess());
            } else {
              emit(AuthFailed(response.toString()));
            }
          } else {
            emit(AuthFailed("1"));
          }
        } catch (e) {
          log(e.toString(), name: "bloc log");

          emit(AuthFailed("1"));
        }
      },
    );

    on<GetSignUpData>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final response = await api.getSchoolList();
          if (response != null) {
            emit(SingUpDataSuccess(response));
          } else {
            emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
          }
        } catch (e) {
          emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
        }
      },
    );

    on<UpdateUser>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          final response = await api.updateUser(
            event.model.id,
            event.name == "" ? event.model.fullName : event.name,
            event.oldPassword,
            event.password,
          );
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          log("------- burda ------");
          log(response.toString(), name: "response");
          log(response?.toString() ?? "yok", name: "status");
          if (response != null) {
            event.model.fullName = response["name"] ?? event.model.fullName;
            event.model.email = response["email"] ?? event.model.email;
            if (event.password != "") {
              event.model.password = event.password;
            }
            log(event.model.toJson().toString(), name: "password");
            preferences.setString(
                "userData", json.encode(event.model.toJson()));
            emit(UpdateSuccess(event.model));
          } else {
            emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
          }
        } catch (e) {
          log(e.toString());
          emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
        }
      },
    );

    on<UpdateProfilePicture>(
      (event, emit) async {
        emit(AuthLoading());
        try {
          log("blogda path : ${event.path}");
          final response = await api.setProfilePicture(
            event.path,
          );
          if (response == true) {
            final SharedPreferences preferences =
                await SharedPreferences.getInstance();
            var data = preferences.getString("userData");
            var model = AuthModel.fromJson2(json.decode(data ?? ""));
            final responseModel = await api.login(model.email, model.password);
            preferences.setString("token", responseModel?.token ?? "");

            preferences.setString(
                "userData", json.encode(responseModel?.toJson()));
            emit(AuthLoaded(responseModel));
          } else {
            emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
          }
        } catch (e) {
          log(e.toString());
          emit(AuthFailed("Beklenmedik bir hata ile karşılaşıldı"));
        }
      },
    );
  }
}
