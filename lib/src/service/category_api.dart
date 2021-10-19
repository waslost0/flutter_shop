import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/service/base_api.dart';

class CategoryApi extends BaseApi {
  Future<List<Category>> getCategories({
    int? parentId,
  }) async {
    List<Category> categoryList = [];
    try {
      Map<String, dynamic> params = {};
      if (parentId != null) {
        params['parentId'] = parentId.toString();
      }

      Map<String, dynamic> jsonData = await sendGetRequest(
        '/api/common/category/list',
        params: params,
      );
      List listData = jsonData['data']['categories'] as List;
      categoryList = listData.map((e) => Category.fromJson(e)).toList();
      return categoryList;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return categoryList;
    }
  }
}
