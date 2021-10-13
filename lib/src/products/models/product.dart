import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';


@JsonSerializable()
class Product {
  Product({
    this.productId,
    this.title,
    this.productDescription,
    this.price,
    this.rating,
    this.imageUrl,
    this.images,
    this.isAvailableForSale,
  });

  int? productId;
  String? title;
  String? productDescription;
  num? price;
  num? rating;
  String? imageUrl;
  List<String>? images;
  int? isAvailableForSale;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

}
