import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_flutter/src/models/product.dart';
import 'package:shop_flutter/src/service/base_api.dart';

class ProductApi extends BaseApi {
  final http.Client _httpClient;

  ProductApi({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Product>> getAllProducts() async {
    List<Product> productList = [];
    try {
      Uri url = Uri.http(this.baseUrl, '/api/common/product/list',
          <String, String>{'appKey': this.apiKey});
      final response = await _httpClient.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString)["data"] as List;
        List<Product> productList =
            jsonMap.map((e) => Product.fromJson(e)).toList();
        return productList;
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return productList;
    }
    return productList;
  }

  Future<List<Product>> getAllProductsByCategoryId(int categoryId) async {
    List<Product> productList = [];
    try {
      Uri url = Uri.http(this.baseUrl, '/api/common/product/list',
          <String, dynamic>{'appKey': this.apiKey, 'categoryId': categoryId.toString()});
      final response = await _httpClient.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString)["data"] as List;
        List<Product> productList =
            jsonMap.map((e) => Product.fromJson(e)).toList();
        return productList;
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return productList;
    }
    return productList;
  }

  Future<Product> getProductDetail(int productId) async {
    Product product = Product();
    try {
      Uri url = Uri.http(
          this.baseUrl, '/api/common/product/details', <String, String>{
        'appKey': this.apiKey,
        'productId': productId.toString()
      });
      final response = await _httpClient.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString)["data"];
        product = Product.fromJson(jsonMap);
        return product;
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return product;
    }
    return product;
  }
}
