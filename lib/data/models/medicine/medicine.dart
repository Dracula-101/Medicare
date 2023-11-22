import 'medicine_manufacture.dart';
import 'medicine_price.dart';
import 'package:json_annotation/json_annotation.dart';
part 'medicine.g.dart';

@JsonSerializable()
class Medicine {
  int? productId;
  String? name;
  Manufacturer? manufacturer;
  String? form;
  String? productUrl;
  String? image;
  Price? price;
  bool? inStock;

  Medicine({
    this.productId,
    this.name,
    this.manufacturer,
    this.form,
    this.productUrl,
    this.image,
    this.price,
    this.inStock,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);
  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
