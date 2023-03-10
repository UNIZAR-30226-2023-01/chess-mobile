import 'dart:async';
import 'package:ajedrez/components/chessLogic/casilla.dart';
import 'package:ajedrez/components/profile_data.dart';
import 'package:ajedrez/components/visual/colores_tablero.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'dart:math';

import '../../pages/game_pages/game.dart';
// void searchGame() {
//   // Dart client
//   IO.Socket socket = IO.io('http://localhost:4001');
//   socket.onConnect((_) {
//     print('connect');
//   });
//   var jsonData = {"token": "adasdada", "time": 180, "user": "Fernando"};

//   String jsonString = jsonEncode(jsonData);
//   socket.on('error', (data) => print(data));
//   socket.emit('find_game', jsonData);
//   // socket.on('event', (data) => print(data));
//   socket.on('game_state', (data) => print(data));
//   socket.onDisconnect((_) => print('disconnect'));
//   // socket.on('fromServer', (_) => print(_));
// }

String _nombreRandom() {
  Random random = Random();
  int randomNumber = random
      .nextInt(26); // generates a random integer between 0 and 25 (inclusive)
  String randomChar = String.fromCharCode(randomNumber +
      65); // converts the random integer to an uppercase character (A-Z)
  return "Fernando$randomChar"; // prints a random character
}

class GameSocket {
  static final GameSocket _singleton = GameSocket._internal();
  // IO.Socket socket = IO.io('http://192.168.0.250:4001');
  io.Socket socket = io.io('http://localhost:4001');
  String room = "-1";
  bool iAmWhite = false;
  String name = _nombreRandom();
  factory GameSocket() {
    return _singleton;
  }

  GameSocket._internal();
}

Future<void> startGame(BuildContext context) {
  GameSocket s = GameSocket();
  Completer completer = Completer<void>();
  s.socket.onConnect((_) {});
  var jsonData = {"token": "adasdada", "time": 180, "user": s.name};

  s.socket.once(
      'game_state',
      (data) => {
            s.room = data[0]["roomID"],
            s.iAmWhite = data[0]["light"] == s.name,
            if (s.iAmWhite)
              {
                changeColorBoard(coralN, coralB),
              },
            // print(s.room),
            // print(s.iAmWhite),
            // print(data),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage()),
            ),
            completer.complete()
          });
  s.socket.emit('find_game', jsonData);
  return completer.future;
}

void listenGame() {
  GameSocket s = GameSocket();
  // Dart client
  // s.socket.on('error', (data) => print(data));
  // s.socket.on('game_state', (data) => print(data));
  s.socket.on(
      'move',
      (data) => {
            if (data[0]["turn"] == (!s.iAmWhite ? "DARK" : "LIGHT"))
              {
                simularMovimiento(decodificarJugada(data[0]["move"])),
                // print("simulandomovimiento"),
              },
            // print(data),
          });
  // s.socket.onDisconnect((_) => print('disconnect'));
  // socket.on('fromServer', (_) => print(_));
}
