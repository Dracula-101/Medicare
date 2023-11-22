import 'package:medicare/data/api/medicine/medicine_api_client.dart';
import 'package:medicare/injector/injector.dart';
import 'package:medicare/injector/modules/dio_module.dart';

class RestClientModule {
  RestClientModule._();

  static void init() {
    final injector = Injector.instance;

    injector.registerFactory<MedicineApiClient>(
      () => MedicineApiClient(
        injector(instanceName: DioModule.medicineInstance),
      ),
    );
  }
}
