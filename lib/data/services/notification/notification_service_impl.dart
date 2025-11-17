import 'dart:io';

import 'package:devfest_bari_2025/data/services/notification/notification_service.dart';
import 'package:devfest_bari_2025/logic/bloc/notification_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServiceImpl implements NotificationService {
  NotificationServiceImpl._internal();

  static final NotificationServiceImpl _instance =
      NotificationServiceImpl._internal();

  static NotificationServiceImpl get instance => _instance;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  Future<String> initialize(NotificationBloc bloc) async {
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    final token = await _fcm.getToken();
    print('FCM Token: $token');
    if (token == null) {
      throw Exception('Failed to get FCM token');
    }

    if (Platform.isIOS) {
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        bloc.add(NotificationReceived(message));
      });
    } else if (Platform.isAndroid) {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        bloc.add(NotificationReceived(message));

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: 'ic_notification',
              ),
            ),
          );
        }
      });
    }

    return token;
  }

  @override
  Future<void> reset(NotificationBloc bloc) async {
    print('Resetting NotificationApi');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // No action needed, just reset the state
    }).cancel();
  }
}
