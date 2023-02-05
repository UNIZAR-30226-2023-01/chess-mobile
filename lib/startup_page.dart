import 'package:flutter/material.dart';
import 'components/navigate_button.dart';
import 'signin_page.dart';
import 'signup_page.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),

              // Logo
              Image.asset(
                'images/Logo_app_chess.png',
                height: 150,
              ),

              const Text(
                'R E I G N',
                style: TextStyle(
                  fontFamily: 'VesperLibre',
                  fontWeight: FontWeight.w400,
                  fontSize: 56,
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // Sign In button
              NavigateButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                text: 'Sign In',
                innerBoxColor: const Color.fromARGB(255, 30, 35, 44),
                textColor: Colors.white,
              ),

              const SizedBox(
                height: 15,
              ),

              // Sign Up button
              NavigateButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                text: 'Sign Up',
                textColor: const Color.fromARGB(255, 30, 35, 44),
                innerBoxColor: const Color.fromARGB(255, 250, 250, 250),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
