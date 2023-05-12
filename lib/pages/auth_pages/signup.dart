import 'package:ajedrez/components/communications/api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/return.dart';
import '../../components/buttons/text_long.dart';
import '../../components/buttons/textfield_custom.dart';
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
                      '¡Hola! Regístrate para acceder a funciones únicas',
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
                    labelText: 'Nombre de usuario',
                    obscureText: false,
                    iconText: Icons.person,
                    onChanged: (userTxt) => updateUsername(userTxt),
                    validator: (userTxt) => userTxt == null || userTxt.isEmpty
                        ? 'Introduce un nombre de usuario válido'
                        : null,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Email textfield
                  TextFieldCustom(
                    labelText: 'Correo electrónico',
                    obscureText: false,
                    iconText: Icons.person,
                    onChanged: (emailTxt) => updateEmail(emailTxt),
                    validator: (emailTxt) => emailTxt == null ||
                            emailTxt.isEmpty ||
                            !EmailValidator.validate(emailTxt)
                        ? 'Introduce un correo electrónico válido'
                        : null,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Password textfield
                  TextFieldCustom(
                    labelText: 'Contraseña',
                    obscureText: true,
                    iconText: Icons.lock,
                    onChanged: (pwTxt) => updatePassword(pwTxt),
                    validator: (pwTxt) {
                      if (pwTxt == null || pwTxt.isEmpty) {
                        return 'Introduce una contraseña válida';
                      } else if (pwTxt.length < 8) {
                        return 'La contraseña debe tener al menos 8 carácteres';
                      } else if (pwTxt != confirmedPassword) {
                        return 'La contraseña no coincide con la confirmación de la contraseña';
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
                    labelText: 'Confirma la contraseña',
                    obscureText: true,
                    iconText: Icons.lock_reset,
                    onChanged: (conPwTxt) => updateConfirmedPassword(conPwTxt),
                    validator: (conPwTxt) {
                      if (conPwTxt == null || conPwTxt.isEmpty) {
                        return 'Introduce una contraseña válida';
                      } else if (conPwTxt.length < 8) {
                        return 'La contraseña debe tener al menos 8 carácteres';
                      } else if (conPwTxt != password) {
                        return 'La contraseña no coincide con la confirmación de la contraseña';
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
                    'Crear cuenta',
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
                                  "El nombre de usuario o el correo electrónico ya está en uso");
                            }
                            break;

                          default:
                            if (context.mounted) {
                              popupERR(context,
                                  "Ha ocurrido un error durante el registro");
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
                        '¿Ya tienes una cuenta?',
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
