class Favorite {
  final String pictureListUrl;
  final String pictureListTitle;

  Favorite(this.pictureListUrl, this.pictureListTitle);

  Favorite.fromJson(Map<String, dynamic> json)
      : pictureListUrl = json['pictureListUrl'],
        pictureListTitle = json['pictureListTitle'];

  Map<String, dynamic> toJson() => {
        'pictureListUrl': pictureListUrl,
        'pictureListTitle': pictureListTitle,
      };
}
