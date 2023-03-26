import 'package:flutter/material.dart';
import '../../components/buttons/text_long_button.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
