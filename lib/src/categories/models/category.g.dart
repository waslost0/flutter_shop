// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Category',
      json,
      ($checkedConvert) {
        final val = Category(
          categoryId: $checkedConvert('categoryId', (v) => v as int?),
          title: $checkedConvert('title', (v) => v as String?),
          imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
          hasSubcategories:
              $checkedConvert('hasSubcategories', (v) => v as int?),
          fullName: $checkedConvert('fullName', (v) => v as String?),
          categoryDescription:
              $checkedConvert('categoryDescription', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'hasSubcategories': instance.hasSubcategories,
      'fullName': instance.fullName,
      'categoryDescription': instance.categoryDescription,
    };
