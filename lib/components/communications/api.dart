import 'dart:convert';
import 'dart:io';
import 'package:ajedrez/components/profile_data.dart';
import 'package:flutter/services.dart' show rootBundle;

void apiSignUp(String username, password, email) async {
  SecurityContext context = SecurityContext.defaultContext;
  var pemBytes = await rootBundle.load("assets/cert.pem");
  context.setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(),
      password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client
        .postUrl(Uri.parse('https://api.gracehopper.xyz/api/v1/auth/sign-up'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');

    // Create JSON body
    var body = jsonEncode(
        {'username': username, 'password': password, 'email': email});

    // Set body
    request.write(body);

    await request.close(); //comentar esta o la de abajo
    // var response = await request.close();
    // var responseBody = await response.transform(utf8.decoder).join();
    // print(responseBody);
  } catch (e) {
    // print(e.toString());
  } finally {
    client.close();
  }
}

void apiSignIn(String username, password) async {
  SecurityContext context = SecurityContext.defaultContext;
  var pemBytes = await rootBundle.load("assets/cert.pem");
  context.setTrustedCertificatesBytes(pemBytes.buffer.asUint8List(),
      password: '');

  var client = HttpClient(context: context)
    ..badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  try {
    var request = await client
        .postUrl(Uri.parse('https://api.gracehopper.xyz/api/v1/auth/sign-in'));
    // Set headers
    request.headers.add('Content-Type', 'application/json');

    // Create JSON body
    var body = jsonEncode({'username': username, 'password': password});

    // Set body
    request.write(body);
    var response = await request.close();
    // var responseBody = await response.transform(utf8.decoder).join();
    // print(responseBody);
    String? cookieHeader = response.headers['set-cookie']?[0];
    cookieHeader == null ? cookieHeader = "" : cookieHeader = cookieHeader;
    List<String> cookies = cookieHeader.split('; ');
    String apiAuthCookie = cookies[0].split('=')[1];
    // print(apiAuthCookie);
    assignToken(apiAuthCookie);
  } catch (e) {
    // print(e.toString());
  } finally {
    client.close();
  }
}
