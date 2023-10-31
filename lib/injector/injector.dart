import 'package:medicare/injector/modules/bloc_module.dart';
import 'package:medicare/injector/modules/database_module.dart';
import 'package:medicare/injector/modules/repository_module.dart';
import 'package:medicare/injector/modules/service_module.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();
  static GetIt instance = GetIt.instance;

  static void init() {
    ServiceModule.init();
    DatabaseModule.init();
    RepositoryModule.init();
    BlocModule.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
