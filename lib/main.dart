import 'package:firebase_core/firebase_core.dart';

import 'bootstrap.dart';

Future<void> main() async {
  await bootstrap(
    firebaseInitialization: () async {
      // await Firebase.initializeApp();
    },
  );
}
