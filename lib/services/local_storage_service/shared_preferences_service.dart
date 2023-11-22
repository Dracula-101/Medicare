import 'dart:async';
import 'dart:convert';
import 'package:medicare/services/local_storage_service/local_storage_service.dart';
import 'package:medicare/services/log_service/log_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injector/injector.dart';

class SharedPreferencesService implements LocalStorageService {
  SharedPreferencesService({
    required LogService logService,
  }) {
    _logService = logService;
  }
  late final SharedPreferences _pref;
  late final LogService _logService;

  @override
  FutureOr<void> init() async {
    _pref = await SharedPreferences.getInstance();
    Injector.instance.signalReady(this);
  }

  @override
  Object? getValue({
    required String key,
  }) {
    return _pref.get(key);
  }

  @override
  FutureOr<void> setValue({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      await _pref.setString(key, value);
    } else if (value is int) {
      await _pref.setInt(key, value);
    } else if (value is double) {
      await _pref.setDouble(key, value);
    } else if (value is bool) {
      await _pref.setBool(key, value);
    } else if (value is List<String>) {
      await _pref.setStringList(key, value);
    } else {
      await _pref.setString(key, value.toString());
      _logService.w(
        'SharedPreferences did not support this type,'
        ' will save to String by toString() function',
      );
    }
  }

  @override
  bool? getBool({required String key}) {
    return _pref.getBool(key);
  }

  @override
  double? getDouble({required String key}) {
    return _pref.getDouble(key);
  }

  @override
  int? getInt({required String key}) {
    return _pref.getInt(key);
  }

  @override
  String? getString({required String key}) {
    return _pref.getString(key);
  }

  @override
  List<String>? getStringList({required String key}) {
    return _pref.getStringList(key);
  }

  @override
  FutureOr<bool> removeEntry({
    required String key,
  }) async {
    final bool result = await _pref.remove(key);
    return result;
  }

  @override
  FutureOr<void> addList({
    required String key,
    required List<Object> list,
    required Object Function(Object) toJson,
  }) async {
    // get old list
    final List<String>? oldList = getStringList(key: key);
    // convert to json
    final List<String> jsonList =
        list.map((e) => json.encode(toJson(e))).toList();
    // add new list
    jsonList.addAll(oldList ?? []);
    // save to storage
    await _pref.setStringList(key, jsonList);
  }

  @override
  List<Object>? getList(
      {required String key, required Object Function(Object p1) fromJson}) {
    final List<String>? jsonList = getStringList(key: key);
    if (jsonList == null) {
      return null;
    }
    final List<Object> list =
        jsonList.map((e) => fromJson(json.decode(e))).toList();
    return list;
  }

  @override
  FutureOr<void> clear() async {
    _pref.clear();
  }
}
