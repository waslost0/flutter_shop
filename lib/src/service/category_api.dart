import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/service/base_api.dart';

class CategoryApi extends BaseApi {
  Future<List<Category>> getAllCategories() async {
    List<Category> categoryList = [];
    try {
      Map<String, dynamic> json =
          await sendGetRequest('/api/common/category/list');
      var listJson = json['data']['categories'] as List;
      categoryList = listJson.map((e) => Category.fromJson(e)).toList();
      return categoryList;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return categoryList;
    }
  }
}
