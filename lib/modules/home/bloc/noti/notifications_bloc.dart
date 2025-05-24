import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:boardlock/modules/home/network/home_network.dart';
import 'notifications_events.dart';
import 'notifications_states.dart';

class NotificationsBloc extends Bloc<NotificationsEvents, NotificationsStates> {
  var api = HomeNetwork();

  NotificationsBloc() : super(NotificationsLoading()) {
    on<GetNotifications>(
      (event, emit) async {
        emit(NotificationsLoading());
        try {
          final response = await api.getNotis();
          if (response != null) {
            emit(NotificationsLoaded(response));
          } else {
            emit(NotificationsFailed(""));
          }
        } catch (e) {
          log("error");
          log(e.toString());
          emit(NotificationsFailed("Beklenmedik bir hata ile karşılaşıldı"));
        }
      },
    );
  }
}
