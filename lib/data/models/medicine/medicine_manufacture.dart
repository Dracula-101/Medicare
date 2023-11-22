import 'package:json_annotation/json_annotation.dart';
part 'medicine_manufacture.g.dart';

@JsonSerializable()
class Manufacturer {
  String? name;
  String? url;

  Manufacturer({
    this.name,
    this.url,
  });

  factory Manufacturer.fromJson(Map<String, dynamic> json) =>
      _$ManufacturerFromJson(json);
  Map<String, dynamic> toJson() => _$ManufacturerToJson(this);
}
