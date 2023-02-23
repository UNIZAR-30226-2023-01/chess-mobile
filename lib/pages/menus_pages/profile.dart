import 'package:ajedrez/components/profile_data.dart';
import 'package:flutter/material.dart';
import '../../components/visual/custom_shape.dart';
import '../../components/visual/colores_tablero.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    final double defaultHeight = MediaQuery.of(context).size.height;
    final double defaultWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: defaultHeight * 0.35,
            child: Stack(
              children: <Widget>[
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
                    child: PopupMenuButton(
                      color: Theme.of(context).colorScheme.tertiary,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1.25,
                        ),
                      ),
                      child: Icon(
                        Icons.settings,
                        size: defaultHeight * 0.035,
                      ),
                      onSelected: (value) {},
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: '_edit',
                            child: Text("Editar perfil"),
                          ),
                          PopupMenuItem(
                            value: '_password',
                            child: Text("Cambiar contraseña"),
                          ),
                          PopupMenuItem(
                            value: '_delete',
                            child: Text("Eliminar cuenta"),
                          ),
                        ];
                      },
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: defaultHeight * 0.025,
                            top: defaultHeight * 0.1),
                        child: Column(
                          children: [
                            Text(
                              "Grace Hopper",
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
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
                              image: AssetImage('images/Grace_Hopper.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: ListView(
                children: <Widget>[
                  lineaDivider(defaultWidth, "Estadísticas"),
                  SizedBox(height: defaultWidth * 0.075),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      contenedorEstadistico(
                          defaultHeight, defaultWidth, "Puntuación", "2556"),
                      SizedBox(width: defaultWidth * 0.075),
                      contenedorEstadistico(
                          defaultHeight, defaultWidth, "Rango", "#78"),
                    ],
                  ),
                  SizedBox(height: defaultWidth * 0.075),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      contenedorEstadistico(
                          defaultHeight, defaultWidth, "Win rate", "78%"),
                      SizedBox(width: defaultWidth * 0.075),
                      contenedorEstadistico(defaultHeight, defaultWidth,
                          "Partidas jugadas", "1283"),
                    ],
                  ),
                  SizedBox(height: defaultWidth * 0.075),
                  lineaDivider(defaultWidth, "Logros"),
                  SizedBox(height: defaultHeight * 0.1),
                  lineaDivider(defaultWidth, "Tema"),
                  SizedBox(height: defaultWidth * 0.075),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(userData.tableroB),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            height: defaultWidth * 0.3875,
                            width: defaultWidth * 0.3875,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Color(userData.tableroN),
                                BlendMode.modulate,
                              ),
                              child: Image.asset('images/current_board.png'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: defaultWidth * 0.119,
                                left: defaultWidth * 0.119),
                            height: defaultWidth * 0.15,
                            width: defaultWidth * 0.15,
                            child: Image.asset(
                                'images/${userData.tipo}/caballoN.png'),
                          ),
                        ],
                      ),
                      SizedBox(width: defaultWidth * 0.075),
                      Column(
                        children: [
                          SizedBox(
                            width: defaultWidth * 0.3875,
                            height: defaultWidth * 0.156,
                            child: Material(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: PopupMenuButton(
                                color: Theme.of(context).colorScheme.tertiary,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1.25,
                                    )),
                                child: Center(
                                  child: Text(
                                    "Tablero",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                onSelected: (value) {
                                  switch (value) {
                                    case "_madera":
                                      changeColorBoard(maderaN, maderaB);
                                      break;
                                    case "_coral":
                                      changeColorBoard(coralN, coralB);
                                      break;
                                    case "_oscuro":
                                      changeColorBoard(oscuroN, oscuroB);
                                      break;
                                    case "_mar":
                                      changeColorBoard(marN, marB);
                                      break;
                                    case "_trigo":
                                      changeColorBoard(trigoN, trigoB);
                                      break;
                                    case "_esmeralda":
                                      changeColorBoard(esmeraldaN, esmeraldaB);
                                      break;
                                  }
                                  setState(() {});
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: '_madera',
                                      child: itemPopupTablero(defaultWidth,
                                          maderaN, maderaB, "Madera"),
                                    ),
                                    PopupMenuItem(
                                      value: '_coral',
                                      child: itemPopupTablero(defaultWidth,
                                          coralN, coralB, "Coral"),
                                    ),
                                    PopupMenuItem(
                                      value: '_oscuro',
                                      child: itemPopupTablero(defaultWidth,
                                          oscuroN, oscuroB, "Oscuro"),
                                    ),
                                    PopupMenuItem(
                                      value: '_mar',
                                      child: itemPopupTablero(
                                          defaultWidth, marN, marB, "Océano"),
                                    ),
                                    PopupMenuItem(
                                      value: '_trigo',
                                      child: itemPopupTablero(defaultWidth,
                                          trigoN, trigoB, "Trigo"),
                                    ),
                                    PopupMenuItem(
                                      value: '_esmeralda',
                                      child: itemPopupTablero(defaultWidth,
                                          esmeraldaN, esmeraldaB, "Esmeralda"),
                                    ),
                                  ];
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: defaultWidth * 0.075),
                          SizedBox(
                            width: defaultWidth * 0.3875,
                            height: defaultWidth * 0.156,
                            child: Material(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: PopupMenuButton(
                                color: Theme.of(context).colorScheme.tertiary,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1.25,
                                    )),
                                child: Center(
                                  child: Text(
                                    "Piezas",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                onSelected: (value) {
                                  switch (value) {
                                    case "_merida":
                                      changeTypePieces("merida");
                                      break;
                                    case "_maya":
                                      changeTypePieces("maya");
                                      break;
                                    case "_marroquin":
                                      changeTypePieces("marroquin");
                                      break;
                                    case "_medieval":
                                      changeTypePieces("medieval");
                                      break;
                                  }
                                  setState(() {});
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: '_merida',
                                      child: itemPopupPiezas(
                                          defaultWidth, "merida", "Mérida"),
                                    ),
                                    PopupMenuItem(
                                      value: '_maya',
                                      child: itemPopupPiezas(
                                          defaultWidth, "maya", "Maya"),
                                    ),
                                    PopupMenuItem(
                                      value: '_marroquin',
                                      child: itemPopupPiezas(defaultWidth,
                                          "marroquin", "Marroquín"),
                                    ),
                                    PopupMenuItem(
                                      value: '_medieval',
                                      child: itemPopupPiezas(
                                          defaultWidth, "medieval", "Medieval"),
                                    ),
                                  ];
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: defaultWidth * 0.075),
                  lineaDivider(defaultWidth, "Actividad"),
                  SizedBox(height: defaultWidth * 0.075),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  contenedorEstadistico(
      double defaultHeight, double defaultWidth, String asunto, String cuerpo) {
    return SizedBox(
      width: defaultWidth * 0.3875,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: defaultHeight * 0.012,
            horizontal: defaultWidth * 0.01,
          ),
          child: Column(
            children: [
              Text(
                asunto,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: defaultHeight * 0.005),
              Text(
                cuerpo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemPopupTablero(
      double defaultWidth, int tableroN, int tableroB, String texto) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(tableroB),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          height: defaultWidth * 0.1,
          width: defaultWidth * 0.1,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Color(tableroN),
              BlendMode.modulate,
            ),
            child: Image.asset('images/posible_board.png'),
          ),
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

  itemPopupPiezas(double defaultWidth, String tipo, String texto) {
    return Row(
      children: [
        SizedBox(
          height: defaultWidth * 0.1,
          width: defaultWidth * 0.1,
          child: Image(
            image: AssetImage('images/$tipo/caballoN.png'),
          ),
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

  lineaDivider(double defaultWidth, String texto) {
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
