import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ta/config/token/constants.dart';
import 'package:flutter_ta/general/fail_verifymail_screen.dart';
import 'package:flutter_ta/general/register/screen/success_register_screen.dart';
import 'package:flutter_ta/general/reset_password/screen/resetpass_screen.dart';
import 'package:flutter_ta/general/success_email_verification.dart';
import 'package:flutter_ta/self_management/breathing_meditation/screen/breathing_screen.dart';
import 'package:flutter_ta/general/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_ta/general/forgot_password/screen/forgotpass_screen.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'package:flutter_ta/self_management/music/screen/song_page.dart';
import 'package:flutter_ta/general/register/screen/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'general/splach_screen.dart';
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
  bool _isInitialUriHandled = false;
  bool _navigateToSuccessEmailVerification = false;
  bool _navigateToFailVerifyMail = false;
  bool _navigateToResetPassword = false;
  String resetPassToken = '';
  final dio = Dio();

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
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        log('ini initial link dari button $initialLink');
        setState(() {
          _isInitialUriHandled = true;
        });
        await _navigateToPage(initialLink);
      }
    } catch (e) {
      // Handle exception
    }
  }

  Future<void> _navigateToPage(String link) async {
    if (link.contains('https://kalma-webapp.vercel.app/verify-email')) {
      final uri = Uri.parse(link);
      final mailToken = uri.queryParameters['token'];

      if (mailToken != null) {
        Response response = await dio.get(
            'https://kalma-backend-production.up.railway.app/api/user/verify-email/$mailToken'
        );
        if (response.statusCode == 200) {
          log('token from email: $mailToken');
          setState(() {
            _navigateToSuccessEmailVerification = true;
          });
        } else {
          setState(() {
            _navigateToFailVerifyMail = true;
          });
        }
      }
    } else if (link.contains('https://kalma-webapp.vercel.app/reset-password')) {
      final uri = Uri.parse(link);
      final passToken = uri.queryParameters['token'];

      if (passToken != null) {
        resetPassToken = passToken;
        setState(() {
          _navigateToResetPassword = true;
        });
      }
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

          if (_navigateToSuccessEmailVerification && _isInitialUriHandled) {
            return const SuccessEmailVerification();
          }

          if (_navigateToFailVerifyMail && _isInitialUriHandled) {
            return const FailVerifymailScreen();
          }

          if (_navigateToResetPassword && _isInitialUriHandled) {
            return ResetPassScreen(resetToken: resetPassToken);
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const SplashScreen();
          }

          return const DashboardScreen();
        },
      ),
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/success_register': (context) => const SuccessRegisterScreen(),
        '/forgotPassword': (context) => const ForgotPassScreen(),
        '/detailMusic': (context) => const SongPage(),
        '/breathwork': (context) => const BreathingMeditation(),
      },
    );
  }

  Future<String?> _checkForToken() async {
    await Future.delayed(const Duration(seconds: 2));
    const storage = FlutterSecureStorage();
    return await storage.read(key: accessToken);
  }
}
