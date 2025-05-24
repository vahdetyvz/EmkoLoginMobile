import 'package:boardlock/helpers/bloc/language_bloc.dart';
import 'package:boardlock/helpers/bloc/language_events.dart';
import 'package:boardlock/modules/auth/bloc/auth_bloc.dart';
import 'package:boardlock/modules/home/bloc/about/about_bloc.dart';
import 'package:boardlock/modules/home/bloc/home_bloc.dart';
import 'package:boardlock/modules/home/bloc/home_events.dart';
import 'package:boardlock/modules/home/bloc/noti/notifications_bloc.dart';
import 'package:boardlock/modules/home/bloc/noti/notifications_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

class BlocInjection {
  List<SingleChildWidget> blocs = [
    BlocProvider(
      create: (_) => HomeBloc()..add(GetModels()),
    ),
    BlocProvider(
      create: (_) => AuthBloc(),
    ),
    BlocProvider(
      create: (_) => LanguageBloc()..add(GetLanguage()),
    ),
    BlocProvider(
      create: (_) => NotificationsBloc()..add(GetNotifications()),
    ),
    BlocProvider(
      create: (_) => AboutBloc(),
    ),
  ];
  List<SingleChildWidget> getBlocs() {
    return blocs;
  }
}
