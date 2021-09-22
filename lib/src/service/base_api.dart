import 'package:http/http.dart' as http;
import '../consts/contst.dart';

class BaseApi {
  BaseApi({http.Client? httpClient});
  final String baseUrl = BASEURL;
  final String apiKey = APIKEY;

}
