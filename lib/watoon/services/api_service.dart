import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:watoon/watoon/models/watoon_detail_model.dart';
import 'package:watoon/watoon/models/watoon_episode_model.dart';
import 'package:watoon/watoon/models/watoon_model.dart';

class ApiService {
  static const baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  static const today = "today";

  static Future<List<WatoonModel>> getToday() async {
    List<WatoonModel> watoonLists = [];
    final url = Uri.parse('$baseUrl/$today');
    final apiResponse = await http.get(url);

    if (apiResponse.statusCode == 200) {
      final List<dynamic> apiLists = jsonDecode(apiResponse.body);
      for (var apiData in apiLists) {
        final watoon = WatoonModel.fromJson(apiData);
        watoonLists.add(watoon);
      }
      return watoonLists;
    }
    throw Error();
  }

  static Future<WatoonDetailModel> getWatoonDetail(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final apiResponse = await http.get(url);

    if (apiResponse.statusCode == 200) {
      final watoon = jsonDecode(apiResponse.body);
      return WatoonDetailModel.fromJson(watoon);
    }
    throw Error();
  }

  static Future<List<WatoonEpisodeModel>> getEpisode(String id) async {
    List<WatoonEpisodeModel> epLists = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final apiResponse = await http.get(url);

    if (apiResponse.statusCode == 200) {
      final episodes = jsonDecode(apiResponse.body);
      for (var episode in episodes) {
        epLists.add(WatoonEpisodeModel.fromJson(episode));
      }
      return epLists;
    }

    throw Error();
  }
}
