import 'package:flutter/material.dart';
import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/service/product_api.dart';

class ProductDetailDataProvider with ChangeNotifier {
  Product? product;
  bool loading = false;

  ProductApi productsApi = ProductApi();

  Future<void> getCurrentProductData(int productId) async {
    loading = true;
    notifyListeners();
    product = await productsApi.getProductDetail(productId);
    loading = false;
    notifyListeners();
  }
}
