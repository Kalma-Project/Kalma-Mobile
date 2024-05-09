import 'package:flutter/material.dart';
import 'package:flutter_ta/general/music/screen/song_page.dart';
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
    playListProvider.currentSongIndex = songIndex;

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
          return Container(
            height: double.infinity,
            color: const Color(0xffF6F1F1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              color: Color(0xff3D3D3D),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Musik',
                              style: TextStyle(
                                color: Color(0xff3D3D3D),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 153,
                        ),
                        itemCount: playlist.length,
                        itemBuilder: (context, index) {
                          final Song song = playlist[index];
                          return GestureDetector(
                            onTap: () => goToSong(index),
                            child: Container(
                              child: Row(
                                children: [
                                  Text((index + 1).toString()),
                                  Image.asset(song.imgUrl),
                                  Column(
                                    children: [
                                      Text(song.titleSong),
                                      Text(song.artistName),
                                    ],
                                  ),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite),)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
