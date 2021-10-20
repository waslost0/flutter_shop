import 'package:flutter/material.dart';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/service/product_api.dart';

class ProductsDataProvider with ChangeNotifier {
  List<Product> allProducts = [];
  bool loading = false;
  bool hasReachedMax = false;
  ProductApi productsApi = ProductApi();
  // Category? category;

  Future<void> getProductsData({
    int? categoryId,
    String? searchText,
  }) async {
    loading = true;
    notifyListeners();
    print("hasReachedMax $hasReachedMax");
    if (hasReachedMax) {
      return;
    }
    print("Offset: ${allProducts.length}");
    var newProducts = await productsApi.getProducts(
        categoryId: categoryId,
        offset: allProducts.length,
        searchText: searchText);
    // await Future.delayed(Duration(seconds: 1));
    if (newProducts.length == 0) {
      hasReachedMax = true;
      return;
    }
    allProducts.addAll(newProducts);
    loading = false;
    notifyListeners();
  }
}
