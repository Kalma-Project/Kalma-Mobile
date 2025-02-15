import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ta/config/api_service.dart';
import 'package:flutter_ta/config/requests/general/service.dart';
import 'package:flutter_ta/config/token/constants.dart';
import 'package:flutter_ta/general/dashboard/screen/home/home_screen.dart';
import 'package:flutter_ta/general/email_verification.dart';
import 'package:flutter_ta/self_management/music/screen/list_music_page.dart';
import 'package:flutter_ta/self_management/breathing_meditation/screen/breathing_screen.dart';
import '../../../model/general/general.dart';
import '../../../self_management/journaling/screen/journaling_screen.dart';
import '../../../widget/action_alert.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final AuthService _getUserProperty = AuthService();
  ApiService apiService = ApiService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const TextStyle optionStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600);
  late List<Widget> _widgetOptions;
  UserProperty? userProperty;

  @override
  void initState() {
    super.initState();
    _fetchUserProperty();
  }

  Future<void> _fetchUserProperty() async {
    userProperty = await _getUserProperty.getUserProperty();
    String? token = await _secureStorage.read(key: accessToken);
    setState(() {
      if (userProperty != null && token != null) {
        _widgetOptions = <Widget>[
          HomeScreen(
              key: ValueKey<int>(_selectedIndex),
              user: token,
              userProperty: userProperty!,
            onItemTapped: _onItemTapped,
          ),
           const JournalingPage(),
           const BreathingMeditation(),
           const ListMusic(),
        ];
      }
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => const EmailVerification())
        // );
    });
  }

  void _onItemTapped(int index) async {
    if (index == 0) {
      String? token = await _secureStorage.read(key: accessToken);
      setState(() {
        _selectedIndex = index;
        _widgetOptions[0] = HomeScreen(
          key: ValueKey<int>(DateTime.now().millisecondsSinceEpoch),
          user: token!,
          userProperty: userProperty!,
          onItemTapped: _onItemTapped,
        );
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'JakartaSans'),
      home: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) => ActionAlert(
              title: 'Keluar Aplikasi',
              message: 'Apakah anda yakin akan keluar dari aplikasi?',
              action1: () => Navigator.of(context).pop(false),
              action2: () {
                Navigator.of(context).pop(true);
                SystemNavigator.pop();
              },
            ),
          );
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF64CDC2), Color(0xFF137378)],
                ),
              ),
              child: Center(
                child: userProperty == null
                    ? const CircularProgressIndicator(color:Color(0xFF64CDC2),)
                    : _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFFF6F1F1),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(icon: Icon(Icons.edit_square), label: 'Jurnal Harian'),
              BottomNavigationBarItem(icon: Icon(Icons.air_sharp), label: 'Pernapasan'),
              BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Musik'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFF2F9296),
            unselectedItemColor: const Color(0xFF2F9296),
            onTap: (index) => _onItemTapped(index),
          ),
        ),
      ),
    );
  }
}
