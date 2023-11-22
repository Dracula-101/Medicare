import 'package:medicare/data/api/medicine/medicine_api_client.dart';
import 'package:medicare/data/models/medicine/medicine_search_result.dart';
import 'package:medicare/data/repository/medicine/medicine_repository.dart';

class MedicineRepositoryImpl implements MedicineRepository {
  MedicineRepositoryImpl({
    required this.medicineApiClient,
  });

  final MedicineApiClient medicineApiClient;

  @override
  Future<MedicineSearchResult?> searchMedicine(String query) {
    if (query.isEmpty && query.length < 5) {
      return Future.value(null);
    }
    return medicineApiClient.searchMedicine(query);
  }
}
