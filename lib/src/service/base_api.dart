import 'package:http/http.dart' as http;

class BaseApi {
  BaseApi({http.Client? httpClient});

  final String baseUrl = 'ostest.whitetigersoft.ru';
  final String apiKey =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';

}
