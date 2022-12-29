class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> webtoon)
      : title = webtoon['title'],
        thumb = webtoon['thumb'],
        id = webtoon['id'];
}
