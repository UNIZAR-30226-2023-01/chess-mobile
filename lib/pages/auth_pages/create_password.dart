import 'package:flutter/material.dart';
import '../../components/buttons/textfield_custom.dart';
import '../../components/buttons/return_button.dart';
import '../../components/buttons/text_long_button.dart';
import 'password_changed.dart';

class CreatePwPage extends StatefulWidget {
  const CreatePwPage({super.key});

  @override
  State<CreatePwPage> createState() => _CreatePwPageState();
}

class _CreatePwPageState extends State<CreatePwPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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

                  // Create Password header text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Create new password',
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

                  // Process description text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Your new password must be unique from those previously used.',
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

                  // New Password textfield
                  TextFieldCustom(
                    labelText: 'New Password',
                    obscureText: true,
                    iconText: Icons.lock_reset,
                    validator: (value) =>
                        value != '456' ? 'Invalid password' : null,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Confirm Password textfield
                  TextFieldCustom(
                    labelText: 'Confirm Password',
                    obscureText: true,
                    iconText: Icons.lock_reset,
                    validator: (value) =>
                        value != '123' ? 'Invalid password' : null,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // Reset Password button
                  textButton(
                    context,
                    true,
                    'Reset Password',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PwChangedPage(),
                        ),
                      );
                    },
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
