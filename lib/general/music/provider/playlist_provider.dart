import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/song.dart';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayListProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        imgUrl: 'music_images/1.jpg',
        titleSong: 'Home',
        artistName: 'Edith Whiskers',
        audioPath: 'audio/Edith Whiskers (Tom Rosenthal) - Home (Lyrics).mp3'),
    Song(
        imgUrl: 'music_images/2.jpeg',
        titleSong: 'Secukupnya',
        artistName: 'Hindia',
        audioPath:
        'audio/Hindia - Secukupnya (Lyric Video) - OST. Nanti Kita Cerita Tentang Hari Ini.mp3'),
    Song(
        imgUrl: 'music_images/3.jpeg',
        titleSong: 'Terlalu Lama Sendiri',
        artistName: 'Kunto Aji',
        audioPath: 'audio/Kunto Aji - Terlalu Lama Sendiri.mp3'),
  ];

  //current song index
  int? _currentSongIndex;

  // Store the current audio path
  String? _currentAudioPath;

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlayListProvider() {
    loadFavoriteStatus();
    listenToDuration();
  }

  //initially not playing
  bool _isPlaying = false;
  bool _isShuffleActive = false;
  bool _isRepeatActive = false;

  //play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    if (_isPlaying && _currentAudioPath == path) {
      // If the current song is already playing, do nothing
      return;
    }
    _isPlaying = true;
    _currentAudioPath = path;

    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(AssetSource(path)); //play the selected song
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a specific position in the current song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        //go to next song
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        //if it's the last song, go to first song
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPreviousSong() {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //listen to Duration
  void listenToDuration() {
    //listen for the current duration
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      if (_isShuffleActive) {
        shuffleNextSong(); // Jalankan fungsi shuffle jika shuffled aktif
      }if (_isRepeatActive) {
        repeatCurrentSong();
      } else {
        playNextSong(); // Jalankan fungsi playNextSong jika shuffled tidak aktif
      }
    });
  }

  //shuffle next song
  void shuffleNextSong() {
    if (_currentSongIndex != null) {
      final random = Random();
      int newIndex = _currentSongIndex!;
      while (newIndex == _currentSongIndex) {
        newIndex = random.nextInt(_playlist.length-1);
      }
      currentSongIndex = newIndex;
      notifyListeners();
    }
  }

  //repeat the current song after the current son finished
  void repeatCurrentSong(){
    if (_currentSongIndex != null) {
      currentSongIndex = _currentSongIndex;
    }
  }

  //favorite song
  void toggleFavorite(int songIndex) async {
    if (songIndex >= 0 && songIndex < _playlist.length) {
      _playlist[songIndex].isFav = !_playlist[songIndex].isFav;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFavorite_$songIndex', _playlist[songIndex].isFav);

      notifyListeners();
    }
  }

  void loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < _playlist.length; i++) {
      bool isFavorite = prefs.getBool('isFavorite_$i') ?? false;
      _playlist[i].setFavorite(isFavorite);
    }
    notifyListeners();
  }

  //dispose audio player

  /*
  G E T T E R S
   */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isShuffleActive => _isShuffleActive;
  bool get isRepeatActive => _isRepeatActive;

  /*
  S E T T E R S
   */
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }

  set isShuffleActive(bool newValue) {
    _isShuffleActive = newValue;
    notifyListeners();
  }

  set isRepeatActive(bool newValue) {
    _isRepeatActive = newValue;
    notifyListeners();
  }
}