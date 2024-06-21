class Song {
  final String imgUrl;
  final String titleSong;
  final String artistName;
  final String audioPath;
  bool isFav;

  Song({
    required this.imgUrl,
    required this.titleSong,
    required this.artistName,
    required this.audioPath,
    this.isFav = false,
  });


  void setFavorite(bool isFavorite) {
    isFav = isFavorite;
  }
}
