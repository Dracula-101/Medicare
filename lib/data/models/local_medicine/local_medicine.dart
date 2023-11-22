import 'package:json_annotation/json_annotation.dart';
part 'local_medicine.g.dart';

@JsonSerializable()
class LocalMedicine {
  String? medicine;
  List<String>? days;
  bool isMorning, isAfternoon, isEvening;

  LocalMedicine({
    this.medicine,
    this.days,
    this.isMorning = false,
    this.isAfternoon = false,
    this.isEvening = false,
  });

  factory LocalMedicine.fromJson(Map<String, dynamic> json) =>
      _$LocalMedicineFromJson(json);
  Map<String, dynamic> toJson() => _$LocalMedicineToJson(this);

  @override
  String toString() {
    return 'Medicine: $medicine, Days: $days';
  }
}
