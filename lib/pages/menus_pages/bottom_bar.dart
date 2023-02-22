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
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                title: const Text("Seguro que deseas salir de la sesión?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      padding: const EdgeInsets.symmetric(vertical: 12.5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "NO",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      padding: const EdgeInsets.symmetric(vertical: 12.5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          "SÍ",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
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
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: GNav(
              backgroundColor: Theme.of(context).colorScheme.primary,
              color: Colors.white,
              activeColor: Theme.of(context).colorScheme.primary,
              tabBackgroundColor: Theme.of(context).colorScheme.secondary,
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
