class WatoonDetailModel {
  final String title, about, genre, age;

  WatoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
