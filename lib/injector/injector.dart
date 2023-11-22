import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicare/injector/modules/bloc_module.dart';
import 'package:medicare/injector/modules/database_module.dart';
import 'package:medicare/injector/modules/dio_module.dart';
import 'package:medicare/injector/modules/firebase_module.dart';
import 'package:medicare/injector/modules/repository_module.dart';
import 'package:medicare/injector/modules/rest_client_module.dart';
import 'package:medicare/injector/modules/service_module.dart';
import 'package:get_it/get_it.dart';

import 'modules/notification_module.dart';

class Injector {
  Injector._();
  static GetIt instance = GetIt.instance;

  static void init() {
    DioModule.setup();
    FirebaseModule.init();
    ServiceModule.init();
    RestClientModule.init();
    DatabaseModule.init();
    RepositoryModule.init();
    BlocModule.init();
    NotificationModule.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
