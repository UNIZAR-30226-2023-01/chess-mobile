import 'package:flutter/material.dart';
import '../../components/buttons/textfield_custom2.dart';
import '../../components/communications/api.dart';
import '../menus_pages/bottom_bar.dart';
import '../../components/buttons/return_button.dart';
import '../../components/buttons/navigate_button.dart';
import '../../components/buttons/platform_button.dart';
import 'forgot_password.dart';
import 'signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Return button
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

              // Welcome text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Welcome back! Glad to see you, Again!',
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
              TextFieldCustom2(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(
                height: 15,
              ),

              TextFieldCustom2(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(
                height: 15,
              ),

              // Forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPwPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 208, 211, 218),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 35,
              ),

              // Login button
              NavigateButton(
                text: 'Login',
                textColor: Colors.white,
                innerBoxColor: const Color.fromARGB(255, 30, 35, 44),
                onTap: () async {
                  apiSignIn(
                    usernameController.text,
                    passwordController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomBar(),
                    ),
                  );
                },
              ),

              const SizedBox(
                height: 50,
              ),

              // Divider for other methods
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
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

              // Other platforms for login
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

              // Sign Up option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // User doesn't have an account
                  const Text(
                    'Don\'t have an account?',
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
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Register Now',
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
