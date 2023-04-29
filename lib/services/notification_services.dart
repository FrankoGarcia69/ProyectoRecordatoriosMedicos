import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/recipe.dart';
import '../models/recipetype.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestSoundPermission: true,
          requestBadgePermission: true);

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> scheduleNotification(Recipe recipe) async {
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          'repeatDailyAtTime_channel_id', 'repeatDailyAtTime_channel_name',
          importance: Importance.max);

  const DarwinNotificationDetails darwinNotificationDetails =
      DarwinNotificationDetails();

  const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: darwinNotificationDetails);

  var hour = int.parse(recipe.starttime![0] + recipe.starttime![1]);
  var ogValue = hour;
  var minute = int.parse(recipe.starttime![2] + recipe.starttime![3]);

  // var dateTime = DateTime(
  //   DateTime.now().year,
  //   DateTime.now().month,
  //   DateTime.now().day, hour, minute,0
  //   );
  tz.initializeTimeZones();

  for (int i = 0; i < (24 / recipe.interval!).floor(); i++) {
    if (hour + (recipe.interval! * i) > 23) {
      hour = hour + (recipe.interval! * i) - 24;
    } else {
      hour = hour + (recipe.interval! * i);
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse(recipe.notificationid![i]),
        'Recordatorio ${recipe.recipename}',
        recipe.recipetype.toString() != RecipeType.none.toString()
            ? 'Es tiempo de tomar / Aplicar tu medicina en ${recipe.recipetype!.toLowerCase()}, de acuerdo a tu planificacion'
            : 'Es tiempo de tomar / Aplicar tu medicina, de acuerdo a tu planificacion',
        tz.TZDateTime.from(
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, hour, minute, 0),
            tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    hour = ogValue;
  }
}
