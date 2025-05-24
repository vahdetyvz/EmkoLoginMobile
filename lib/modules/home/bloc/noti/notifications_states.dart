import '../../model/noti_model.dart';

abstract class NotificationsStates {}

class NotificationsLoading extends NotificationsStates {}

class NotificationsLoaded extends NotificationsStates {
  final NotiListModel models;
  NotificationsLoaded(this.models);
}

class NotificationsFailed extends NotificationsStates {
  final String text;
  NotificationsFailed(this.text);
}
