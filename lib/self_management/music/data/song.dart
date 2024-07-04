class Song{
  Song({required this.id, required this.imgUrl, required this.titleSong, required this.artistName, required this.audioPath, this.isFav = false});

  String id;
  String imgUrl;
  String titleSong;
  String artistName;
  String audioPath;
  bool isFav;

  void setFavorite(bool value) {
    isFav = value;
  }
}
