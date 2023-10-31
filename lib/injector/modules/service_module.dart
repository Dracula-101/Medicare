import 'package:medicare/injector/injector.dart';
import 'package:medicare/services/app_service/app_service.dart';
import 'package:medicare/services/app_service/app_service_impl.dart';
import 'package:medicare/services/local_storage_service/local_storage_service.dart';
import 'package:medicare/services/local_storage_service/shared_preferences_service.dart';
import 'package:medicare/services/log_service/debug_log_service.dart';
import 'package:medicare/services/log_service/log_service.dart';

class ServiceModule {
  ServiceModule._();

  static void init() {
    final injector = Injector.instance;

    injector
      ..registerFactory<LogService>(DebugLogService.new)
      ..registerSingleton<LocalStorageService>(
        SharedPreferencesService(
          logService: injector(),
        ),
        signalsReady: true,
      )
      ..registerSingleton<AppService>(
        AppServiceImpl(
          localStorageService: injector(),
        ),
      );
  }
}
