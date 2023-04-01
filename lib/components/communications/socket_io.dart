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

import '../popups/winner_dialog.dart';
import '../../pages/game_pages/game.dart';

class Arguments {
  int time = 300;
  int increment = 5;
  int difficulty = 1;

  Arguments();
  Arguments.forCOMP(this.time);
  Arguments.forAI(this.time, this.increment, this.difficulty);
}

class GameSocket {
  static final GameSocket _singleton = GameSocket._internal();
  io.Socket socket = io.io(
      //no borrar la linea comentada esta para el desarrollo en la red donde esta hosteado el backend
      // 'http://192.168.0.249:4001',
      'http://reign-chess.duckdns.org:4001/',
      OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        'token': UserData().token
      }) // for Flutter or Dart VM SI BORRAS ESTO NO VA EL SOCKET :D
          .build());
  String room = "-1";
  bool iAmWhite = false;
  factory GameSocket() {
    return _singleton;
  }

  GameSocket._internal();
}

Future<void> startGame(BuildContext context, String type, Arguments arguments) {
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
          "time": arguments.time,
          "increment": arguments.increment,
          "hostColor": "RANDOM",
          "difficulty": arguments.difficulty
        };
      }
      break;
    case "COMP":
      {
        jsonData = {"gameType": "COMPETITIVE", "time": arguments.time};
      }
      break;
    case "CREATECUSTOM":
      {
        jsonData = {
          "gameType": "CUSTOM",
          "time": arguments.time,
          "increment": arguments.increment,
          "hostColor": "RANDOM"
        };
        s.socket.once(
            'room_created',
            (data) => {
                  s.room = data[0]["roomID"],
                });
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
                alertWinner(context, !s.iAmWhite,"Ha ganado el jugador con las fichas "),
              },

            if (data[0]["endState"] == "SURRENDER" &&
                (data[0]["winner"] == (!s.iAmWhite ? "LIGHT" : "DARK")))
              {
                alertWinner(context, s.iAmWhite,"Se ha rendido el jugador con las fichas "),
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

void draw() {

  //pendiente de implementar
  // GameSocket s = GameSocket();
  // print("llegaaaaaaaaa");
  // s.socket.emit('surrender', {});
}
