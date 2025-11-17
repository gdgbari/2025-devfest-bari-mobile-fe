import 'package:devfest_bari_2025/data/services/notification/notification_service_impl.dart';
import 'package:devfest_bari_2025/logic/bloc/notification_bloc.dart';

class NotificationRepository {
  NotificationRepository._internal();

  static final NotificationRepository _instance = NotificationRepository._internal();

  static NotificationRepository get instance => _instance;

  final NotificationServiceImpl _notificationService = NotificationServiceImpl.instance;

  // final ScoreApi _scoreApi = ScoreApi();

  void initialize(NotificationBloc bloc) {
    _notificationService.initialize(bloc).then((token) {
      print('Notification token initialized: $token');

      // Send the token to backend
      // AuthRepo.instance.getCurrentUser().then((user) {
      //   _scoreApi.updateUser(id: user.id, fcmToken: token).then((_) {
      //     print("Notification token sent to backend for user: ${user.id}");
      //   }).catchError((error) {
      //     print("Error sending notification token to backend: $error");
      //   });
      // }).catchError((error) {
      //   print("Error getting current user: $error");
      // });
    }).catchError((error) {
      print('Error initializing notifications: $error');
    });
  }
}
