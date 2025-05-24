import 'package:boardlock/helpers/singleton/base_singelton.dart';
import 'package:boardlock/modules/home/bloc/noti/notifications_bloc.dart';
import 'package:boardlock/modules/home/bloc/noti/notifications_states.dart';
import 'package:boardlock/modules/home/widgets/noti/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/noti/notifications_events.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with BaseSingleton {
  late final NotificationsBloc notificationsBloc;
  @override
  void initState() {
    notificationsBloc = NotificationsBloc();
    notificationsBloc.add(GetNotifications());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SafeArea(
              top: false,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height *
                        (MediaQuery.of(context).size.height > 700 ? .22 : .2) +
                    MediaQuery.of(context).padding.top,
                decoration: BoxDecoration(
                  color: colors.blue,
                ),
              ),
            ),
            BlocBuilder(
              bloc: notificationsBloc,
              builder: (context, state) {
                if (state is NotificationsLoaded) {
                  return NotificationsView(model: state.models);
                } else {
                  return functions.platformIndicator(false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
