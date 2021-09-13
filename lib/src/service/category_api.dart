import 'dart:convert';
import 'package:shop_flutter/src/categories/models/category.dart';
import 'package:shop_flutter/src/service/base_api.dart';
import 'package:http/http.dart' as http;

class CategoryApi extends BaseApi {
  final http.Client _httpClient;

  CategoryApi({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<Category>> getAllCategories() async {
    List<Category> categoryList = [];
    try {
      Uri url = Uri.http(this.baseUrl, '/api/common/category/list',
          <String, String>{'appKey': this.apiKey});
      final response = await _httpClient.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString)["data"]["categories"] as List;
        List<Category> categoryList =
            jsonMap.map((e) => Category.fromJson(e)).toList();
        return categoryList;
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      return categoryList;
    }
    return categoryList;
  }
}
