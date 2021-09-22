import 'package:flutter/material.dart';
import 'package:shop_flutter/src/product_detail/models/product.dart';
import 'package:shop_flutter/src/service/product_api.dart';

class ProductsDataProvider with ChangeNotifier {
  List<Product> allProducts = [];
  Product product = Product();
  int productId = 0;
  bool loading = false;

  ProductApi productsApi = ProductApi();

  getProductsData(context) async {
    loading = true;
    allProducts = await productsApi.getAllProducts();
    loading = false;
    notifyListeners();
  }

  getProductsOfCategory(context, categoryId) async {
    loading = true;
    allProducts = await productsApi.getAllProductsByCategoryId(categoryId);
    loading = false;
    notifyListeners();
  }
}
