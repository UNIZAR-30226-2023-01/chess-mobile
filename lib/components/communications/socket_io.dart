import 'dart:async';
// import 'dart:convert';
import 'package:ajedrez/components/chessLogic/board.dart';
import 'package:ajedrez/components/chessLogic/square.dart';
import 'package:ajedrez/components/profile_data.dart';
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
      // 'http://192.168.1.250:4001',
      'http://reign-chess.duckdns.org:4001/',
      OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        'token': UserData().token
      }) // for Flutter or Dart VM SI BORRAS ESTO NO VA EL SOCKET :D
          .build());
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

  Map jsonData;
  switch (type) {
    case "AI":
      {
        jsonData = {
          "gameType": "AI",
          "time": 300,
          "increment": 5,
          "hostColor": "RANDOM",
          "difficulty": 3
        };
      }
      break;
    case "COMP":
      {
        jsonData = {"gameType": "COMPETITIVE", "time": 300};
      }
      break;
    case "CREATECUSTOM":
      {
        jsonData = {
          "gameType": "CUSTOM",
          "time": 300,
          "increment": 5,
          "hostColor": "RANDOM"
        };
      }
      break;
    case "JOINCUSTOM":
      {
        jsonData = {"gameType": "CUSTOM", "roomID": "810448"};
      }
      break;
    case "SPECTATOR":
      {
        jsonData = {"roomID": "248525"};
        s.socket.emit('join_room', jsonData);
        s.room = "248525";
        BoardData().spectatorMode = true;
      }
      break;
    default:
      {
        jsonData = {};
        // print("Animal has metido mal el tipo");
      }
  }
  if (type == "CREATECUSTOM") {
    s.socket.once(
        'room',
        (data) => {
              s.room = data[0]["roomID"],
              // print(s.room),
              s.socket.once(
                  'room',
                  (data) => {
                        if (type != "SPECTATOR")
                          {
                            s.room = data[0]["roomID"],
                            s.iAmWhite = data[0]["color"] == "LIGHT",
                          },
                        // print(data),
                        // print(s.room),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GamePage()),
                        ),
                        completer.complete()
                      })
            });
  } else {
    s.socket.once(
        'room',
        (data) => {
              if (type != "SPECTATOR")
                {
                  s.room = data[0]["roomID"],
                  s.iAmWhite = data[0]["color"] == "LIGHT",
                }
              else
                {
                  // movements = data[0]["moves"],
                  // movements.forEach((mov) => {
                  //       // print(mov),
                  //       // print(decodeMovement(mov)),
                  //       // simulateMovement(decodeMovement(mov))
                  //     }),
                  // print(movements),
                  s.iAmWhite = true
                },
              // print(data),
              // print(s.room),
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamePage()),
              ),
              completer.complete()
            });
  }
  // print("CONEXIÓN ESTABLECIDA2");
  s.socket.on(
      'error',
      (data) => {
            // print(data)
          });
  if (type != "SPECTATOR") s.socket.emit('find_room', jsonData);
  // List movements;

  return completer.future;
}

void listenGame(BuildContext context) {
  GameSocket s = GameSocket();
  bool espec = BoardData().spectatorMode;
  // Dart client
  s.socket.on(
      'error',
      (data) => {
            // print("ERROR" + data)
          });
  s.socket.on(
      'game_state',
      (data) => {
            // print(data)
          });
  s.socket.on(
      'moved',
      (data) => {
            // print(data),
            if (!espec)
              {
                if (data[0]["turn"] == (!s.iAmWhite ? "DARK" : "LIGHT"))
                  {
                    simulateMovement(decodeMovement(data[0]["move"])),
                  },
              }
            else
              simulateMovement(decodeMovement(data[0]["move"])),
            // print(data),
          });
  s.socket.on(
      'game_over',
      (data) => {
            if (data[0]["endState"] == "CHECKMATE" &&
                (data[0]["winner"] == (!s.iAmWhite ? "LIGHT" : "DARK")))
              {
                alertWinner(context, !s.iAmWhite),
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

void surrender() {
  GameSocket s = GameSocket();
  // print("llegaaaaaaaaa");
  s.socket.emit('surrender', {});
}
