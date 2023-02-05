import 'home.dart';
import '../../components/my_flutter_app_icons.dart';
import 'profile.dart';
import 'ranking.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    RankingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 20, 25, 57),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 20, 25, 57),
            color: Colors.white,
            activeColor: const Color.fromARGB(255, 20, 25, 57),
            tabBackgroundColor: Colors.blue.shade100,
            gap: 20,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: MyFlutterApp.chessknight,
                text: 'Game',
              ),
              GButton(
                icon: MyFlutterApp.trophy,
                text: 'Ranking',
              ),
              GButton(
                icon: MyFlutterApp.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
