import 'package:boardlock/modules/home/model/history_model.dart';
import 'package:boardlock/modules/home/network/home_network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'about_events.dart';
import 'about_states.dart';

class AboutBloc extends Bloc<AboutEvents, AboutStates> {
  var api = HomeNetwork();
  HistoryListModel models = HistoryListModel([]);
  AboutBloc() : super(AboutLoading()) {
    on<GetAbout>(
      (event, emit) async {
        emit(AboutLoading());
        try {
          final response = await api.getAbout(event.language);
          if (response != null) {
            emit(AboutLoaded(response));
          } else {
            emit(AboutFailed(""));
          }
        } catch (e) {
          emit(AboutFailed(""));
        }
      },
    );
  }
}
