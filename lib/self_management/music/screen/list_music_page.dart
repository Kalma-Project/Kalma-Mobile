import 'package:flutter/material.dart';
import 'package:flutter_ta/self_management/music/screen/song_page.dart';
import 'package:flutter_ta/self_management/music/widget/mini_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/song.dart';
import '../provider/playlist_provider.dart';

class ListMusic extends StatefulWidget {
  const ListMusic({Key? key}) : super(key: key);

  @override
  State<ListMusic> createState() => _ListMusicState();
}

class _ListMusicState extends State<ListMusic> {
  late final PlayListProvider playListProvider;

  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    if (playListProvider.currentSongIndex != songIndex) {
      playListProvider.currentSongIndex = songIndex;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF64CDC2)),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              color: const Color(0xffF6F1F1),
              child: Stack(
                children: <Widget>[
                  const Positioned(
                    top: 40,
                    left: 14,
                    child: Text(
                      'Musik',
                      style: TextStyle(
                        color: Color(0xff3D3D3D),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 14,
                    right: 14,
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 30,
                          mainAxisExtent: 70,
                        ),
                        itemCount: playlist.length,
                        itemBuilder: (context, index) {
                          final Song song = playlist[index];
                          return GestureDetector(
                            onTap: () => goToSong(index),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Content on the left in the row
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      (index + 1).toString(),
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xff7D7D7D),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    SizedBox(
                                      width: 44,
                                      height: 44,
                                      child: song.imgUrl.startsWith('http') ||
                                          song.imgUrl.startsWith('https')
                                          ? Image.network(
                                        song.imgUrl,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.asset(
                                        song.imgUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        ResponsiveText(text: song.titleSong),
                                        Text(
                                          song.artistName,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xff7D7D7D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  icon: song.isFav
                                      ? const Icon(Icons.favorite)
                                      : const Icon(Icons.favorite_border),
                                  color: song.isFav
                                      ? const Color(0xff2F9296)
                                      : Colors.grey.shade700,
                                  onPressed: () {
                                    playListProvider.toggleFavorite(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 8,
                    right: 8,
                    child: Consumer<PlayListProvider>(
                      builder: (context, value, child) {
                        if (value.currentSongIndex == null) {
                          return const SizedBox.shrink();
                        }
                        return const MiniPlayer();
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
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
      constraints: BoxConstraints(maxWidth: 200.0),
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
