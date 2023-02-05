import 'package:flutter/material.dart';
import '../../components/buttons/navigate_button.dart';
import 'startup.dart';

class PwChangedPage extends StatefulWidget {
  const PwChangedPage({super.key});

  @override
  State<PwChangedPage> createState() => _PwChangedPageState();
}

class _PwChangedPageState extends State<PwChangedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Verified icon text
              const Icon(
                Icons.verified_rounded,
                color: Color.fromARGB(255, 24, 192, 122),
                size: 120,
              ),

              const SizedBox(
                height: 30,
              ),

              // Password changed header text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Password Changed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Feedback text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Your password has been changed succesfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 131, 145, 161),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              // Back to Login button
              NavigateButton(
                text: 'Back to Login',
                textColor: Colors.white,
                innerBoxColor: const Color.fromARGB(255, 30, 35, 44),
                onTap: () {
                  // Borrar historial de pantallas cargadas
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartupPage(),
                    ),
                    (r) {
                      return false;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
