class WatoonModel {
  final String title, thumb, id;

  WatoonModel.fromJson(Map<String, dynamic> watoon)
      : title = watoon['title'],
        thumb = watoon['thumb'],
        id = watoon['id'];
}
