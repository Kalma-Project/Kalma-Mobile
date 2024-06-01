import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ta/general/dashboard/screen/home/home_screen.dart';
import 'package:flutter_ta/general/music/screen/list_music_page.dart';
import '../../login/data/authUser.dart';
import 'journaling/screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600);
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(),
      const Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      const JournalingScreen(),
      const ListMusic(),
    ];
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return false;
          },
          child: Scaffold(
            body: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF64CDC2),
                            Color(0xFF137378)
                          ]
                      )
                  ),
                  child: Center(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  ),
                )
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color(0xFFF6F1F1),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.article),
                    label: 'Article'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.edit_square),
                    label: 'Journaling'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.music_note),
                    label: 'Music'
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF2F9296),
              unselectedItemColor: const Color(0xFF2F9296),
              onTap: _onItemTapped,
            ),
          ),
        )
    );
  }
}

