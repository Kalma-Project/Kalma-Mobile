import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/playlist_provider.dart';
import '../screen/song_page.dart';
import 'custom_slider_thumb_shape.dart';


class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playListProvider = Provider.of<PlayListProvider>(context);
    if (playListProvider.currentSongIndex == null) {
      return const SizedBox.shrink();
    }

    final currentSong = playListProvider.playlist[playListProvider.currentSongIndex!];

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction){
        playListProvider.stop();
        playListProvider.currentSongIndex == null;
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SongPage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),  color: const Color(0xffF0E7E7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 12, left: 12),
                child: Row(
                  children: [
                    Image.asset(
                      currentSong.imgUrl,
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.titleSong,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentSong.artistName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      iconSize: 24,
                      icon: Icon(
                        playListProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: () {
                        playListProvider.pauseOrResume();
                      },
                      color: const Color(0xff7D7D7D),
                    ),
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    thumbShape: CustomSliderThumbShape(
                      enabledThumbRadius: 0,
                    )),
                child: Slider(
                  activeColor: const Color(0xff2F9296),
                  inactiveColor: const Color(0xff9FCDCF),
                  value: playListProvider.currentDuration.inSeconds.toDouble(),
                  max: playListProvider.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    playListProvider.seek(Duration(seconds: value.toInt()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
