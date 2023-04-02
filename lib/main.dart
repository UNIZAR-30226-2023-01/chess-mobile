import 'package:flutter/material.dart';
import 'pages/auth_pages/startup.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REIGN',
      theme: ThemeData(
        fontFamily: 'Urbanist',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: const Color.fromARGB(255, 250, 250, 250),
          primary: const Color.fromARGB(255, 30, 35, 44),
          secondary: const Color.fromARGB(255, 232, 209, 185),
          // const Color.fromARGB(255, 162, 197, 255),
          tertiary: const Color.fromARGB(255, 241, 232, 220),
          // const Color.fromARGB(255, 225, 225, 225),
        ),
      ),
      home: const StartupPage(),
    );
  }
}
