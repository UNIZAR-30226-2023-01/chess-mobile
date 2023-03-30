import 'home.dart';
import '../../components/visual/my_flutter_app_icons.dart';
import 'profile.dart';
import 'ranking.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../components/buttons/back_button.dart';
import '../../components/profile_data.dart';

//ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  bool fromSignIn = false;
  BottomBar({super.key});
  BottomBar.fromSignIn({super.key}) {
    fromSignIn = true;
  }

  @override
  // ignore: no_logic_in_create_state
  State<BottomBar> createState() {
    if (fromSignIn) {
      return _BottomBarState.fromSignIn();
    } else {
      return _BottomBarState();
    }
  }
}

class _BottomBarState extends State<BottomBar> {
  _BottomBarState();
  _BottomBarState.fromSignIn() {
    selectedIndex = 1;
  }

  final UserData userData = UserData();

  static int selectedIndex = 1;

  static const List widgetOptions = [
    RankingPage(),
    HomePage(),
    ProfilePage(),
  ];

  static const List widgetOptionsAnon = [
    RankingPage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (BuildContext context) => popupBack(),
            ) ??
            false;
      },
      child: Scaffold(
        body: Center(
          child: userData.isRegistered
              ? widgetOptions.elementAt(selectedIndex)
              : widgetOptionsAnon.elementAt(selectedIndex),
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
              tabs: [
                const GButton(
                  icon: MyFlutterApp.podium,
                  text: 'CLASIFICACIÓN',
                ),
                const GButton(
                  icon: MyFlutterApp.chessknight,
                  text: 'JUEGO',
                ),
                if (userData.isRegistered)
                  const GButton(
                    icon: MyFlutterApp.user,
                    text: 'PERFIL',
                  ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  AlertDialog popupBack() {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      title: const Text("Seguro que deseas salir de la sesión?"),
      actions: [
        backButton(context, "NO", false),
        backButton(context, "SÍ", true),
      ],
    );
  }
}
