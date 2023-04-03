import 'package:ajedrez/components/buttons/home_play_button.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/communications/api.dart';
import '../menus_pages/bottom_bar.dart';
import '../../components/buttons/return_button.dart';
import '../../components/buttons/platform_button.dart';
import '../../components/buttons/text_long_button.dart';
import '../../components/visual/screen_size.dart';
import 'forgot_password.dart';
import 'signup.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //final TextEditingController usernameController = TextEditingController();
  //final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  // PopUp Errors coming from backend
  Object popupERR(String errorMsg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error icon
              const Icon(
                Icons.error_outline,
                color: Color.fromARGB(255, 224, 16, 16),
                size: 60,
              ),

              SizedBox(height: defaultWidth * 0.05),

              // Error text
              Text(
                errorMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),

              SizedBox(height: defaultWidth * 0.05),

              // Exit pop up button
              playButton(context, "Ok", () => Navigator.pop(context))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Form(
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
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

                  // Welcome text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Welcome back! Glad to see you, Again!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // Username textfield
                  TextFieldCustom(
                    labelText: 'Username',
                    obscureText: false,
                    iconText: Icons.person,
                    validator: (userTxt) {
                      if (userTxt == null || userTxt.isEmpty) {
                        return 'Enter a valid username';
                      } else {
                        username = userTxt;
                        return null;
                      }
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Password textfield
                  TextFieldCustom(
                    labelText: 'Password',
                    obscureText: true,
                    iconText: Icons.lock,
                    validator: (passTxt) {
                      if (passTxt == null || passTxt.isEmpty) {
                        return 'Enter a valid password';
                      } else if (passTxt.length < 8) {
                        return 'Password must have at least 8 characters';
                      } else {
                        password = passTxt;
                        return null;
                      }
                    },
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
                  textButton(
                    context,
                    true,
                    'Login',
                    () async {
                      final isValidForm = formKey.currentState!.validate();

                      // No errors in textfields
                      if (isValidForm) {
                        int errCode = await apiSignIn(
                          username,
                          password,
                        );
                        switch (errCode) {
                          // Credentials are correct
                          case 0:
                            // "Mala práctica"
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomBar.fromSignIn(),
                                ),
                              );
                            }
                            break;

                          // An error has occurred during authentication
                          default:
                            popupERR(
                                "An error has occurred during authentication");
                        }
                      }
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
                            'Or',
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
                    height: 25,
                  ),

                  // Other platforms for login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlatformButton(
                        logoPath: 'images/Google_Logo.png',
                        message: 'Login with Google',
                        onTap: () async {
                          apiSignInGoogle(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBar.fromSignIn(),
                            ),
                          );
                        },
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
                        child: Text(
                          'Register Now',
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
      ),
    );
  }
}
