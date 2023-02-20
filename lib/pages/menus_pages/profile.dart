import 'package:ajedrez/components/profile_data.dart';
import 'package:flutter/material.dart';
import '../../components/visual/custom_shape.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserData userData = UserData();
    double defaultHeight = MediaQuery.of(context).size.height;
    double defaultWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.grey.shade100,
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
                    color: Colors.grey.shade300,
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
                      color: Colors.grey.shade300,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 30, 35, 44),
                            width: 1.25,
                          )),
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
                            const Text(
                              "Grace Hopper",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 30, 35, 44),
                              ),
                            ),
                            SizedBox(height: defaultHeight * 0.01),
                            const Text(
                              "GraceHopper@ejemplo.com",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 30, 35, 44),
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
                                color: const Color.fromARGB(255, 30, 35, 44),
                                width: 4,
                              ),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('images/Grace_Hopper.jpg'),
                              )),
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
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                            height: defaultWidth * 0.3875,
                            width: defaultWidth * 0.3875,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Color(userData.tableroN),
                                BlendMode.modulate,
                              ),
                              child: Image.asset('images/board_theme.png'),
                            ),
                          ),
                          SizedBox(
                            height: defaultWidth * 0.3875,
                            width: defaultWidth * 0.3875,
                            child: Image.asset('images/caballoN.png'),
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
                              color: const Color.fromARGB(255, 162, 197, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                onTap: () {
                                  changeColorBoard(0xff769656, 0xffeeeed2);
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    "Tablero",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 30, 35, 44),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: defaultWidth * 0.075),
                          SizedBox(
                            width: defaultWidth * 0.3875,
                            height: defaultWidth * 0.156,
                            child: Material(
                              color: const Color.fromARGB(255, 162, 197, 255),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: InkWell(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                onTap: () {
                                  changeColorBoard(0xffB88B4A, 0xffE3C16F);
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    "Piezas",
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 30, 35, 44),
                                    ),
                                  ),
                                ),
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
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 30, 35, 44),
          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                style: const TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 162, 197, 255),
                ),
              ),
              SizedBox(height: defaultHeight * 0.005),
              Text(
                cuerpo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 162, 197, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  lineaDivider(double defaultWidth, String texto) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color.fromARGB(255, 30, 35, 44),
            thickness: 1.25,
            indent: defaultWidth * 0.1,
            endIndent: defaultWidth * 0.05,
          ),
        ),
        Text(
          texto,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 30, 35, 44),
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color.fromARGB(255, 30, 35, 44),
            thickness: 1.25,
            indent: defaultWidth * 0.05,
            endIndent: defaultWidth * 0.1,
          ),
        ),
      ],
    );
  }
}
