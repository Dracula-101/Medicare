import 'package:medicare/injector/injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    final injector = Injector.instance;

    // injector.registerFactory<DogImageRandomRepository>(
    //   () => DogImageRandomRepositoryImpl(
    //     dogApiClient: injector(),
    //   ),
    // );
  }
}
