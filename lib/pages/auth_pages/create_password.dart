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
              const TextFieldCustom(
                hintText: 'New Password',
                obscureText: true,
              ),

              const SizedBox(
                height: 15,
              ),

              // Confirm Password textfield
              const TextFieldCustom(
                hintText: 'Confirm Password',
                obscureText: true,
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
    );
  }
}
