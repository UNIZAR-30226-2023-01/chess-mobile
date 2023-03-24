import 'dart:async';
// import 'dart:convert';
import 'package:ajedrez/components/chessLogic/square.dart';
// import 'package:ajedrez/components/profile_data.dart';
// import 'package:ajedrez/components/visual/colores_tablero.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

import 'dart:math';
import '../popups/winner_dialog.dart';
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
  io.Socket socket = io.io(
      //no borrar la linea comentada esta para el desarrollo en la red donde esta hosteado el backend
      'http://192.168.1.250:4001',
      // 'http://reign-chess.duckdns.org:4001/',
      OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MWUwYTAwMTNkMWMwN2ZjMzQwY2UyNiIsInVzZXJuYW1lIjoiam9obmRvZSIsImlhdCI6MTY3OTY5MDM5MywiZXhwIjoxNzY2MDkwMzkzfQ.eKLvADbX0VfcFRBMQHRzGoP27FG8o7bsfNHM35ft9Mc'
      }) // for Flutter or Dart VM SI BORRAS ESTO NO VA EL SOCKET :D
          .build());
  // io.Socket socket = io.io('http://localhost:4001');
  String room = "-1";
  bool iAmWhite = false;
  String name = _nombreRandom();
  factory GameSocket() {
    return _singleton;
  }

  GameSocket._internal();
}

Future<void> startGame(BuildContext context, String type) {
  GameSocket s = GameSocket();
  Completer completer = Completer<void>();
  s.socket.onConnect((_) {
    // print("CONEXIÓN ESTABLECIDA");
  });
  // var jsonData = {"token": "adasdada", "time": 180, "user": s.name};
  Map jsonData;
  switch (type) {
    case "IA":
      {
        jsonData = {
          "gameType": "AI",
          "time": 300,
          "increment": 5,
          "hostColor": "LIGHT",
          "difficulty": 2
        };
      }
      break;
    case "COMP":
      {
        jsonData = {"gameType": "COMPETITIVE", "time": 300};
      }
      break;
    default:
      {
        jsonData = {};
        // print("Animal has metido mal el tipo");
      }
  }

  // print("CONEXIÓN ESTABLECIDA2");
  s.socket.on(
      'error',
      (data) => {
            // print(data)
          });
  s.socket.once(
      'room',
      (data) => {
            s.room = data[0]["roomID"],
            s.iAmWhite = data[0]["color"] == "LIGHT",
            // if (s.iAmWhite)
            //   {
            //     // changeColorBoard(coralN, coralB),
            //     print("I am white"),
            //   },
            // print(s.room),
            // print(s.iAmWhite),
            // print(data),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GamePage()),
            ),
            completer.complete()
          });
  s.socket.emit('find_room', jsonData);
  return completer.future;
}

void listenGame(BuildContext context) {
  GameSocket s = GameSocket();
  // Dart client
  s.socket.on(
      'error',
      (data) => {
            // print(data)
          });
  s.socket.on(
      'game_state',
      (data) => {
            // print(data)
          });
  s.socket.on(
      'moved',
      (data) => {
            if (data[0]["turn"] == (!s.iAmWhite ? "DARK" : "LIGHT"))
              {
                simulateMovement(decodeMovement(data[0]["move"])),
                if (data[0]["end_state"] == "CHECKMATE" &&
                    (data[0]["winner"] == (!s.iAmWhite ? "LIGHT" : "DARK")))
                  {
                    alertWinner(context, !s.iAmWhite),
                  },
              },
            // print(data),
          });
  s.socket.onDisconnect((_) => {
        // print('disconnect')
      });
  s.socket.on(
      'fromServer',
      (_) => {
            //print(_)
          });
}
