import 'package:medicare/injector/injector.dart';
import 'package:medicare/services/app_service/app_service.dart';
import 'package:medicare/services/app_service/app_service_impl.dart';
import 'package:medicare/services/auth_service/auth_service.dart';
import 'package:medicare/services/auth_service/auth_service_impl.dart';
import 'package:medicare/services/data_storage_service/data_storage_service.dart';
import 'package:medicare/services/data_storage_service/data_storage_service_impl.dart';
import 'package:medicare/services/local_storage_service/get_storage_service.dart';
import 'package:medicare/services/local_storage_service/local_storage_service.dart';
import 'package:medicare/services/local_storage_service/shared_preferences_service.dart';
import 'package:medicare/services/log_service/debug_log_service.dart';
import 'package:medicare/services/log_service/log_service.dart';
import 'package:medicare/services/ocr_service/ocr_service.dart';

class ServiceModule {
  ServiceModule._();

  static void init() {
    final injector = Injector.instance;

    injector
      ..registerFactory<LogService>(DebugLogService.new)
      ..registerSingletonAsync<LocalStorageService>(
        () async => SharedPreferencesService(logService: injector())..init(),
        signalsReady: true,
      )
      ..registerSingleton<DataStorageService>(
        DataStorageServiceImpl(
          firebaseFirestore: injector(),
        ),
      )
      ..registerSingleton<AuthService>(
        AuthServiceImpl(
          firebaseAuth: injector(),
          googleSignInClient: injector(),
          storage: injector(),
          logger: injector(),
        ),
      )
      ..registerSingletonAsync<OCRService>(
        () async => OCRService(
          logger: injector(),
        )..init(),
        signalsReady: true,
        dependsOn: [LocalStorageService],
      )
      ..registerSingletonAsync<AppService>(
          () async => AppServiceImpl(
          localStorageService: injector(),
        ),
        dependsOn: [LocalStorageService],
      );
  }
}
