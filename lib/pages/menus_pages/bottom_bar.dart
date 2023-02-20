import 'home.dart';
import '../../components/visual/my_flutter_app_icons.dart';
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
  static int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    RankingScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Deseas salir de la sesión?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("NO"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("SÍ"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 30, 35, 44),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GNav(
              backgroundColor: const Color.fromARGB(255, 30, 35, 44),
              color: Colors.white,
              activeColor: const Color.fromARGB(255, 30, 35, 44),
              tabBackgroundColor: const Color.fromARGB(255, 162, 197, 255),
              gap: 20,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: MyFlutterApp.podium,
                  text: 'CLASIFICACIÓN',
                ),
                GButton(
                  icon: MyFlutterApp.chessknight,
                  text: 'JUEGO',
                ),
                GButton(
                  icon: MyFlutterApp.user,
                  text: 'PERFIL',
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
      ),
    );
  }
}
