/// Page that allows the user to change a forgotten password.
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/buttons/return.dart';
import '../../components/buttons/text_long.dart';
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
                          '¿Contraseña olvidada?',
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
                      '¡No te preocupes! Suele ocurrir. Por favor, introduce el correo electrónico vinculada a tu cuenta',
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
                    labelText: 'Correo electrónico',
                    obscureText: false,
                    iconText: Icons.email,
                    onChanged: (emailTxt) => updateEmail(emailTxt),
                    validator: (emailTxt) => emailTxt == null ||
                            emailTxt.isEmpty ||
                            !EmailValidator.validate(emailTxt)
                        ? 'Introduce un correo electrónico válido'
                        : null,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // Send code button
                  textButton(
                    context,
                    true,
                    'Enviar código',
                    () async {
                      final isValidForm = formKey.currentState!.validate();

                      if (isValidForm) {
                        int errCode = await apiForgotPassword(email);

                        switch (errCode) {
                          case 0:
                            if (context.mounted) {
                              popupERR(context,
                                  "Se ha enviado un correo de recuperación");
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
                                  "Ha ocurrido un error durante la recuperación");
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
                        '¿Te acuerdas de la contraseña?',
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
                          '¡Inicia sesión ya!',
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
