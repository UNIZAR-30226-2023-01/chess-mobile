import 'package:flutter/material.dart';
import '../../components/profile_data.dart';
import '../../components/visual/custom_shape.dart';
import '../../components/visual/customization_constants.dart';
import '../../components/visual/screen_size.dart';
import '../../components/visual/set_image_color.dart';
import '../../components/buttons/profile_statistic_button.dart';
import '../../components/buttons/profile_options_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          header(),
          Expanded(
            child: Center(
              child: ListView(
                children: [
                  divider("Estadísticas"),
                  SizedBox(height: defaultWidth * 0.075),
                  statistics(),
                  SizedBox(height: defaultWidth * 0.075),
                  divider("Logros"),
                  SizedBox(height: defaultWidth * 0.075),
                  // Achievments
                  SizedBox(height: defaultWidth * 0.075),
                  divider("Tema"),
                  SizedBox(height: defaultWidth * 0.075),
                  theme(),
                  SizedBox(height: defaultWidth * 0.075),
                  divider("Actividad"),
                  SizedBox(height: defaultWidth * 0.075),
                  // Activity
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox header() {
    return SizedBox(
      height: defaultHeight * 0.35,
      child: Stack(children: [
        ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: defaultHeight * 0.335,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(
              top: defaultHeight * 0.04,
              right: defaultHeight * 0.015,
            ),
            child: optionsButton(context),
          ),
        ),
        Center(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: defaultHeight * 0.025, top: defaultHeight * 0.1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Grace Hopper",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: defaultHeight * 0.01),
                    Text(
                      "GraceHopper@ejemplo.com",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: defaultHeight * 0.14,
              width: defaultHeight * 0.14,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  ),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/Grace_Hopper.jpg"),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Column statistics() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        statisticsContainer(context, "Puntuación", "2556"),
        SizedBox(width: defaultWidth * 0.075),
        statisticsContainer(context, "Rango", "#78"),
      ]),
      SizedBox(height: defaultWidth * 0.075),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        statisticsContainer(context, "Win rate", "78%"),
        SizedBox(width: defaultWidth * 0.075),
        statisticsContainer(context, "Partidas jugadas", "1283"),
      ]),
    ]);
  }

  Column theme() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        boardTheme(),
        SizedBox(width: defaultWidth * 0.075),
        Column(children: [
          popupButtonTheme(true, "Tablero", boardTypes),
          SizedBox(height: defaultWidth * 0.075),
          popupButtonTheme(false, "Piezas", piecesTypes),
        ])
      ]),
    ]);
  }

  Stack boardTheme() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(userData.boardTypeB),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          height: defaultWidth * 0.3875,
          width: defaultWidth * 0.3875,
          child: setImageColor(
              context, "current_board.png", Color(userData.boardTypeN)),
        ),
        Container(
          margin: EdgeInsets.only(
              top: defaultWidth * 0.12, left: defaultWidth * 0.12),
          height: defaultWidth * 0.15,
          width: defaultWidth * 0.15,
          child: Image.asset("images/${userData.pieceType}/caballoN.png"),
        ),
      ],
    );
  }

  SizedBox popupButtonTheme(bool isBoard, String text, List<List> list) {
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
            for (int i = 0; i < list.length; i++) {
              if (value == list[i][0]) {
                isBoard
                    ? changeColorBoard(list[i][1], list[i][2])
                    : changeTypePieces(list[i][1]);
                break;
              }
            }
            setState(() {});
          },
          itemBuilder: (context) {
            List<PopupMenuItem> items = List.empty(growable: true);
            for (int i = 0; i < list.length; i++) {
              items.add(
                PopupMenuItem(
                  value: list[i][0],
                  child: isBoard
                      ? itemPopupBoard(list[i][1], list[i][2], list[i][3])
                      : itemPopupPieces(list[i][1], list[i][2]),
                ),
              );
            }
            return items;
          },
        ),
      ),
    );
  }

  itemPopupBoard(int boardN, int boardB, String texto) {
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

  itemPopupPieces(String type, String text) {
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

  divider(String texto) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1.25,
            indent: defaultWidth * 0.1,
            endIndent: defaultWidth * 0.05,
          ),
        ),
        Text(
          texto,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.primary,
            thickness: 1.25,
            indent: defaultWidth * 0.05,
            endIndent: defaultWidth * 0.1,
          ),
        ),
      ],
    );
  }
}
