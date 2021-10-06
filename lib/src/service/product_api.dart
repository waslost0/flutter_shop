import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/service/base_api.dart';

class ProductApi extends BaseApi {
  Future<List<Product>> getProducts({
    int? categoryId,
  }) async {
    List<Product> productList = [];
    try {
      Map<String, dynamic> params = {};
      if (categoryId != null) {
        params['categoryId'] = categoryId.toString();
      }

      Map<String, dynamic> json =
          await sendGetRequest('/api/common/product/list', params: params);
      var jsonMap = json["data"] as List;
      productList = jsonMap.map((e) => Product.fromJson(e)).toList();
      return productList;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
    return productList;
  }

  Future<Product> getProductDetail(int productId) async {
    Product product = Product();
    try {
      Map<String, dynamic> json = await sendGetRequest(
        '/api/common/product/details',
        params: {'productId': productId.toString()},
      );
      json = json["data"];
      product = Product.fromJson(json);
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
    return product;
  }
}
