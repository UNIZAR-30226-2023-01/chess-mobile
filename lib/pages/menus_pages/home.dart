import 'package:flutter/material.dart';
import '../../components/communications/socket_io.dart';
import '../../components/visual/custom_shape.dart';
import '../game_pages/game.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final timeItems = ['3 minutos', '5 minutos', '10 minutos'];
  String timeValue = '3 minutos';

  void _handleTap() async {
    await startGame(context);
  }

  @override
  Widget build(BuildContext context) {
    final double defaultHeight = MediaQuery.of(context).size.height;
    final double defaultWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: defaultHeight * 0.325,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: defaultHeight * 0.275,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: defaultHeight * 0.025,
                            top: defaultHeight * 0.075),
                        child: Text(
                          "Elige un modo de juego",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultHeight * 0.15,
                        width: defaultHeight * 0.15,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.modulate,
                          ),
                          child: Image.asset('images/Logo_app_chess_white.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: defaultHeight * 0.05,
                  width: defaultWidth * 0.85,
                  margin: EdgeInsets.only(bottom: defaultWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.25,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      //iconSize: 0,
                      value: timeValue,
                      isExpanded: true,
                      items: timeItems.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Center(
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 19,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => timeValue = value ?? ""),
                      // dropdownDecoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15),
                      //   color: Theme.of(context).colorScheme.tertiary,
                      //   border: Border.all(
                      //     color: Theme.of(context).colorScheme.primary,
                      //     width: 1.25,
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Container(
                  width: defaultWidth * 0.85,
                  margin: EdgeInsets.only(bottom: defaultWidth * 0.05),
                  child: Material(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      onTap: _handleTap,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: defaultHeight * 0.01,
                              horizontal: defaultWidth * 0.075,
                            ),
                            child: SizedBox(
                              height: defaultWidth * 0.15,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.modulate,
                                ),
                                child: Image.asset('images/Competitive.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(defaultWidth * 0.04),
                            child: Text(
                              "Partida competitiva",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 1.25,
                  indent: defaultWidth * 0.15,
                  endIndent: defaultWidth * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: defaultWidth * 0.3875,
                      margin: EdgeInsets.only(
                        top: defaultWidth * 0.05,
                      ),
                      child: Material(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GamePage()),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: defaultHeight * 0.01,
                                  horizontal: defaultWidth * 0.075,
                                ),
                                child: SizedBox(
                                  height: defaultWidth * 0.15,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.primary,
                                      BlendMode.modulate,
                                    ),
                                    child: Image.asset('images/Private.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: defaultWidth * 0.07),
                                child: Text(
                                  "Partida privada",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: defaultWidth * 0.075,
                    ),
                    Container(
                      width: defaultWidth * 0.3875,
                      margin: EdgeInsets.only(
                        top: defaultWidth * 0.05,
                      ),
                      child: Material(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GamePage()),
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: defaultHeight * 0.01,
                                  horizontal: defaultWidth * 0.075,
                                ),
                                child: SizedBox(
                                  height: defaultWidth * 0.15,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.primary,
                                      BlendMode.modulate,
                                    ),
                                    child:
                                        Image.asset('images/Tournaments.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: defaultWidth * 0.07),
                                child: Text(
                                  "Torneos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: defaultWidth * 0.85,
                  margin: EdgeInsets.only(
                    top: defaultWidth * 0.075,
                  ),
                  child: Material(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GamePage()),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: defaultHeight * 0.01,
                              horizontal: defaultWidth * 0.075,
                            ),
                            child: SizedBox(
                              height: defaultWidth * 0.15,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.modulate,
                                ),
                                child: Image.asset('images/Computer.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(defaultWidth * 0.04),
                            child: Text(
                              "Juega contra la IA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
