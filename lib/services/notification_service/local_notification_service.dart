import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:medicare/services/log_service/log_service.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../injector/injector.dart';

class LocalNotificationService {

  LocalNotificationService({
    required this.logger,
  });

  final LogService logger;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails? _platformChannelSpecifics;
  static const String _channelId = "medicare";
  static const String _channelName = "Medicare";

  Future<void> init({bool shouldSignal = false}) async {
    try{
      bool isNotificationPermissionGranted = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled() ?? false;
      if (isNotificationPermissionGranted) {
        const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
        const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );
        bool isIntialized = await _flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: (notification)async => onDidReceiveLocalNotification(notification),
        ) ?? false;
        if(isIntialized){
          const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
            _channelId,
            _channelName,
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
            ticker: 'ticker',
            enableVibration: true,
            styleInformation: BigTextStyleInformation(''),
          );
          const DarwinNotificationDetails ioPlatformSpecifics = DarwinNotificationDetails();
          _platformChannelSpecifics = const NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: ioPlatformSpecifics,
          );
          logger.i("LocalNotificationService initialized");
        }
        else{
          logger.w("LocalNotificationService initialization failed");
        }
      }
      else {
        logger.i("LocalNotificationService permission not granted");
      }

    }
    catch(e){
      logger.e("LocalNotificationService init failed", e, StackTrace.current);
    }finally{
      if(shouldSignal){
        Injector.instance.signalReady(this);
      }
    }
  }

  Future<void> requestNotificationPermission() async {
    bool isNotificationPermissionGranted = (await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.areNotificationsEnabled()) ?? false;
    if(!isNotificationPermissionGranted){
      bool isGranted = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission() ??false;
      Injector.instance.get<LogService>().i("LocalNotificationService permission granted: $isGranted");
      await init();
    }
  }

  void onDidReceiveLocalNotification(NotificationResponse notification) {

  }

  Future<void> showNotification(
    String title,
    String body,
    String payload,
  ) async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      _platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> scheduleNotification(
    String title,
    String body,
    String payload,
    DateTime dateTime,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      _platformChannelSpecifics!,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleDailyNotification(
    String title,
    String body,
    String payload,
    Duration time,
  ) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      _nextInstanceOfTime(time),
      _platformChannelSpecifics!,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}