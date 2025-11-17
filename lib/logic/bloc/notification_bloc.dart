import 'package:devfest_bari_2025/data/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notificationRepo = NotificationRepository.instance;

  NotificationBloc() : super(const NotificationState()) {
    on<NotificationReceived>(_onNotificationReceived);
    on<NotificationCleared>(_onNotificationCleared);
  }

  Future<void> initialize() async {
    _notificationRepo.initialize(this);
  }

  Future<void> reset() async {
    emit(const NotificationState());
  }

  void _onNotificationReceived(
      NotificationReceived event, Emitter<NotificationState> emit) {
    print('Notification received: ${event.message.messageId}');
    emit(state.copyWith(
      status: NotificationStatus.updated,
      messages: List.from(state.messages)..add(event.message),
    ));
  }

  void _onNotificationCleared(
      NotificationCleared event, Emitter<NotificationState> emit) {
    print('Clearing notifications');
    emit(const NotificationState());
  }
}
