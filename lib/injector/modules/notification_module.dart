import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicare/injector/injector.dart';
import 'package:medicare/services/notification_service/local_notification_service.dart';

class NotificationModule {
  NotificationModule._();

  static final GetIt _injector = Injector.instance;

  static void init() {
    _injector
      .registerSingletonAsync<LocalNotificationService>(
          () async => LocalNotificationService(
            logger: _injector(),
          )..init(shouldSignal: true),
      signalsReady: true,
    );
  }
}