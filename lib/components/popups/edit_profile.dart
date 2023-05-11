import 'package:ajedrez/components/communications/api.dart';
import 'package:flutter/material.dart';
import '../visual/screen_size.dart';
import '../buttons/home_play_button.dart';
import '../profile_data.dart';
import '../buttons/profile_textfield_button.dart';

Object popupEditProfile(BuildContext context, ValueNotifier<int> counter) {
  UserData userData = UserData();
  final TextEditingController usernameController = TextEditingController();
  usernameController.text = userData.username;
  final TextEditingController emailController = TextEditingController();
  emailController.text = userData.email;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          height: defaultHeight * 0.85,
          child: Column(children: [
            Text(
              "Editar perfil",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 1.25,
              indent: defaultWidth * 0.05,
              endIndent: defaultWidth * 0.05,
            ),
            SizedBox(height: defaultWidth * 0.05),
            Text(
              "Nombre de usuario",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            textField(context, usernameController),
            SizedBox(height: defaultWidth * 0.05),
            Text(
              "Correo electrónico",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            textField(context, emailController),
            SizedBox(height: defaultWidth * 0.05),
            Expanded(child: ListView()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                playButton(context, "Cancelar", () => Navigator.pop(context)),
                playButton(context, "Guardar", () async {
                  String username = userData.username, email = userData.email;
                  assignUsername(usernameController.text);
                  assignEmail(emailController.text);
                  int i = await apiUpdateUser();

                  if (context.mounted) {
                    print(i);
                    if (i == 0) {
                      counter.value++;
                      Navigator.pop(context);
                    } else {
                      assignUsername(username);
                      assignEmail(email);
                      popupErrorEditProfile(context);
                    }
                  }
                }),
              ],
            ),
          ]),
        ),
      ),
    ),
  );
}

Object popupErrorEditProfile(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        contentPadding: EdgeInsets.all(defaultWidth * 0.05),
        content: SizedBox(
          width: defaultWidth * 0.85,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "El nombre de usuario o el correo electrónico ya están siendo utilizados por otros usuarios.",
              style: TextStyle(
                fontSize: 19,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: defaultWidth * 0.05),
            playButton(context, "Ok", () => Navigator.pop(context)),
          ]),
        ),
      ),
    ),
  );
}
