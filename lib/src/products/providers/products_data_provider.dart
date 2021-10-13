import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/service/product_api.dart';

class ProductsDataProvider with ChangeNotifier {
  List<Product> allProducts = [];
  bool loading = false;
  ProductApi productsApi = ProductApi();

  Future<void> getProductsData({
    int? categoryId,
  }) async {
    loading = true;
    notifyListeners();
    allProducts = await productsApi.getProducts(
      categoryId: categoryId,
    );
    loading = false;
    notifyListeners();
  }
}
