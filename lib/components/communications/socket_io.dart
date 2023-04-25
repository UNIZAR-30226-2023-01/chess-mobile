import 'dart:async';
// import 'dart:convert';
// import 'package:ajedrez/components/chessLogic/board.dart';
import 'package:ajedrez/components/chessLogic/square.dart';
import 'package:ajedrez/components/profile_data.dart';
// import 'package:ajedrez/components/profile_data.dart';
// import 'package:ajedrez/components/visual/colores_tablero.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

import '../popups/draw_dialog.dart';
import '../popups/possible_draw.dart';
import '../popups/winner_dialog.dart';
import '../../pages/game_pages/game.dart';

class Arguments {
  int time = 300;
  int increment = 5;
  String hostColor = "RANDOM";
  int difficulty = 1;
  String roomID = "roomID";

  Arguments();
  Arguments.forCOMP(this.time);
  Arguments.forAI(this.time, this.increment, this.hostColor, this.difficulty);
  Arguments.forSPECTATOR(this.roomID);
  Arguments.forCREATECUSTOM(this.time, this.increment, this.hostColor);
  Arguments.forJOINCUSTOM(this.roomID);
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
  List pendingMovements = [];
  bool spectatorMode = false;
  bool iAmWhite = false;
  int timer = 300;
  factory GameSocket() {
    return _singleton;
  }

  void reset() {
    socket = io.io(
      // 'http://192.168.0.249:4001',
      'http://reign-chess.duckdns.org:4001/',
      OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        'token': UserData().token
      }).enableForceNew().build());
    room = "-1";
    pendingMovements = [];
    spectatorMode = false;
    iAmWhite = false;
    timer = 300;
  }

  GameSocket._internal();
}

void resetSocket() {
  GameSocket socket = GameSocket();
  socket.reset();
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
          "hostColor": arguments.hostColor,
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
          "hostColor": arguments.hostColor
        };
        s.socket.once(
          'room_created',
          (data) => {
            s.room = data[0]["roomID"],
          },
        );
        completer.complete();
        s.socket.emit('find_room', jsonData);
      }
      return completer.future;
    case "JOINCUSTOM":
      {
        jsonData = {"gameType": "CUSTOM", "roomID": arguments.roomID};
      }
      break;
    case "SPECTATOR":
      {
        jsonData = {"roomID": arguments.roomID};
        s.socket.emit('join_room', jsonData);
        s.room = arguments.roomID;
        s.spectatorMode = true;
      }
      break;
    default:
      {
        jsonData = {};
        // print("Animal has metido mal el tipo");
      }
  }
  var movements = [];
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
                movements = data[0]["moves"],
                s.pendingMovements = movements,
                s.iAmWhite = true
              },
            s.timer = data[0]["initialTimer"],
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
  if (type != "SPECTATOR" && type != "WAITCUSTOM") {
    s.socket.emit('find_room', jsonData);
  }

  return completer.future;
}

void listenGame(BuildContext context) {
  GameSocket s = GameSocket();
  bool espec = s.spectatorMode;

  s.socket.on(
      'error',
      (data) => {
            // print("ERROR" + data)
          });
  s.socket.on(
      'moved',
      (data) => {
            if (!espec)
              {
                if (data[0]["turn"] == (!s.iAmWhite ? "DARK" : "LIGHT"))
                  {
                    simulateMovement(decodeMovement(data[0]["move"])),
                  },
              }
            else
              {
                // print("funciona"),
              simulateMovement(decodeMovement(data[0]["move"])),}
          });
  s.socket.on(
      'game_over',
      (data) => {
            // print(data),
            if (data[0]["endState"] == "CHECKMATE" &&
                (data[0]["winner"] == (!s.iAmWhite ? "LIGHT" : "DARK")))
              {
                alertWinner(context, !s.iAmWhite,
                    "Ha ganado el jugador con las fichas "),
              },
            if (data[0]["endState"] == "SURRENDER" &&
                (data[0]["winner"] == (!s.iAmWhite ? "LIGHT" : "DARK")))
              {
                alertWinner(context, s.iAmWhite,
                    "Se ha rendido el jugador con las fichas "),
              },
            if (data[0]["endState"] == "TIMEOUT")
              {
                alertWinner(context, !s.iAmWhite,
                    "Ha ganado por tiempo el jugador con las fichas "),
              },
            if (data[0]["endState"] == "DRAW")
              {
                alertDraw(context),
              },
          });
  s.socket.on(
      'voted_draw',
      (data) => {
            if (data[0]["color"] == (s.iAmWhite ? "DARK" : "LIGHT"))
              alertPossibleDraw(context)
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
  s.socket.emit('surrender', {});
}

void draw() {
  GameSocket s = GameSocket();
  var jsonData = {"color": s.iAmWhite ? "LIGHT" : "DARK"};
  s.socket.emit('vote_draw', jsonData);
}
