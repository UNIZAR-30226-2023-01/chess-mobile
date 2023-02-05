import 'package:flutter/material.dart';
import '../../components/buttons/return_button.dart';
import '../../components/buttons/navigate_button.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/buttons/platform_button.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Return Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReturnButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Header text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Hello! Register to get started',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Username textfield
              const TextFieldCustom(
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(
                height: 15,
              ),

              // Email textfield
              const TextFieldCustom(
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(
                height: 15,
              ),

              // Password textfield
              const TextFieldCustom(
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(
                height: 15,
              ),

              // Confirm password textfield
              const TextFieldCustom(
                hintText: 'Confirm password',
                obscureText: true,
              ),

              const SizedBox(
                height: 40,
              ),

              // Register Button
              NavigateButton(
                text: 'Register',
                textColor: Colors.white,
                innerBoxColor: const Color.fromARGB(255, 30, 35, 44),
                onTap: () {},
              ),

              const SizedBox(
                height: 50,
              ),

              // Divider for other methods
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Color.fromARGB(255, 208, 211, 218),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Login with',
                        style: TextStyle(
                            color: Color.fromARGB(255, 208, 211, 218),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Color.fromARGB(255, 208, 211, 218),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Other platforms for registration
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PlatformButton(
                    logoPath: 'images/Google_Logo.png',
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  PlatformButton(
                    logoPath: 'images/Apple_Logo.png',
                  ),
                ],
              ),

              const SizedBox(
                height: 50,
              ),

              // User already has an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                    child: const Text(
                      'Login Now',
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
