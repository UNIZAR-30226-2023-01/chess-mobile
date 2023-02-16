import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    double defaultHeight = MediaQuery.of(context).size.height;
    double defaultWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.grey.shade100,
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
                    color: Colors.grey.shade300,
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: defaultHeight * 0.025,
                            top: defaultHeight * 0.075),
                        child: const Text(
                          "Elige un modo de juego",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 30, 35, 44),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultHeight * 0.15,
                        width: defaultHeight * 0.15,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Color.fromARGB(255, 30, 35, 44),
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
                    color: Colors.grey.shade300,
                    border: Border.all(
                      color: const Color.fromARGB(255, 30, 35, 44),
                      width: 1.25,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      iconSize: 0,
                      value: timeValue,
                      isExpanded: true,
                      items: timeItems.map(buildMenuItem).toList(),
                      onChanged: (value) =>
                          setState(() => timeValue = value ?? ""),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: const Color.fromARGB(255, 30, 35, 44),
                          width: 1.25,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: defaultWidth * 0.85,
                  margin: EdgeInsets.only(bottom: defaultWidth * 0.05),
                  child: Material(
                    color: const Color.fromARGB(255, 30, 35, 44),
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
                                colorFilter: const ColorFilter.mode(
                                  Color.fromARGB(255, 162, 197, 255),
                                  BlendMode.modulate,
                                ),
                                child: Image.asset('images/Competitive.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(defaultWidth * 0.04),
                            child: const Text(
                              "Partida competitiva",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 162, 197, 255),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: const Color.fromARGB(255, 30, 35, 44),
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
                        color: const Color.fromARGB(255, 162, 197, 255),
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
                                    colorFilter: const ColorFilter.mode(
                                      Color.fromARGB(255, 30, 35, 44),
                                      BlendMode.modulate,
                                    ),
                                    child: Image.asset('images/Private.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: defaultWidth * 0.07),
                                child: const Text(
                                  "Partida privada",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 30, 35, 44),
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
                        color: const Color.fromARGB(255, 162, 197, 255),
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
                                    colorFilter: const ColorFilter.mode(
                                      Color.fromARGB(255, 30, 35, 44),
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
                                child: const Text(
                                  "Torneos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 30, 35, 44),
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
                    color: const Color.fromARGB(255, 162, 197, 255),
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
                                colorFilter: const ColorFilter.mode(
                                  Color.fromARGB(255, 30, 35, 44),
                                  BlendMode.modulate,
                                ),
                                child: Image.asset('images/Computer.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(defaultWidth * 0.04),
                            child: const Text(
                              "Juega contra la IA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 30, 35, 44),
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

  DropdownMenuItem<String> buildMenuItem(String item) {
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
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
