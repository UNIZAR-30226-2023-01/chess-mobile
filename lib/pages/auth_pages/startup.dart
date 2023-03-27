import 'package:flutter/material.dart';
import '../../components/buttons/text_long_button.dart';
import '../menus_pages/bottom_bar.dart';
import '../../components/profile_data.dart';
import 'signin.dart';
import 'signup.dart';

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
              textButton(
                context,
                true,
                'Sign In',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // Sign Up button
              textButton(
                context,
                false,
                "Sign Up",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // Anonymous user option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // User doesn't have an account
                  const Text(
                    'Wan\'t to play without an account?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  GestureDetector(
                    onTap: () {
                      // De momento no rellena datos de usuario !!!
                      assignIsRegistred(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomBar(),
                        ),
                      );
                    },
                    child: const Text(
                      'Play Now',
                      style: TextStyle(
                          color: Color.fromARGB(255, 59, 203, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
