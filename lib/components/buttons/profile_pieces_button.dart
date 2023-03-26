import 'package:flutter/material.dart';
import '../visual/screen_size.dart';
import '../profile_data.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  String text = "Piezas";
  List<String> id = ["merida", "maya", "marroquin", "medieval"];
  List<String> name = ["Mérida", "Maya", "Marroquín", "Medieval"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: defaultWidth * 0.3875,
      height: defaultWidth * 0.156,
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: PopupMenuButton(
          color: Theme.of(context).colorScheme.tertiary,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1.25,
              )),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          onSelected: (value) {
            for (int i = 0; i < 4; i++) {
              if (value == "_${id[i]}") {
                changeTypePieces(id[i]);
                setState(() {});
                break;
              }
            }
          },
          itemBuilder: (context) {
            List<PopupMenuItem> popupsMenu = List.empty(growable: true);
            for (int i = 0; i < 4; i++) {
              popupsMenu.add(
                PopupMenuItem(
                  value: "_${id[i]}",
                  child: itemPopupPieces(context, id[i], name[i]),
                ),
              );
            }
            return popupsMenu;
          },
        ),
      ),
    );
  }

  itemPopupPieces(BuildContext context, String type, String text) {
    return Row(children: [
      SizedBox(
        height: defaultWidth * 0.1,
        width: defaultWidth * 0.1,
        child: Image(
          image: AssetImage('images/$type/caballoN.png'),
        ),
      ),
      SizedBox(
        width: defaultWidth * 0.05,
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 19,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    ]);
  }
}
