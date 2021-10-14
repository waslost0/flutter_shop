import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/service/product_api.dart';

class ProductsDataProvider with ChangeNotifier {
  List<Product> allProducts = [];
  List<Product> newProducts = [];
  bool loading = false;
  bool hasReachedMax = false;
  ProductApi productsApi = ProductApi();


  Future<void> getProductsData({
    int? categoryId,
  }) async {
    loading = true;
    notifyListeners();
    newProducts = await productsApi.getProducts(
      categoryId: categoryId,
    );
    allProducts.addAll(newProducts);
    loading = false;
    notifyListeners();
  }
}
