import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_events.dart';
import 'language_states.dart';

class LanguageBloc extends Bloc<LanguageEvents, LanguageStates> {
  List<Locale> supportedLoaces = [
    const Locale("ar", "AR"),
    const Locale("de", "DE"),
    const Locale("en", "EN"),
    const Locale("fi", "FI"),
    const Locale("fr", "FR"),
    const Locale("he", "HE"),
    const Locale("lt", "LT"),
    const Locale("ro", "RO"),
    const Locale("tr", "TR"),
  ];
  LanguageBloc() : super(LanguageLoading()) {
    on<GetLanguage>(
      (event, emit) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String defaultLocale = Platform.localeName.length > 2
            ? Platform.localeName.substring(0, 2)
            : Platform.localeName;
        log(defaultLocale);
        var locale = prefs.getString("language") ?? defaultLocale;
        var model = supportedLoaces.firstWhere(
            (element) => element.languageCode == locale,
            orElse: () => const Locale("en", "EN"));
        emit(LanguageLoaded(model));
      },
    );
    on<SetLanguage>(
      (event, emit) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("language", event.lngCode);
        var model = supportedLoaces.firstWhere(
            (element) => element.languageCode == event.lngCode,
            orElse: () => const Locale("en", "EN"));
        emit(LanguageLoaded(model));
      },
    );
  }
}
