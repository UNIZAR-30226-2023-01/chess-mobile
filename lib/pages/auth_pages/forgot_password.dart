import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/buttons/return_button.dart';
import '../../components/buttons/text_long_button.dart';
import 'startup.dart';
//import 'create_password.dart';
import '../../components/communications/api.dart';
import '../../components/popups/pop_error.dart';
import 'signin.dart';

class ForgotPwPage extends StatefulWidget {
  const ForgotPwPage({super.key});

  @override
  State<ForgotPwPage> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';

  // Method to update email
  void updateEmail(emailTxt) {
    setState(() {
      email = emailTxt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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

                  // Forgot password header text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                  TextFieldCustom(
                    labelText: 'Enter your email',
                    obscureText: false,
                    iconText: Icons.email,
                    onChanged: (emailTxt) => updateEmail(emailTxt),
                    validator: (emailTxt) => emailTxt == null ||
                            emailTxt.isEmpty ||
                            !EmailValidator.validate(emailTxt)
                        ? 'Enter a valid email'
                        : null,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // Send code button
                  textButton(
                    context,
                    true,
                    'Send Code',
                    () async {
                      final isValidForm = formKey.currentState!.validate();

                      if (isValidForm) {
                        int errCode = await apiForgotPassword(email);

                        switch (errCode) {
                          case 0:
                            if (context.mounted) {
                              popupERR(
                                  context, "A recovery email has been sent");
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StartupPage(),
                                ),
                                (r) {
                                  return false;
                                },
                              );
                            }
                            break;

                          default:
                            if (context.mounted) {
                              popupERR(context,
                                  "An error has ocurred during recovery");
                            }
                        }
                      }
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
      ),
    );
  }
}
