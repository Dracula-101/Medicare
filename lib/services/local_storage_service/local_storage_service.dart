import 'dart:async';

abstract class LocalStorageService {
  FutureOr<void> init();

  FutureOr<void> setValue({
    required String key,
    required dynamic value,
  });

  Object? getValue({
    required String key,
  });

  String? getString({
    required String key,
  });

  int? getInt({
    required String key,
  });

  double? getDouble({
    required String key,
  });

  bool? getBool({
    required String key,
  });

  List<String>? getStringList({
    required String key,
  });

  FutureOr<bool> removeEntry({
    required String key,
  });

  // list
  FutureOr<void> addList({
    required String key,
    required List<Object> list,
    required Object Function(Object) toJson,
  });

  // get list
  List<Object>? getList({
    required String key,
    required Object Function(Object) fromJson,
  });

  FutureOr<void> clear();
}
