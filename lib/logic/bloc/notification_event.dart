part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class NotificationReceived extends NotificationEvent {
  final RemoteMessage message;

  NotificationReceived(this.message);
}

class NotificationCleared extends NotificationEvent {
  NotificationCleared();
}
