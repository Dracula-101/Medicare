import 'package:medicare/data/models/medicine/medicine_search_result.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'medicine_api_client.g.dart';

@RestApi()
abstract class MedicineApiClient {
  factory MedicineApiClient(Dio dio, {String baseUrl}) = _MedicineApiClient;

  @GET("/search")
  Future<MedicineSearchResult?> searchMedicine(@Query("name") String query);
}
