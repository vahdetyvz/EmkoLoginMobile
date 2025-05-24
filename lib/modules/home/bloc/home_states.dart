import 'package:boardlock/modules/auth/model/school_model.dart';
import 'package:boardlock/modules/home/model/history_model.dart';

import '../model/home_model.dart';

abstract class HomeStates {}

class HomeLoading extends HomeStates {}

class ResetPasswordLoading extends HomeStates {}

class ResetPasswordFailed extends HomeStates {}

class HomeLoaded extends HomeStates {
  final HomeListModel? model;
  HomeLoaded(this.model);
}

class HomeFailed extends HomeStates {
  final String text;
  HomeFailed(this.text);
}

class ModelsLoading extends HomeStates {}

class ModelsLoaded extends HomeStates {
  final HistoryListModel? model;
  ModelsLoaded(this.model);
}

class SchoolDetailLoaded extends HomeStates {
  final SchoolModel? model;
  SchoolDetailLoaded(this.model);
}

class MasterKeyChanged extends HomeStates {}

class TeachersLoaded extends HomeStates {
  final List<dynamic>? teacher;
  TeachersLoaded(this.teacher);
}

class ResetPasswordSuccess extends HomeStates {}
