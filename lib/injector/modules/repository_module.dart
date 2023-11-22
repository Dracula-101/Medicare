import 'package:get_it/get_it.dart';
import 'package:medicare/data/repository/medicine/medicine_repository.dart';
import 'package:medicare/data/repository/medicine/medicine_repository_impl.dart';
import 'package:medicare/injector/injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    GetIt injector = Injector.instance;

    injector.registerFactory<MedicineRepository>(
      () => MedicineRepositoryImpl(
        medicineApiClient: injector(),
      ),
    );
  }
}
