import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ta/general/splach_screen.dart';
import 'package:flutter_ta/self_management/breathing_meditation/screen/breathing_screen.dart';
import 'package:flutter_ta/self_screening/screen/self_screening_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ta/general/music/provider/playlist_provider.dart';

import 'general/dashboard/screen/dashboard_screen.dart';
import 'general/forgot_password/screen/forgotpass_screen.dart';
import 'general/login/screen/login_screen.dart';
import 'general/music/screen/song_page.dart';
import 'general/profile/screen/change_profile_screen.dart';
import 'general/profile/screen/profile_screen.dart';
import 'general/register/screen/register_screen.dart';

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
      home: FutureBuilder<String?>(
        future: _checkForToken(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const SplashScreen();
          }

          return DashboardScreen(token: snapshot.data!);
        },
      ),
      routes: {
        '/dashboard' : (context) => const DashboardScreen(),
        '/selfScreen' : (context) => const SelfScreening(),
        '/login' : (context) => const LoginScreen(),
        '/register' : (context) => const RegisterScreen(),
        '/forgorPassword' : (context) => const ForgotPassScreen(),
        '/profile' : (context) => const Profile(),
        '/changeProfile': (context) => const ChangeProfile(),
        '/detailMusic': (context) => const SongPage(),
        '/breathwork' : (context) => const BreathingMeditation(),
      },
    );
  }

  Future<String?> _checkForToken() async {
    await Future.delayed(const Duration(seconds: 2));
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }
}
