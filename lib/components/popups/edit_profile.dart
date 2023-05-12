import 'package:ajedrez/components/communications/api.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import '../visual/screen_size.dart';
import '../buttons/home/play.dart';
import '../singletons/profile_data.dart';
import '../buttons/profile/textfield.dart';

Object popupEditProfile(BuildContext context, ValueNotifier<int> counter) {
  UserData userData = UserData();
  final TextEditingController usernameController = TextEditingController();
  usernameController.text = userData.username;
  final TextEditingController emailController = TextEditingController();
  emailController.text = userData.email;
  String avatarController = userData.avatar;
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) =>
        StatefulBuilder(builder: (context, setState) {
      return WillPopScope(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "Foto de perfil\nactual",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        height: defaultHeight * 0.1,
                        width: defaultHeight * 0.1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 4,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "images/avatars${userData.avatar}"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Foto de perfil\nnueva",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(
                        height: defaultHeight * 0.1,
                        width: defaultHeight * 0.1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 4,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("images/avatars$avatarController"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: defaultWidth * 0.05),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 1; i <= 50; i++)
                      GestureDetector(
                        onTap: () {
                          avatarController = "/animals/$i.webp";
                          setState(() {});
                        },
                        child: imageSelect(context, "animals", i),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 1; i <= 24; i++)
                      GestureDetector(
                        onTap: () {
                          avatarController = "/humans/$i.webp";
                          setState(() {});
                        },
                        child: imageSelect(context, "humans", i),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 1; i <= 28; i++)
                      GestureDetector(
                        onTap: () {
                          avatarController = "/memojis/$i.webp";
                          setState(() {});
                        },
                        child: imageSelect(context, "memojis", i),
                      ),
                  ],
                ),
              ),
              SizedBox(height: defaultWidth * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  playButton(context, "Cancelar", () => Navigator.pop(context)),
                  playButton(context, "Guardar", () async {
                    String username = userData.username,
                        email = userData.email,
                        avatar = userData.avatar;
                    assignUsername(usernameController.text);
                    assignEmail(emailController.text);
                    assignAvatar(avatarController);
                    int i = await apiUpdateUser();

                    if (context.mounted) {
                      // print(i);
                      if (i == 0) {
                        counter.value++;
                        Navigator.pop(context);
                      } else {
                        assignUsername(username);
                        assignEmail(email);
                        assignAvatar(avatar);
                        popupErrorEditProfile(context);
                      }
                    }
                  }),
                ],
              ),
            ]),
          ),
        ),
      );
    }),
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
              "Ha habido un error cambiando el nombre de usuario o el correo electrónico.",
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

Container imageSelect(BuildContext context, String type, int n) {
  return Container(
    height: defaultHeight * 0.075,
    width: defaultHeight * 0.075,
    margin: EdgeInsets.only(right: defaultWidth * 0.025),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(
        color: Theme.of(context).colorScheme.primary,
        width: 3,
      ),
      image: DecorationImage(
        fit: BoxFit.contain,
        image: AssetImage("images/avatars/$type/$n.webp"),
      ),
    ),
  );
}
