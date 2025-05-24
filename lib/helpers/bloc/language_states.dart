import 'dart:ui';

abstract class LanguageStates {}

class LanguageLoading extends LanguageStates {}

class LanguageLoaded extends LanguageStates {
  Locale locale;
  LanguageLoaded(this.locale);
}

class LanguageFailed extends LanguageStates {
  final String text;
  LanguageFailed(this.text);
}
