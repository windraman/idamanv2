
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int id = 0;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class LocalNotification{
  Future<void> _showNotification(String plainTitle, String plainBody, String payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('628', 'Idaman',
        channelDescription: 'Integrasi Dalam Genggaman',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id++, plainTitle, plainBody, notificationDetails,
        payload: payload);
  }
}