import 'package:boardlock/helpers/bloc/language_bloc.dart';
import 'package:boardlock/helpers/bloc/language_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'helpers/dependency_injection/bloc_injection.dart';
import 'helpers/singleton/base_singelton.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: BlocInjection().getBlocs(),
      child: const BoardlockApp(),
    ),
  );
}

class BoardlockApp extends StatefulWidget {
  const BoardlockApp({super.key});

  @override
  State<BoardlockApp> createState() => BoardlockAppState();
}

class BoardlockAppState extends State<BoardlockApp> with BaseSingleton {
  late LanguageBloc bloc;
  Locale currentLocale = const Locale("en", "EN");
  @override
  void initState() {
    bloc = context.read<LanguageBloc>();
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize("c78db7b2-8bbd-4fe0-8201-5aaffe710b94");

    OneSignal.Notifications.requestPermission(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (context, state) {
        if (state is LanguageLoaded) {
          setState(() {
            currentLocale = state.locale;
          });
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: currentLocale,
        routerConfig: routes.routes,
        title: constants.appName,
      ),
    );
  }
}
