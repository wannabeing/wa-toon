import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:watoon/watoon/models/webtoon_model.dart';

class ApiService {
  static const baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  static const today = "today";

  static Future<List<WebtoonModel>> getToday() async {
    List<WebtoonModel> webtoonLists = [];
    final url = Uri.parse('$baseUrl/$today');
    final apiResponse = await http.get(url);

    if (apiResponse.statusCode == 200) {
      final List<dynamic> apiLists = jsonDecode(apiResponse.body);
      for (var apiData in apiLists) {
        final webtoon = WebtoonModel.fromJson(apiData);
        webtoonLists.add(webtoon);
      }
      return webtoonLists;
    }
    throw Error();
  }
}
