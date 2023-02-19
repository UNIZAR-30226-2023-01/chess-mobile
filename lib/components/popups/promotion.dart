import 'package:flutter/material.dart';

enum PieceOption {
  reina,
  torre,
  alfil,
  caballo,
}

Future<PieceOption?> showPieceSelectionDialog(
    BuildContext context, Offset position, bool isWhite) async {
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
      context: context,
      position: positionRelativeRect,
      items: <PopupMenuEntry<PieceOption>>[
        PopupMenuItem(
            value: PieceOption.reina,
            child: Image(
              image: AssetImage("images/reina${isWhite ? "B" : "N"}.png"),
            )),
        PopupMenuItem(
            value: PieceOption.torre,
            child: Image(
              image: AssetImage("images/torre${isWhite ? "B" : "N"}.png"),
            )),
        PopupMenuItem(
            value: PieceOption.alfil,
            child: Image(
              image: AssetImage("images/alfil${isWhite ? "B" : "N"}.png"),
            )),
        PopupMenuItem(
            value: PieceOption.caballo,
            child: Image(
              image: AssetImage("images/caballo${isWhite ? "B" : "N"}.png"),
            )),
      ],
      elevation: 8.0,
      constraints: const BoxConstraints(maxWidth: 80));
}
