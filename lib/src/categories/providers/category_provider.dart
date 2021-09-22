import 'package:flutter/material.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/service/category_api.dart';

class CategoryDataProvider with ChangeNotifier {
  List<Category> allCategories = [];
  Category category = Category();
  int categoryId = 0;
  bool loading = false;
  bool isProductsByCategory = false;
  String currentCategory = '';

  CategoryApi categoriesApi = CategoryApi();

  getCategoriesData(context) async {
    loading = true;
    allCategories = await categoriesApi.getAllCategories();
    loading = false;
    notifyListeners();
  }
}
