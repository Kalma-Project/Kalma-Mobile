import 'package:flutter/material.dart';
import 'package:flutter_ta/general/article/screen/articledetail_screen.dart';
import 'package:flutter_ta/general/article/screen/articlelist_page.dart';
import 'package:flutter_ta/general/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_ta/general/forgot_password/screen/forgotpass_screen.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'package:flutter_ta/general/music/screen/list_music_page.dart';
import 'package:flutter_ta/general/music/screen/song_page.dart';
import 'package:flutter_ta/general/profile/screen/change_profile_screen.dart';
import 'package:flutter_ta/general/profile/screen/profile_screen.dart';
import 'package:flutter_ta/general/register/screen/register_screen.dart';
import 'package:flutter_ta/general/splach_screen.dart';
import 'package:flutter_ta/self_screening/screen/self_screening_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ta/general/music/provider/playlist_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/dashboard' : (context) => const DashboardScreen(),
        '/selfScreen' : (context) => const SelfScreening(),
        '/login' : (context) => const LoginScreen(),
        '/register' : (context) => const RegisterScreen(),
        '/forgorPassword' : (context) => const ForgotPassScreen(),
        '/profile' : (context) => const Profile(),
        '/changeProfile': (context) => const ChangeProfile(),
        '/detailMusic': (context) => const SongPage(),
        // '/breathwork' : (context) => const BreathWork(),
      },
    );
  }
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
