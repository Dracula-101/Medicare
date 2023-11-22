import 'medicine.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine_search_result.g.dart';

@JsonSerializable()
class MedicineSearchResult {
  String? status;
  String? message;
  List<Medicine>? data;

  MedicineSearchResult({
    this.status,
    this.message,
    this.data,
  });

  factory MedicineSearchResult.fromJson(Map<String, dynamic> json) =>
      _$MedicineSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineSearchResultToJson(this);
}
