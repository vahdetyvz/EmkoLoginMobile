abstract class LanguageEvents {}

class GetLanguage extends LanguageEvents {}

class SetLanguage extends LanguageEvents {
  final String lngCode;
  SetLanguage(this.lngCode);
}
