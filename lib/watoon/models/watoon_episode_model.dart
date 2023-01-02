class WatoonEpisodeModel {
  final String id, title, rating, date;

  WatoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
