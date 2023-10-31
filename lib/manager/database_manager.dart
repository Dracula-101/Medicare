import 'dart:async';

import 'package:get_storage/get_storage.dart';

import '../services/log_service/log_service.dart';

class AppDatabaseManager {
  AppDatabaseManager({
    required LogService logService,
  }) {
    _logService = logService;
  }

  late final LogService _logService;
  late final GetStorage _storage;

  FutureOr<void> init() async {
    _storage = GetStorage();
    await _storage.initStorage;
  }

  FutureOr<void> createDatabase() async {
    try {
      await init();
    } catch (e, s) {
      _logService.e('AppDatabaseManager: createDatabase: failed', e, s);
    }
  }

  FutureOr<void> setValue({required String key, required value}) {
    try {
      _storage.write(key, value);
    } catch (e, s) {
      _logService.e('AppDatabaseManager: setValue: failed', e, s);
    }
  }

  bool? getBool({required String key}) {
    dynamic value = _storage.read(key);
    if (value is bool) {
      return value;
    } else {
      _logService.w('AppDatabaseManager: getBool: value is not bool');
      return null;
    }
  }

  double? getDouble({required String key}) {
    dynamic value = _storage.read(key);
    if (value is double) {
      return value;
    } else {
      _logService.w('AppDatabaseManager: getDouble: value is not double');
      return null;
    }
  }

  int? getInt({required String key}) {
    dynamic value = _storage.read(key);
    if (value is int) {
      return value;
    } else {
      _logService.w('AppDatabaseManager: getInt: value is not int');
      return null;
    }
  }

  String? getString({required String key}) {
    dynamic value = _storage.read(key);
    if (value is String) {
      return value;
    } else {
      _logService.w('AppDatabaseManager: getString: value is not String');
      return null;
    }
  }

  List<String>? getStringList({required String key}) {
    dynamic value = _storage.read(key);
    if (value is List<String>) {
      return value;
    } else {
      _logService
          .w('AppDatabaseManager: getStringList: value is not List<String>');
      return null;
    }
  }

  FutureOr<bool> removeEntry({required String key}) {
    try {
      _storage.remove(key);
      return true;
    } catch (e, s) {
      _logService.e('AppDatabaseManager: removeEntry: failed', e, s);
      return false;
    }
  }

  Object? getValue({required String key}) {
    return _storage.read(key);
  }

  FutureOr<void> clear() async {
    try {
      await _storage.erase();
    } catch (e, s) {
      _logService.e('AppDatabaseManager: clear: failed', e, s);
    }
  }

  FutureOr<void> deleteDatabase() async {
    try {
      await _storage.erase();
    } catch (e, s) {
      _logService.e('AppDatabaseManager: deleteDatabase: failed', e, s);
    }
  }
}
