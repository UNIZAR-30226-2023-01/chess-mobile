import 'dart:convert';

import 'dart:io';
import 'package:ajedrez/components/singletons/profile_data.dart';
import 'package:ajedrez/components/singletons/game_data.dart';
import 'package:ajedrez/components/singletons/ranking_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

Future<int> apiSignUp(String username, password, email) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client
        .postUrl(Uri.parse('https://api.gracehopper.xyz/v1/auth/sign-up'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');

    // Create JSON body
    var body = jsonEncode(
        {'username': username, 'password': password, 'email': email});

    // Set body
    request.write(body);

    await request.close(); //comentar esta o las de abajo
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    // print(responseBody);
    var responseBodyDictionary = jsonDecode(responseBody);
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e);
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiSignIn(String username, password) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client
        .postUrl(Uri.parse('https://api.gracehopper.xyz/v1/auth/sign-in'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');

    // Create JSON body
    var body = jsonEncode({'username': username, 'password': password});

    // Set body
    request.write(body);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    // print(responseBody);
    String? cookieHeader = response.headers['set-cookie']?[0];
    cookieHeader == null ? cookieHeader = "" : cookieHeader = cookieHeader;
    List<String> cookies = cookieHeader.split('; ');
    String apiAuthCookie = cookies[0].split('=')[1];
    // print(apiAuthCookie);
    assignToken(apiAuthCookie);
    assignId(responseBodyDictionary["data"]["id"]);
    await apiUser();
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiSignOut() async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client
        .postUrl(Uri.parse('https://api.gracehopper.xyz/v1/auth/sign-out'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    // Create JSON body
    var body = jsonEncode({});

    // Set body
    request.write(body);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    // print(responseBodyDictionary);
    // print(responseBodyDictionary["status"]["error_code"]);
    // print(apiAuthCookie);
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiForgotPassword(String email) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  try {
    var request = await client.postUrl(
        Uri.parse('https://api.gracehopper.xyz/v1/auth/forgot-password'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');

    // Create JSON body
    var body = jsonEncode({'email': email});

    // Set body
    request.write(body);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    // print(responseBody);
    var responseBodyDictionary = jsonDecode(responseBody);
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiRanking(int page, int limit) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  try {
    var request = await client.getUrl(Uri.parse(
        'https://api.gracehopper.xyz/v1/users?page=$page&limit=$limit&sort=-elo'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    var data = responseBodyDictionary["data"];
    // print(data);
    // print(responseBodyDictionary);
    List<dynamic> rankingList = data;
    // print(rankingList);
    for (var element in rankingList) {
      RankingData.add(element["avatar"], element["username"], element["elo"],
          element["ranking"]);
    }

    return responseBodyDictionary["meta"]["pages"];
    //aqui ns que necesitas q devuelva
    // return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<String> apiGames(String url) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  try {
    var request = await client.getUrl(Uri.parse(url));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    var data = responseBodyDictionary["data"];
    // print(data);
    // print(responseBodyDictionary);
    List<dynamic> gameList = data;
    for (var element in gameList) {
      // print(element);
      GameData gameData = GameData(
          element["id"],
          element["lightPlayer"],
          element["darkPlayer"],
          element["board"],
          element["moves"],
          element["times"]["initial"],
          element["times"]["increment"],
          element["times"]["lightTimer"],
          element["times"]["darkTimer"],
          element["gameType"],
          element["createdAt"],
          element["updatedAt"]);
      // print(element);
      if (element["state"] == "PAUSED") {
        // print(element);
        addSavedGame(gameData);
      }
      if (element["state"] == "ENDED") {
        gameData.addResult(element["winner"], element["endState"]);
        // print(element);
        addPlayedGame(gameData);
      }
    }
    if (responseBodyDictionary["meta"]["nextPage"] == null) {
      return "null";
    } else {
      return responseBodyDictionary["meta"]["nextPage"];
    }
    //aqui ns que necesitas q devuelva
    // return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return "null";
  } finally {
    client.close();
  }
}

Future<int> apiUser() async {
  UserData userData = UserData();

  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  try {
    var request = await client.getUrl(
        Uri.parse('https://api.gracehopper.xyz/v1/users/${userData.id}'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    var data = responseBodyDictionary["data"];
    // print(responseBodyDictionary);
    List<dynamic> skins = data["skins"];
    var board = skins[0], darkPieces = skins[6], lightPieces = skins[6];
    for (var skin in skins) {
      if (skin["type"] == "board" && skin["active"] == true) {
        board = skin;
      } else if (skin["type"] == "pieces" && skin["activeDark"] == true) {
        darkPieces = skin;
      } else if (skin["type"] == "pieces" && skin["activeDark"] == true) {
        lightPieces = skin;
      }
    }
    List<dynamic> achievements = data["achievements"];
    // print(achievements);
    List<List> ach = List.empty(growable: true);
    for (var achievement in achievements) {
      ach.add([
        achievement["imgSrc"],
        achievement["imgAlt"],
        achievement["achieved"]
      ]);
    }

    updateProfile(
        data["avatar"],
        data["username"],
        data["email"],
        data["elo"],
        data["ranking"],
        data["stats"]["bulletWins"],
        data["stats"]["bulletDraws"],
        data["stats"]["bulletDefeats"],
        data["stats"]["blitzWins"],
        data["stats"]["blitzDraws"],
        data["stats"]["blitzDefeats"],
        data["stats"]["fastWins"],
        data["stats"]["fastDraws"],
        data["stats"]["fastDefeats"],
        ach,
        board["name"],
        board["darkColor"],
        board["lightColor"],
        darkPieces["src"],
        lightPieces["src"],
        data["games"]);

    // print(responseBodyDictionary);
    return 0;
    //aqui ns que necesitas q devuelva
    // return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiUpdateUser() async {
  UserData userData = UserData();

  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client.patchUrl(
        Uri.parse('https://api.gracehopper.xyz/v1/users/${userData.id}'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    // Create JSON body
    var body = jsonEncode({
      'avatar': userData.avatar,
      'username': userData.username,
      'email': userData.email,
      'board': userData.boardType,
      'lightPieces': userData.lightPieces,
      'darkPieces': userData.darkPieces
    });

    // Set body
    request.write(body);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    // print(responseBodyDictionary);

    // print(apiAuthCookie);
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiDeleteUser() async {
  UserData userData = UserData();

  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client.deleteUrl(
        Uri.parse('https://api.gracehopper.xyz/v1/users/${userData.id}'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    // Create JSON body
    var body = jsonEncode({});

    // Set body
    request.write(body);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    // print(responseBodyDictionary);

    // print(apiAuthCookie);
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiCreateTournament(
    String startTime, int rounds, int time, int increment) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client
        .postUrl(Uri.parse('https://api.gracehopper.xyz/v1/tournaments'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    // Create JSON body
    var body = jsonEncode({
      'startTime': startTime,
      'rounds': rounds,
      'matchProps': {'time': time, 'increment': increment}
    });

    // Set body
    request.write(body);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);
    print(responseBodyDictionary);

    // print(apiAuthCookie);
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}
