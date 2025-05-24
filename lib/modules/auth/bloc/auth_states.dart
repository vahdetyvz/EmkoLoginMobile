import 'package:boardlock/modules/auth/model/school_model.dart';

import '../model/auth_model.dart';

abstract class AuthStates {}

class AuthLoading extends AuthStates {}

class AuthLoaded extends AuthStates {
  final AuthModel? model;
  AuthLoaded(this.model);
}

class RegisterSuccess extends AuthStates {}

class SingUpDataSuccess extends AuthStates {
  SchoolListModel? model;
  SingUpDataSuccess(this.model);
}

class UpdateSuccess extends AuthStates {
  final AuthModel? model;
  UpdateSuccess(this.model);
}

class AuthFailed extends AuthStates {
  final String text;
  AuthFailed(this.text);
}

class AuthToPage extends AuthStates {
  final int page;
  AuthToPage(this.page);
}
