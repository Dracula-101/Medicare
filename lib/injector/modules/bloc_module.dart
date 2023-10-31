import 'package:medicare/features/app/bloc/app_bloc.dart';
import 'package:medicare/injector/injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    final injector = Injector.instance;

    injector.registerLazySingleton<AppBloc>(
      () => AppBloc(
        appService: injector(),
        logService: injector(),
      ),
    );
    // ..registerFactory<DogImageRandomBloc>(
    //   () => DogImageRandomBloc(
    //     dogImageRandomRepository: injector(),
    //     dogImageLocalRepository: kIsWeb ? null : injector(),
    //     logService: injector(),
    //   ),
    // )
    // ..registerFactory<DemoBloc>(
    //   () => DemoBloc(
    //     dogImageRandomRepository: injector(),
    //     logService: injector(),
    //   ),
    // );
  }
}
