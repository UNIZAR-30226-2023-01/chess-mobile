import 'package:ajedrez/components/communications/api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/return.dart';
import '../../components/buttons/text_long.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/buttons/platform.dart';
import '../../components/popups/pop_error.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String confirmedPassword = '';

  // Method to update username
  void updateUsername(userText) {
    setState(() {
      username = userText;
    });
  }

  // Method to update email
  void updateEmail(emailText) {
    setState(() {
      email = emailText;
    });
  }

  // Method to update password
  void updatePassword(pwText) {
    setState(() {
      password = pwText;
    });
  }

  // Method to update repeated password
  void updateConfirmedPassword(conPwText) {
    setState(() {
      confirmedPassword = conPwText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Hello! Register to get started',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Username textfield
                  TextFieldCustom(
                    labelText: 'Username',
                    obscureText: false,
                    iconText: Icons.person,
                    onChanged: (userTxt) => updateUsername(userTxt),
                    validator: (userTxt) => userTxt == null || userTxt.isEmpty
                        ? 'Enter a valid username'
                        : null,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Email textfield
                  TextFieldCustom(
                    labelText: 'Email',
                    obscureText: false,
                    iconText: Icons.person,
                    onChanged: (emailTxt) => updateEmail(emailTxt),
                    validator: (emailTxt) => emailTxt == null ||
                            emailTxt.isEmpty ||
                            !EmailValidator.validate(emailTxt)
                        ? 'Enter a valid email'
                        : null,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Password textfield
                  TextFieldCustom(
                    labelText: 'Password',
                    obscureText: true,
                    iconText: Icons.lock,
                    onChanged: (pwTxt) => updatePassword(pwTxt),
                    validator: (pwTxt) {
                      if (pwTxt == null || pwTxt.isEmpty) {
                        return 'Enter a valid password';
                      } else if (pwTxt.length < 8) {
                        return 'Must have at least 8 characters';
                      } else if (pwTxt != confirmedPassword) {
                        return 'Does not coincide with the confirmed password';
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Confirm password textfield
                  TextFieldCustom(
                    labelText: 'Confirm password',
                    obscureText: true,
                    iconText: Icons.lock_reset,
                    onChanged: (conPwTxt) => updateConfirmedPassword(conPwTxt),
                    validator: (conPwTxt) {
                      if (conPwTxt == null || conPwTxt.isEmpty) {
                        return 'Enter a valid password';
                      } else if (conPwTxt.length < 8) {
                        return 'Must have at least 8 characters';
                      } else if (conPwTxt != password) {
                        return 'Does not coincide with the purposed password';
                      } else {
                        return null;
                      }
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // Register Button
                  textButton(
                    context,
                    true,
                    'Register',
                    () async {
                      final isValidForm = formKey.currentState!.validate();

                      if (isValidForm) {
                        int errCode = await apiSignUp(
                          username,
                          password,
                          email,
                        );

                        switch (errCode) {
                          case 0:
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignInPage(),
                                ),
                              );
                            }
                            break;

                          case 409:
                            if (context.mounted) {
                              popupERR(context,
                                  "Username or email is already taken");
                            }
                            break;

                          default:
                            if (context.mounted) {
                              popupERR(context,
                                  "An error has ocurred during registration");
                            }
                        }
                      }
                    },
                  ),

                  const SizedBox(
                    height: 50,
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
                        child: Text(
                          'Login Now',
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
