import 'package:flutter/material.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/service/category_api.dart';

class CategoryDataProvider with ChangeNotifier {
  List<Category> listCategories = [];
  Category category = Category();
  bool loading = false;

  CategoryApi categoriesApi = CategoryApi();

  Future<void> getCategoriesData({
    int? parentId,
  }) async {
    loading = true;
    notifyListeners();
    listCategories = await categoriesApi.getCategories(
      parentId: parentId,
    );
    loading = false;
    notifyListeners();
  }
}
