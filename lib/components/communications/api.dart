import 'dart:convert';

import 'dart:io';
import 'package:ajedrez/components/singletons/profile_data.dart';
import 'package:ajedrez/components/singletons/game_data.dart';
import 'package:ajedrez/components/singletons/ranking_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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

void apiSignInGoogle(BuildContext context) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var scontext = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: scontext)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    // var request = await client.getUrl(
    //     Uri.parse('https://api.gracehopper.xyz/v1/auth/sign-in/google'));

    /// FUnciona pero como que no

    // var response = await request.close();
    // var responseBody = await response.transform(utf8.decoder).join();
    // Create a new route that contains the WebView widget

    // var controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadHtmlString(responseBody);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Scaffold(
    //       appBar: AppBar(title: const Text('Login with google')),
    //       body: WebViewWidget(controller: controller),
    //     ),
    //   ),
    // );
    // print(responseBody);
  } catch (e) {
    // print(e.toString());
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
    for (var element in rankingList) {
      RankingData.add(element["avatar"], element["username"], element["elo"]);
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
    // print(data);
    updateProfile(
        data["username"],
        data["email"],
        data["avatar"],
        data["skins"]["board"],
        data["skins"]["lightPieces"],
        data["skins"]["darkPieces"],
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
        data["achievements"],
        data["games"]);
    // print(data);

    //actualizar datos aquí
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
