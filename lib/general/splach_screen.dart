import 'package:flutter/material.dart';
import 'package:flutter_ta/general/login/screen/login_screen.dart';
import 'package:flutter_ta/general/onboarding/screen/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard/screen/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        visible = true;
      });
    });
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboarding()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/bgsplash.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: AnimatedOpacity(
              opacity: visible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'images/kalma_logo_new.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}



