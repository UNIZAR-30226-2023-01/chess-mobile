import 'package:flutter/material.dart';
import '../profile_data.dart';
import '../visual/screen_size.dart';
import '../visual/set_image_color.dart';

SizedBox buttonTheme(BuildContext context, ValueNotifier counter, bool isBoard,
    String text, List<List> list) {
  return SizedBox(
    width: defaultWidth * 0.3875,
    height: defaultWidth * 0.1,
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
          ),
        ),
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
          for (int i = 0; i < list.length; i++) {
            if (value == list[i][0]) {
              isBoard
                  ? changeColorBoard(list[i][1], list[i][2])
                  : changeTypePieces(list[i][1]);
              break;
            }
          }
          counter.value++;
        },
        itemBuilder: (context) {
          List<PopupMenuItem> items = List.empty(growable: true);
          for (int i = 0; i < list.length; i++) {
            items.add(
              PopupMenuItem(
                value: list[i][0],
                child: isBoard
                    ? itemPopupBoard(
                        context, list[i][1], list[i][2], list[i][3])
                    : itemPopupPieces(context, list[i][1], list[i][2]),
              ),
            );
          }
          return items;
        },
      ),
    ),
  );
}

itemPopupBoard(BuildContext context, int boardN, int boardB, String texto) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Color(boardB),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: defaultWidth * 0.1,
        width: defaultWidth * 0.1,
        child: setImageColor(context, "posible_board.png", Color(boardN)),
      ),
      SizedBox(
        width: defaultWidth * 0.05,
      ),
      Text(
        texto,
        style: TextStyle(
          fontSize: 19,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    ],
  );
}

itemPopupPieces(BuildContext context, String type, String text) {
  return Row(
    children: [
      SizedBox(
        height: defaultWidth * 0.1,
        width: defaultWidth * 0.1,
        child: Image(
          image: AssetImage("images/$type/caballoN.png"),
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
    ],
  );
}
