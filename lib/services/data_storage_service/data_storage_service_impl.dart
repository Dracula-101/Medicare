import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/data/models/user/user.dart';
import 'package:medicare/services/data_storage_service/data_storage_service.dart';

class DataStorageServiceImpl implements DataStorageService {
  DataStorageServiceImpl({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<void> deleteCollection({required String path}) {
    try {
      CollectionReference reference =
          _firebaseFirestore.collection(path.split('/')[0]);
      List<Future<void>> futures = [];
      for (var i = 0; i < 100; i++) {
        futures.add(reference.limit(100).get().then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        }));
      }
      return Future.wait(futures);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteData({required String path}) {
    try {
      return _firebaseFirestore.doc(path).delete();
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteDocument({required String path}) {
    try {
      return _firebaseFirestore.doc(path).delete();
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteField({required String path, required String field}) {
    try {
      return _firebaseFirestore.doc(path).update({field: FieldValue.delete()});
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteFields(
      {required String path, required List<String> fields}) {
    try {
      Map<String, dynamic> map = {};
      for (var element in fields) {
        map[element] = FieldValue.delete();
      }
      return _firebaseFirestore.doc(path).update(map);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> exist({required String path}) {
    try {
      return _firebaseFirestore.doc(path).get().then((value) => value.exists);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>?> getData({required String path}) {
    try {
      return _firebaseFirestore.doc(path).get().then((value) => value.data());
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) {
    try {
      return _firebaseFirestore.doc(path).set(data);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<User?> getUser({required String? id}) {
    try {
      if (id == null) {
        return Future.value(null);
      }
      return _firebaseFirestore.collection('users').doc(id).get().then((value) {
        if (value.exists) {
          return User.fromJson(value.data()!);
        } else {
          return null;
        }
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> setUser({required User user}) {
    try {
      return _firebaseFirestore
          .collection('users')
          .doc(user.id)
          .set(user.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
