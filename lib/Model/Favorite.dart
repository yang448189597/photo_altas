class Favorite {
  final String firstPictureUrl;
  final String pictureListUrl;
  final String pictureListTitle;

  Favorite(this.firstPictureUrl,this.pictureListUrl, this.pictureListTitle);

  Favorite.fromJson(Map<String, dynamic> json)
      : firstPictureUrl = json['firstPictureUrl'],
         pictureListUrl = json['pictureListUrl'],
        pictureListTitle = json['pictureListTitle'];

  Map<String, dynamic> toJson() => {
        'firstPictureUrl': firstPictureUrl,
        'pictureListUrl': pictureListUrl,
        'pictureListTitle': pictureListTitle,
      };
}
