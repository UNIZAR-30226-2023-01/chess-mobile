import 'package:flutter/material.dart';

import '../../singletons/profile_data.dart';

enum PieceOption {
  reina,
  torre,
  alfil,
  caballo,
}

Future<PieceOption?> showPieceSelectionDialog(
    BuildContext context, Offset position, bool isWhite) async {
  final UserData userData = UserData();
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject()! as RenderBox;
  final RelativeRect positionRelativeRect = RelativeRect.fromRect(
    Rect.fromPoints(
      position,
      position.translate(1, 1),
    ),
    Offset.zero & overlay.size,
  );

  return await showMenu<PieceOption>(
      color: Theme.of(context).colorScheme.tertiary,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1.25,
        ),
      ),
      context: context,
      position: positionRelativeRect,
      items: <PopupMenuEntry<PieceOption>>[
        PopupMenuItem(
          value: PieceOption.reina,
          child: Image(
              image: AssetImage(
            isWhite
                ? "images/pieces/${userData.lightPieces}/reinaB.png"
                : "images/pieces/${userData.darkPieces}/reinaN.png",
          )),
        ),
        PopupMenuItem(
            value: PieceOption.torre,
            child: Image(
              image: AssetImage(
                isWhite
                    ? "images/pieces/${userData.lightPieces}/torreB.png"
                    : "images/pieces/${userData.darkPieces}/torreN.png",
              ),
            )),
        PopupMenuItem(
            value: PieceOption.alfil,
            child: Image(
              image: AssetImage(
                isWhite
                    ? "images/pieces/${userData.lightPieces}/alfilB.png"
                    : "images/pieces/${userData.darkPieces}/alfilN.png",
              ),
            )),
        PopupMenuItem(
            value: PieceOption.caballo,
            child: Image(
              image: AssetImage(
                isWhite
                    ? "images/pieces/${userData.lightPieces}/caballoB.png"
                    : "images/pieces/${userData.darkPieces}/caballoN.png",
              ),
            )),
      ],
      elevation: 8.0,
      constraints: const BoxConstraints(maxWidth: 80));
}
