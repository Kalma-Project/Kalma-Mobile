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
          if(value.isLoading){
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF64CDC2)),
            );
          }else{
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: const Color(0xffF6F1F1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,),
                        child: 
                          Text(
                            'Musik',
                            style: TextStyle(
                              color: Color(0xff3D3D3D),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                mainAxisExtent: 70,
                              ),
                              itemCount: playlist.length,
                              itemBuilder: (context, index) {
                                final Song song = playlist[index];
                                return GestureDetector(
                                  onTap: () => goToSong(index),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            (index + 1).toString(),
                                            style: GoogleFonts.plusJakartaSans(
                                                color: const Color(0xff7D7D7D),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          SizedBox(
                                            width: 44,
                                            height: 44,
                                            child: song.imgUrl.startsWith('http') || song.imgUrl.startsWith('https')
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
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                song.titleSong,
                                                style:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color(
                                                        0xff2F9296),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              Text(
                                                song.artistName,
                                                style:
                                                GoogleFonts.plusJakartaSans(
                                                    color: const Color(
                                                        0xff7D7D7D),
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: song.isFav
                                            ? const Icon(Icons.favorite)
                                            : const Icon(Icons.favorite_border),
                                        color: song.isFav
                                            ? const Color(0xff2F9296)
                                            : Colors.grey.shade700,
                                        onPressed: (){
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
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<PlayListProvider>(
                    builder: (context, value, child){
                      if(value.currentSongIndex == null){
                        return const SizedBox.shrink();
                      }
                      return const MiniPlayer();
                    },
                  ),
                ),
              ),
            ],
          );
          }
        },
      ),
    );
  }
}
