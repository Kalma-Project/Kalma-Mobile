import 'package:flutter/material.dart';
import '../data/song.dart';

class PlayListProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(imgUrl: 'music_images/1.jpg', titleSong: 'Home', artistName: 'Edith Whiskers', audioPath: 'audio/Edith Whiskers (Tom Rosenthal) - Home (Lyrics).mp3'),
    Song(imgUrl: 'music_images/2.jpeg', titleSong: 'Secukupnya', artistName: 'Hindia', audioPath: 'audio/Hindia - Secukupnya (Lyric Video) - OST. Nanti Kita Cerita Tentang Hari Ini.mp3'),
    Song(imgUrl: 'music_images/3.jpeg', titleSong: 'Terlalu Lama Sendiri', artistName: 'Kunto Aji', audioPath: 'audio/Kunto Aji - Terlalu Lama Sendiri.mp3'),
  ];

  //current song index
  int? _currentSongIndex;

  /*
  G E T T E R S
   */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  /*
  S E T T E R S
   */
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    notifyListeners();
  }
}