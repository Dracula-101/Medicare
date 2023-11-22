import 'package:get_it/get_it.dart';
import 'package:medicare/injector/injector.dart';
import 'package:medicare/manager/database_manager.dart';

class DatabaseModule {
  DatabaseModule._();

  static final GetIt _injector = Injector.instance;

  static void init() {
    _injector.registerSingletonAsync<AppDatabaseManager>(() async {
      final AppDatabaseManager databaseManager = AppDatabaseManager(
        logService: _injector(),
      );
      await databaseManager.createDatabase();
      return databaseManager;
    });

    _initRepositories();
  }

  static void _initRepositories() {
    // Initialize repositories here
  }
}
