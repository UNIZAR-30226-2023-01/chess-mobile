import 'package:flutter/material.dart';

class Casilla extends StatefulWidget {
  final int index;
  const Casilla({super.key, required this.index});

  @override
  State<Casilla> createState() => _CasillaState();
}

class _CasillaState extends State<Casilla> {
  /// Contiene el índice de la casilla(0-63)
  int i = 0;

  @override
  void initState() {
    super.initState();
    i = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _tapped(i);
      },
      child: SizedBox(
        width: 5,
        height: 5,
        child: Container(
          color: ((i % 2 + ((i ~/ 8) % 2)) % 2 == 0)

              /// Formula que determina el color de la casilla
              ? Colors.white
              : Colors.black,
          child: Center(
            child: Text(
              i.toString(),
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }

  /// Se llama al tocar una casilla
  void _tapped(int index) {}
}
