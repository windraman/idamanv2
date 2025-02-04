// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:idaman/helper/utilities.dart';
//
// Future<void> createTabeBasicNotification(int uid, String title, String body, String photo, NotificationLayout layout) async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: uid,
//       channelKey: 'idaman_notifications',
//       title: title,
//       body: body,
//       bigPicture: photo,
//       notificationLayout: layout,
//     ),
//   );
// }
//
// Future<void> createPlantFoodNotification() async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: createUniqueId(),
//       channelKey: 'idaman_notifications',
//       title:
//       "Sampaikan aspirasi anda kepada kami",
//       body: 'Idaman',
//       bigPicture: 'asset://assets/notification_map.png',
//       notificationLayout: NotificationLayout.BigPicture,
//     ),
//   );
// }
//
// Future<void> createWaterReminderNotification(
//     NotificationWeekAndTime notificationSchedule) async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: createUniqueId(),
//       channelKey: 'scheduled_channel',
//       title: '${Emojis.wheater_droplet} Add some water to your plant!',
//       body: 'Water your plant regularly to keep it healthy.',
//       notificationLayout: NotificationLayout.Default,
//     ),
//     actionButtons: [
//       NotificationActionButton(
//         key: 'MARK_DONE',
//         label: 'Mark Done',
//       ),
//     ],
//     schedule: NotificationCalendar(
//       weekday: notificationSchedule.dayOfTheWeek,
//       hour: notificationSchedule.timeOfDay.hour,
//       minute: notificationSchedule.timeOfDay.minute,
//       second: 0,
//       millisecond: 0,
//       repeats: true,
//     ),
//   );
// }
//
// Future<void> cancelScheduledNotifications() async {
//   await AwesomeNotifications().cancelAllSchedules();
// }