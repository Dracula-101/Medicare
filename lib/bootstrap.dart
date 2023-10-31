import 'dart:async';
import 'package:medicare/core/bloc_core/bloc_observer.dart';
import 'package:medicare/features/app/view/app.dart';
import 'package:medicare/injector/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

Future<void> bootstrap({
  AsyncCallback? firebaseInitialization,
}) async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await firebaseInitialization?.call();
      Logger.level = Level.trace;
      Injector.init();
      await Injector.instance.allReady();
      Bloc.observer = AppBlocObserver();
      runApp(const MedicareApp());
    },
    (error, stack) {},
  );
}
