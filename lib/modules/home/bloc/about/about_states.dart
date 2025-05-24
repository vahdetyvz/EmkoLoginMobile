import 'package:boardlock/modules/home/model/about_model.dart';

abstract class AboutStates {}

class AboutLoading extends AboutStates {}

class AboutLoaded extends AboutStates {
  final AboutModel? model;
  AboutLoaded(this.model);
}

class AboutFailed extends AboutStates {
  final String text;
  AboutFailed(this.text);
}
