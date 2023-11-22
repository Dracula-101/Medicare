import 'package:medicare/data/models/user/user.dart';

abstract class DataStorageService {
  Future<Map<String, dynamic>?> getData({required String path});

  Future<void> setData(
      {required String path, required Map<String, dynamic> data});

  Future<void> deleteData({required String path});

  Future<void> deleteCollection({required String path});

  Future<void> deleteDocument({required String path});

  Future<void> deleteField({required String path, required String field});

  Future<void> deleteFields(
      {required String path, required List<String> fields});

  Future<bool> exist({required String path});

  Future<User?> getUser({required String? id});

  Future<void> setUser({required User user});
}
