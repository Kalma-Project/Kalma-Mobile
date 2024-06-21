class Song{
  Song({required this.imgUrl, required this.titleSong, required this.artistName, required this.audioPath, this.isFav = false});

  String imgUrl;
  String titleSong;
  String artistName;
  String audioPath;
  bool isFav;

  void setFavorite(bool value) {
    isFav = value;
  }
}
