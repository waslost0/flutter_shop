import 'package:flutter/material.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/service/category_api.dart';

class CategoryDataProvider with ChangeNotifier {
  List<Category> allCategories = [];
  Category category = Category();
  bool loading = false;

  CategoryApi categoriesApi = CategoryApi();

  Future<void> getCategoriesData() async {
    loading = true;
    notifyListeners();
    allCategories = await categoriesApi.getAllCategories();
    loading = false;
    notifyListeners();
  }
}
