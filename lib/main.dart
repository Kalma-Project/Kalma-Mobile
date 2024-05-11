import 'package:flutter/material.dart';

import 'package:flutter_ta/general/splach_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ta/general/music/provider/playlist_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PlayListProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
