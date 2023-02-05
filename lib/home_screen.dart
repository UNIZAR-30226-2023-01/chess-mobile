import 'package:flutter/material.dart';

import 'gamepage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final timeItems = ['3 minutes', '5 minutes', '10 minutes'];
  String timeValue = '3 minutes';

  @override
  Widget build(BuildContext context) {
    double defaultHeight = MediaQuery.of(context).size.height;
    double defaultWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: defaultHeight * 0.35,
          child: Stack(
            children: <Widget>[
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: defaultHeight * 0.3,
                  color: Colors.blue.shade100,
                ),
              ),
              Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: defaultHeight * 0.05,
                          top: defaultHeight * 0.075),
                      child: Text(
                        "Choose a game mode",
                        style: TextStyle(
                          fontSize: defaultHeight * 0.025,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 20, 25, 57),
                        ),
                      ),
                    ),
                    Container(
                      height: defaultHeight * 0.15,
                      width: defaultHeight * 0.15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/caballo.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: defaultWidth * 0.9,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: defaultHeight * 0.05,
                width: defaultWidth * 0.9,
                margin: EdgeInsets.all(defaultWidth * 0.04),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: DropdownButton<String>(
                  iconSize: 0,
                  value: timeValue,
                  isExpanded: true,
                  items: timeItems.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => timeValue = value ?? ""),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: defaultWidth * 0.39,
                    margin: EdgeInsets.only(
                      right: defaultWidth * 0.04,
                      left: defaultWidth * 0.04,
                      bottom: defaultWidth * 0.04,
                    ),
                    child: Material(
                      color: Color.fromARGB(255, 20, 25, 57),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GamePage()),
                          );
                        },
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: defaultWidth * 0.04),
                                height: defaultWidth * 0.22,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('lib/images/trofeo.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(defaultWidth * 0.04),
                                child: const Text(
                                  "Competitive\nmatch",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: defaultWidth * 0.39,
                    margin: EdgeInsets.only(
                      right: defaultWidth * 0.04,
                      bottom: defaultWidth * 0.04,
                    ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GamePage()),
                          );
                        },
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: defaultWidth * 0.04),
                                height: defaultWidth * 0.22,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('lib/images/diana.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(defaultWidth * 0.04),
                                child: const Text(
                                  "Training\nmatch",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 20, 25, 57),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: defaultWidth * 0.9,
          margin: EdgeInsets.only(top: defaultWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Container(
            width: defaultWidth * 0.82,
            margin: EdgeInsets.all(defaultWidth * 0.04),
            child: Material(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GamePage()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(defaultWidth * 0.04),
                  child: const Text(
                    "Play with friends!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 20, 25, 57),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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
            fontSize: 18,
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
