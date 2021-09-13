import 'package:flutter/material.dart';
import 'package:shop_flutter/src/models/product.dart';
import 'package:shop_flutter/src/service/product_api.dart';

class ProductDetailDataProvider with ChangeNotifier {
  Product product = Product();
  int productId = 0;
  bool loading = false;

  ProductApi productsApi = ProductApi();

  getCurrentProductData(context) async {
    loading = true;
    product = await productsApi.getProductDetail(productId);
    loading = false;
    notifyListeners();
  }
}

