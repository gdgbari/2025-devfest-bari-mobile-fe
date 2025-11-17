part of 'notification_bloc.dart';

enum NotificationStatus {
  initial,
  updated
}

class NotificationState extends Equatable {
  final NotificationStatus status;
  final List<RemoteMessage> messages;

  const NotificationState({
    this.status = NotificationStatus.initial,
    this.messages = const [],
  });

  NotificationState copyWith({
    NotificationStatus? status,
    List<RemoteMessage>? messages,
  }) {
    return NotificationState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object> get props => [status, messages];
}