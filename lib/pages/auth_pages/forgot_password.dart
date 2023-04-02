import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/buttons/return_button.dart';
import '../../components/buttons/text_long_button.dart';
import 'create_password.dart';
import 'signin.dart';

class ForgotPwPage extends StatefulWidget {
  const ForgotPwPage({super.key});

  @override
  State<ForgotPwPage> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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

                // Forgot password header text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // Process description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Don\'t worry! It occurs. Please enter the email address linked with your account.',
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

                // Animated graphic
                Lottie.asset(
                  'assets/forgot_password.json',
                  height: 225,
                ),

                const SizedBox(
                  height: 30,
                ),

                // Email textfield
                const TextFieldCustom(
                  hintText: 'Enter your email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 30,
                ),

                // Send code button
                textButton(
                  context,
                  true,
                  'Send Code',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreatePwPage(),
                      ),
                    );
                  },
                ),

                const SizedBox(
                  height: 30,
                ),

                // User remembers password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remember Password?',
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
                            builder: (context) => const SignInPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            // Color.fromARGB(255, 59, 203, 255),
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
