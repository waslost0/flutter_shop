// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Product',
      json,
      ($checkedConvert) {
        final val = Product(
          productId: $checkedConvert('productId', (v) => v as int?),
          title: $checkedConvert('title', (v) => v as String?),
          productDescription: $checkedConvert('productDescription', (v) => v),
          price: $checkedConvert('price', (v) => v as num?),
          rating: $checkedConvert('rating', (v) => v),
          imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
          images: $checkedConvert('images',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          isAvailableForSale:
              $checkedConvert('isAvailableForSale', (v) => v as int?),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'productDescription': instance.productDescription,
      'price': instance.price,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'images': instance.images,
      'isAvailableForSale': instance.isAvailableForSale,
    };
