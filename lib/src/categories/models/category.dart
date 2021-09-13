import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  Category({
    this.categoryId,
    this.title,
    this.imageUrl,
    this.hasSubcategories,
    this.fullName,
    this.categoryDescription,
  });

  int? categoryId;
  String? title;
  String? imageUrl;
  int? hasSubcategories;
  String? fullName;
  String? categoryDescription;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

}
