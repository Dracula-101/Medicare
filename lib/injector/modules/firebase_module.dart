import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medicare/injector/injector.dart';

class FirebaseModule {
  FirebaseModule._();

  static final GetIt _injector = Injector.instance;

  static FirebaseAuth get firebaseAuth => _injector<FirebaseAuth>();

  static void init() {
    _injector
      ..registerSingleton<FirebaseAuth>(
        FirebaseAuth.instance,
      )
      ..registerSingleton<GoogleSignIn>(
        GoogleSignIn(),
      )
      ..registerSingleton<FirebaseFirestore>(
        FirebaseFirestore.instance,
      );
  }
}
