import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initSettings = InitializationSettings(android: initSettingsAndroid);

    await notificationsPlugin.initialize(initSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Ce canal est utilisé pour les notifications importantes',
      importance: Importance.high,
      playSound: true,
    );

    final androidImplementation =
        notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    // Créer le canal de notification
    await androidImplementation?.createNotificationChannel(channel);

    // Demander la permission de notifications (ajoutez ce code ici)
    await androidImplementation?.requestNotificationsPermission();

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription:
            'Ce canal est utilisé pour les notifications importantes',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showNotification({
    int? id,
    required String title,
    required String body,
  }) async {
    await notificationsPlugin.show(
      id ?? UniqueKey().hashCode,
      title,
      body,
      notificationDetails(),
    );
  }
}
