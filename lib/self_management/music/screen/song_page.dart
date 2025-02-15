import 'package:flutter/material.dart';
import 'package:flutter_ta/self_management/music/provider/playlist_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widget/custom_slider_thumb_shape.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      //get the playlist
      final playlist = value.playlist;

      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: currentSong.imgUrl.startsWith('http') || currentSong.imgUrl.startsWith('https')
                    ? Image.network(
                  currentSong.imgUrl,
                  fit: BoxFit.fill,
                )
                    : Image.asset(
                  currentSong.imgUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(1.0),
                      Colors.black.withOpacity(1.0),
                    ],
                    stops: const [0.0, 0.7, 1.0],
                  )),
                ),
              ),
              SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_downward),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.grey.shade50,
                          ),
                          Expanded(
                            child: Text(
                              currentSong.titleSong,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.grey.shade50,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 332,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 45,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveText(text: currentSong.titleSong),
                                    Text(
                                      currentSong.artistName,
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.grey.shade800,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: playlist[value.currentSongIndex ?? 0].isFav
                                      ? const Icon(Icons.favorite)
                                      : const Icon(Icons.favorite_border),
                                  color: playlist[value.currentSongIndex ?? 0].isFav
                                      ? Colors.green.shade500
                                      : Colors.grey.shade700,
                                  onPressed: (){
                                    value.toggleFavorite(value.currentSongIndex ?? 0);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 34,
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  thumbShape: CustomSliderThumbShape(
                                enabledThumbRadius: 10,
                              )),
                              child: Slider(
                                activeColor: Colors.green.shade500,
                                inactiveColor: Colors.green.shade100,
                                min: 0,
                                max: value.totalDuration.inSeconds.toDouble(),
                                value:
                                    value.currentDuration.inSeconds.toDouble(),
                                onChanged: (double double) {},
                                onChangeEnd: (double double) {
                                  value.seek(
                                    Duration(
                                      seconds: double.toInt(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatTime(value.currentDuration),
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.grey.shade800,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    formatTime(value.totalDuration),
                                    style: GoogleFonts.plusJakartaSans(
                                        color: Colors.grey.shade800,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    value.isShuffleActive =
                                        !value.isShuffleActive;
                                    if (value.isShuffleActive) {
                                      value.shuffleNextSong;
                                    }
                                  },
                                  icon: Icon(
                                    Icons.shuffle,
                                    color: value.isShuffleActive
                                        ? Colors.green.shade500
                                        : Colors.grey.shade50,
                                  ),
                                  iconSize: 24,
                                ),
                                IconButton(
                                  onPressed: value.playPreviousSong,
                                  icon: Icon(
                                    Icons.skip_previous_sharp,
                                    color: Colors.grey.shade50,
                                  ),
                                  iconSize: 24,
                                ),
                                IconButton(
                                  onPressed: value.pauseOrResume,
                                  icon: Icon(
                                    value.isPlaying
                                        ? Icons.pause_circle
                                        : Icons.play_circle,
                                    color: Colors.grey.shade50,
                                  ),
                                  iconSize: 46,
                                ),
                                IconButton(
                                  onPressed: value.playNextSong,
                                  icon: Icon(
                                    Icons.skip_next_sharp,
                                    color: Colors.grey.shade50,
                                  ),
                                  iconSize: 24,
                                ),
                                IconButton(
                                  onPressed: () {
                                    value.isRepeatActive =
                                        !value.isRepeatActive;
                                    if (value.isRepeatActive) {
                                      value.repeatCurrentSong();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.repeat,
                                    color: value.isRepeatActive
                                        ? const Color(0xff2F9296)
                                        : Colors.grey.shade50,
                                  ),
                                  iconSize: 24,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;

  ResponsiveText({
    Key? key,
    required this.text
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    String word = text;
    List<String> words = word.split(' ');

    if (words.length > 4) {
      word = '${words.sublist(0, 4).join(' ')}\n${words.sublist(4).join(' ')}';
    }

    return Container(
      constraints: BoxConstraints(maxWidth: 450.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        overflow: TextOverflow.visible,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          color: const Color(0xff2F9296),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
