import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/service/product_api.dart';

//TODO: make not global
class ProductsDataProvider with ChangeNotifier {
  List<Product> allProducts = [];
  bool loading = false;
  ProductApi productsApi = ProductApi();

  getProductsData({categoryId}) async {
    loading = true;
    if (categoryId != null) {
      allProducts = await productsApi.getProducts(categoryId: categoryId);
    } else {
      allProducts = await productsApi.getProducts();
    }
    loading = false;
    notifyListeners();
  }
}
