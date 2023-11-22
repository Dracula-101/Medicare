import 'package:medicare/data/models/medicine/medicine_search_result.dart';

abstract class MedicineRepository {
  Future<MedicineSearchResult?> searchMedicine(String query);
}
