import 'package:boardlock/modules/home/model/history_model.dart';

abstract class HomeEvents {}

class SaveModel extends HomeEvents {
  final HistoryEventModel model;
  SaveModel(this.model);
}

class GetModels extends HomeEvents {}

class GetSchoolDetail extends HomeEvents {
  int institutionId;
  GetSchoolDetail(this.institutionId);
}

class GetTeachers extends HomeEvents {}

class ResetTeacherPassword extends HomeEvents {
  int teacherId;
  String password;
  ResetTeacherPassword(this.teacherId, this.password);
}

class SetMasterKey extends HomeEvents {
  String masterKey;
  SetMasterKey(this.masterKey);
}
