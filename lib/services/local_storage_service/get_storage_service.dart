import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:medicare/injector/injector.dart';
import 'package:medicare/services/log_service/log_service.dart';

import 'local_storage_service.dart';

class GetStorageService implements LocalStorageService {
  late final GetStorage _storage;
  late final LogService _logService;

  GetStorageService({
    required LogService logService,
  }) {
    _logService = logService;
    init();
  }

  @override
  FutureOr<void> init() {
    _storage = GetStorage();
    Injector.instance.signalReady(this);
  }

  @override
  FutureOr<void> setValue({required String key, required value}) {
    try {
      _storage.write(key, value);
    } catch (e, s) {
      _logService.e('GetStorageService: setValue: failed', e, s);
    }
  }

  @override
  bool? getBool({required String key}) {
    dynamic value = _storage.read(key);
    if (value is bool) {
      return value;
    } else {
      _logService.w('GetStorageService: getBool: value is not bool');
      return null;
    }
  }

  @override
  double? getDouble({required String key}) {
    dynamic value = _storage.read(key);
    if (value is double) {
      return value;
    } else {
      _logService.w('GetStorageService: getDouble: value is not double');
      return null;
    }
  }

  @override
  int? getInt({required String key}) {
    dynamic value = _storage.read(key);
    if (value is int) {
      return value;
    } else {
      _logService.w('GetStorageService: getInt: value is not int');
      return null;
    }
  }

  @override
  String? getString({required String key}) {
    dynamic value = _storage.read(key);
    if (value is String) {
      return value;
    } else {
      _logService.w('GetStorageService: getString: value is not String');
      return null;
    }
  }

  @override
  List<String>? getStringList({required String key}) {
    dynamic value = _storage.read(key);
    if (value is List<String>) {
      return value;
    } else {
      _logService
          .w('GetStorageService: getStringList: value is not List<String>');
      return null;
    }
  }

  @override
  Object? getValue({required String key}) {
    return _storage.read(key);
  }

  @override
  FutureOr<bool> removeEntry({required String key}) {
    try {
      _storage.remove(key);
      return true;
    } catch (e, s) {
      _logService.e('GetStorageService: removeEntry: failed', e, s);
      return false;
    }
  }
}
