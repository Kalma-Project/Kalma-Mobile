import 'package:flutter/material.dart';
import 'package:flutter_ta/general/music/provider/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      //get the playlist
      final playlist = value.playlist;

      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(currentSong.imgUrl, fit: BoxFit.fill,),
              ShaderMask(
                shaderCallback: (rect){
                  return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.0),
                      ],
                    stops: [0.0, 0.3, 0.5]
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstOut,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(1.0),
                          ]
                      )
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
