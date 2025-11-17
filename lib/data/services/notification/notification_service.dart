import 'package:devfest_bari_2025/logic/bloc/notification_bloc.dart';

abstract class NotificationService {
  Future<String> initialize(NotificationBloc bloc);

  Future<void> reset(NotificationBloc bloc);
}
