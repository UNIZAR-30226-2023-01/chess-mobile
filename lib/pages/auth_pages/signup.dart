import 'package:ajedrez/components/communications/api.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/return_button.dart';
import '../../components/buttons/text_long_button.dart';
import '../../components/buttons/textfield_custom2.dart';
import '../../components/buttons/platform_button.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                TextFieldCustom2(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 15,
                ),

                // Email textfield
                TextFieldCustom2(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 15,
                ),

                // Password textfield
                TextFieldCustom2(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 15,
                ),

                // Confirm password textfield
                TextFieldCustom2(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 40,
                ),

                // Register Button
                textButton(
                  context,
                  true,
                  'Register',
                  () {
                    apiSignUp(
                      usernameController.text,
                      passwordController.text,
                      emailController.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
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

                // Other platforms for registration
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlatformButton(
                      onTap: () async {},
                      logoPath: 'images/Google_Logo.png',
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    PlatformButton(
                      onTap: () async {},
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
      ),
    );
  }
}
