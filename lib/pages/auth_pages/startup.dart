// import 'package:ajedrez/pages/menus_pages/tournaments.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/text_long.dart';
import '../menus_pages/bottom_bar.dart';
import '../../components/data/profile_data.dart';
import '../../components/visual/set_image_color.dart';
import '../../components/visual/screen_size.dart';
import 'signin.dart';
import 'signup.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    defaultHeight = MediaQuery.of(context).size.height;
    defaultWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),

              // Logo
              SizedBox(
                height: 200,
                child: setImageColor(context, "Logo_with_text.png",
                    Theme.of(context).colorScheme.primary),
              ),

              // Text(
              //   'R E I G N',
              //   style: TextStyle(
              //     fontFamily: 'VesperLibre',
              //     fontWeight: FontWeight.w400,
              //     fontSize: 56,
              //     color: Theme.of(context).colorScheme.primary,
              //   ),
              // ),

              const SizedBox(
                height: 40,
              ),

              // Sign In button
              textButton(context, true, 'Iniciar sesión', () {
                assignIsRegistred(true);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              }),

              const SizedBox(
                height: 15,
              ),

              // Sign Up button
              textButton(context, false, "Registrarse", () {
                assignIsRegistred(true);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              }),

              const SizedBox(
                height: 50,
              ),

              // Anonymous user option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // User doesn't have an account
                  const Text(
                    '¿Quieres jugar sin tener una cuenta?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  GestureDetector(
                    onTap: () {
                      // De momento no rellena datos de usuario !!!
                      resetProfile();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomBar.fromSignIn(),
                          //builder: (context) => const TournamentPage(),
                        ),
                      );
                    },
                    child: Text(
                      '¡Haz click aquí!',
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
    );
  }
}
