import 'package:shop_flutter/src/products/models/product.dart';
import 'package:shop_flutter/src/service/base_api.dart';

class ProductApi extends BaseApi {
  Future<List<Product>> getProducts({
    int offset = 0,
    int? categoryId,
    String? searchText
  }) async {
    List<Product> productList = [];
    try {
      Map<String, dynamic> params = {
        "offset": offset.toString(),
      };

      params['text'] = searchText ?? '';
      print(params['text']);
      if (categoryId != null) {
        params['categoryId'] = categoryId.toString();
      }

      Map<String, dynamic> json = await sendGetRequest(
        '/api/common/product/list',
        params: params,
      );

      List listData = json["data"] as List;
      productList = listData.map((e) => Product.fromJson(e)).toList();
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
    return productList;
  }

  Future<Product> getProductDetail(
    int productId,
  ) async {
    Product product = Product();
    try {
      Map<String, dynamic> jsonData = await sendGetRequest(
        '/api/common/product/details',
        params: {
          'productId': productId.toString(),
        },
      );
      jsonData = jsonData["data"];
      product = Product.fromJson(jsonData);
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
    return product;
  }
}
