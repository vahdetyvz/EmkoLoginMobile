import 'dart:convert';
import 'dart:developer';

import 'package:boardlock/modules/home/model/history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/home_network.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  var api = HomeNetwork();
  HistoryListModel models = HistoryListModel([]);
  HomeBloc() : super(HomeLoading()) {
    on<SaveModel>(
      (event, emit) async {
        var index = models.history.indexWhere((element) =>
            element.date == event.model.date &&
            element.macAdrress == event.model.macAdrress);
        if (index != -1) {
          models.history[index].times.addAll(event.model.times);
        } else {
          models.history.add(event.model);
        }
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        api.setHistory(event.model, "1");
        prefs.setString("history", jsonEncode(models.toJson()));
      },
    );
    on<GetModels>(
      (event, emit) async {
        emit(ModelsLoading());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        log(prefs.getString("history") ?? "[]");
        var savedValue = jsonDecode(prefs.getString("history") ?? "[]");
        models = HistoryListModel.fromJson(savedValue);
        emit(ModelsLoaded(models));
      },
    );

    on<GetSchoolDetail>(
      (event, emit) async {
        emit(HomeLoading());
        try {
          final response = await api.getSchoolDetail(event.institutionId);
          if (response != null) {
            emit(SchoolDetailLoaded(response));
          } else {
            emit(HomeFailed(""));
          }
        } catch (e) {
          emit(HomeFailed(""));
        }
      },
    );
    on<SetMasterKey>(
      (event, emit) async {
        emit(HomeLoading());
        try {
          final response = await api.setMasterKey(event.masterKey);
          if (response != null) {
            emit(MasterKeyChanged());
          } else {
            emit(HomeFailed(""));
          }
        } catch (e) {
          emit(HomeFailed(""));
        }
      },
    );

    on<GetTeachers>(
      (event, emit) async {
        emit(HomeLoading());
        //try {
        final response = await api.getTeachers();
        if (response != null) {
          emit(TeachersLoaded(response));
        } else {
          emit(HomeFailed(""));
        }
        /*} catch (e) {

          emit(HomeFailed(""));
        }*/
      },
    );
    on<ResetTeacherPassword>(
      (event, emit) async {
        emit(ResetPasswordLoading());
        try {
          final response = await api.resetUserPassword(
            event.teacherId.toString(),
            event.password,
          );
          if (response != null) {
            emit(ResetPasswordSuccess());
          } else {
            emit(ResetPasswordFailed());
          }
        } catch (e) {
          log(e.toString());
          emit(ResetPasswordFailed());
        }
      },
    );
  }
}
