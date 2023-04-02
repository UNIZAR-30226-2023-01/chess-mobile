import 'dart:convert';
import 'dart:ffi';

import 'dart:io';
import 'package:ajedrez/components/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:webview_flutter/webview_flutter.dart';

void apiSignUp(String username, password, email) async {
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
    print(responseBody);
  } catch (e) {
    print(e);
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
    print(responseBody);
    String? cookieHeader = response.headers['set-cookie']?[0];
    cookieHeader == null ? cookieHeader = "" : cookieHeader = cookieHeader;
    List<String> cookies = cookieHeader.split('; ');
    String apiAuthCookie = cookies[0].split('=')[1];
    print(apiAuthCookie);
    assignToken(apiAuthCookie);
    assignId(responseBodyDictionary["data"]["id"]);
    assignUsername(responseBodyDictionary["data"]["username"]);
    assignEmail(responseBodyDictionary["data"]["email"]);
    return responseBodyDictionary["status"]["error_code"];
  } catch (e) {
    print(e.toString());
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
