import 'dart:convert';

import 'dart:io';
import 'package:ajedrez/components/profile_data.dart';
import 'package:ajedrez/components/game_data.dart';
import 'package:ajedrez/components/ranking_data.dart';
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
    assignUsername(responseBodyDictionary["data"]["username"]);
    assignEmail(responseBodyDictionary["data"]["email"]);
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
        'https://api.gracehopper.xyz/v1/users?page=$page&limit=$limit'));
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

Future<int> apiGames(int page, int limit) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  try {
    var request = await client.getUrl(Uri.parse(
        'https://api.gracehopper.xyz/v1/games?page=$page&limit=$limit'));
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
      if (element["state"] == "FINISHED") {
        // print(element);
        addPlayedGame(gameData);
      }
    }
    if (responseBodyDictionary["meta"]["nextPage"] == null) {
      return 0;
    } else {
      return 1;
    }
    //aqui ns que necesitas q devuelva
    // return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    // print(e.toString());
    return -1;
  } finally {
    client.close();
  }
}

Future<int> apiUser(String id) async {
  var pemBytes = await rootBundle.load("assets/cert.pem");

  var context = SecurityContext()
    ..setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(), password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

  try {
    var request = await client
        .getUrl(Uri.parse('https://api.gracehopper.xyz/v1/users/$id'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');
    request.headers.add('Cookie', 'api-auth=${UserData().token}');

    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var responseBodyDictionary = jsonDecode(responseBody);

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
