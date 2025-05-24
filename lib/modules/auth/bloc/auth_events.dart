import 'package:boardlock/modules/auth/model/auth_model.dart';

abstract class AuthEvents {}

class GetAuth extends AuthEvents {}

class Login extends AuthEvents {
  String email, password;
  Login(
    this.email,
    this.password,
  );
}

class Register extends AuthEvents {
  String name, email, schoolId, phone, password;
  Register(
    this.name,
    this.email,
    this.schoolId,
    this.phone,
    this.password,
  );
}

class UpdateUser extends AuthEvents {
  String name, password, oldPassword;
  AuthModel model;

  UpdateUser(
    this.name,
    this.oldPassword,
    this.password,
    this.model,
  );
}

class LoginBt extends AuthEvents {}

class GetSignUpData extends AuthEvents {}

class GoToPage extends AuthEvents {
  final int index;
  GoToPage(this.index);
}

class UpdateProfilePicture extends AuthEvents {
  final String path;
  UpdateProfilePicture(
    this.path,
  );
}
