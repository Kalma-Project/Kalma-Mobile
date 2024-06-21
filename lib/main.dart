import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ta/config/token/constants.dart';
import 'package:flutter_ta/general/register/screen/success_register_screen.dart';
import 'package:flutter_ta/general/splach_screen.dart';
import 'package:flutter_ta/general/success_email_verification.dart';
import 'package:flutter_ta/self_management/breathing_meditation/screen/breathing_screen.dart';
import 'package:flutter_ta/general/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_ta/general/forgot_password/screen/forgotpass_screen.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'package:flutter_ta/self_management/music/screen/song_page.dart';
import 'package:flutter_ta/general/register/screen/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'self_management/music/provider/playlist_provider.dart';
import 'dart:developer';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayListProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> initUniLinks() async {

    _sub = linkStream.listen((String? link) {
      if (link != null) {
        _navigateToPage(link);
      }
    }, onError: (err) {
      // Handle exception
    });

    // For handling app links on app start
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _navigateToPage(initialLink);
      }
    } catch (e) {
      // Handle exception
    }
  }

  Future<void> _navigateToPage(String link) async {
    if (link.contains('https://kalma-webapp.vercel.app/verify-email')) {
      // Parse the URL and extract the token
      final uri = Uri.parse(link);
      final token = uri.queryParameters['token'];

      if (token != null) {
        const storage = FlutterSecureStorage();
        await storage.write(key: accessToken, value: token);
        log(token);
      }

      // Navigate to the specific page in your app
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessEmailVerification()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: _checkForToken(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF64CDC2)));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const SplashScreen();
          }

          return const DashboardScreen();
        },
      ),
      routes: {
        '/dashboard' : (context) => const DashboardScreen(),
        '/login' : (context) => const LoginScreen(),
        '/register' : (context) => const RegisterScreen(),
        '/success_register' : (context) => const SuccessRegisterScreen(),
        '/forgotPassword' : (context) => const ForgotPassScreen(),
        '/detailMusic': (context) => const SongPage(),
        '/breathwork' : (context) => const BreathingMeditation(),
      },
    );
  }

  Future<String?> _checkForToken() async {
    await Future.delayed(const Duration(seconds: 2));
    const storage = FlutterSecureStorage();
    return await storage.read(key: accessToken);
  }
}
