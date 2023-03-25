import 'package:flutter/material.dart';
import 'pages/auth_pages/startup.dart';
import 'package:flutter/services.dart';
import 'components/visual/screen_size.dart';

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

    defaultHeight = MediaQuery.of(context).size.height;
    defaultWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REIGN',
      theme: ThemeData(
        fontFamily: 'Urbanist',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Colors.grey.shade100,
          primary: const Color.fromARGB(255, 30, 35, 44),
          secondary: const Color.fromARGB(255, 162, 197, 255),
          tertiary: Colors.grey.shade300,
        ),
      ),
      home: const StartupPage(),
    );
  }
}
