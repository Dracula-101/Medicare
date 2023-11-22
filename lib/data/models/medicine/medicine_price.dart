import 'package:json_annotation/json_annotation.dart';
part 'medicine_price.g.dart';

@JsonSerializable()
class Price {
  int? mrp;
  int? finalPrice;
  int? discountPerc;

  Price({
    this.mrp,
    this.finalPrice,
    this.discountPerc,
  });

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}
