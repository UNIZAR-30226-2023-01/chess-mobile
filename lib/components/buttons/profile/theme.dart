import 'package:ajedrez/components/communications/api.dart';
import 'package:flutter/material.dart';
import '../../singletons/profile_data.dart';
import '../../visual/screen_size.dart';
import '../../visual/set_image_color.dart';

SizedBox buttonTheme(BuildContext context, ValueNotifier counter, int isBoard,
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
              switch (isBoard) {
                case 0:
                  changeColorBoard(list[i][0], list[i][1], list[i][2]);
                  break;
                case 1:
                  changeDarkPieces(list[i][0]);
                  break;
                case 2:
                  changeLightPieces(list[i][0]);
                  break;
                default:
                  break;
              }
              apiUpdateUser();
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
                child: isBoard == 0
                    ? itemPopupBoard(
                        context, list[i][1], list[i][2], list[i][3])
                    : isBoard == 1
                        ? itemPopupPieces(context, list[i][0], list[i][1], true)
                        : itemPopupPieces(
                            context, list[i][0], list[i][1], false),
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

itemPopupPieces(BuildContext context, String type, String text, bool isBlack) {
  return Row(
    children: [
      SizedBox(
        height: defaultWidth * 0.1,
        width: defaultWidth * 0.1,
        child: Image(
          image: AssetImage(
              "images/pieces/$type/caballo${isBlack ? "N" : "B"}.png"),
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
