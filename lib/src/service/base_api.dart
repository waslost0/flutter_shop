import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class BaseApi {
  final http.Client httpClient = new http.Client();
  final String baseUrl = BASEURL;
  final String apiKey = APIKEY;


  Future<Map<String, dynamic>> sendGetRequest(
    String relativeUrl, {
    Map<String, dynamic>? params,
  }) async {
    Map<String, dynamic> jsonData = {};
    try {
      var preparedParams = params ?? {};
      preparedParams['appKey'] = this.apiKey;

      Uri url = Uri.http(this.baseUrl, relativeUrl, preparedParams);
      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        jsonData = json.decode(jsonString);
      }
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
    }
    return jsonData;
  }
}
