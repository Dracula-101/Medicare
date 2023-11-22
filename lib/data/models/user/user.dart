// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required UserType userType,
    @Default('') String avatar,
    @Default(0) int age,
    @Default('') String gender,
    @Default('') String height,
    @Default('') String weight,
    @Default('') String? doctorId,
    @Default(false) bool? isGoogleConnected,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    return User.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }

  @override
  toString() => 'User(id: $id, name: $name, email: $email, avatar: $avatar)';
}

enum UserType {
  PATIENT,
  DOCTOR,
}
