/// Page that informs the user the sucessfull change of the password.
import 'package:flutter/material.dart';
import '../../components/buttons/text_long.dart';
import 'startup.dart';

class PwChangedPage extends StatefulWidget {
  const PwChangedPage({super.key});

  @override
  State<PwChangedPage> createState() => _PwChangedPageState();
}

class _PwChangedPageState extends State<PwChangedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Verified icon text
              const Icon(
                Icons.verified_rounded,
                color: Color.fromARGB(255, 24, 192, 122),
                size: 120,
              ),

              const SizedBox(
                height: 30,
              ),

              // Password changed header text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Contraseña cambiada',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Feedback text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Tu contraseña ha sido cambiada exitosamente',
                  textAlign: TextAlign.center,
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

              // Back to Login button
              textButton(
                context,
                true,
                'Vuelve a la pantalla de inicio',
                () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartupPage(),
                    ),
                    (r) {
                      return false;
                    },
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
