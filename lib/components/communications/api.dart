// import 'dart:convert';
import 'package:http/http.dart' as http;

//los comentarios son para que el flutter analyze deje commitear, descomentar todo para usar
void apiSignIn() async {
  var client = http.Client();
  try {
    // var response = await client
    //     .post(Uri.http('localhost:4000', 'api/v1/auth/sign-up'), body: {
    //   'username': 'myusername',
    //   'password': 'mypassword',
    //   'email': 'DIOS@GMAIL.COM'
    // });

    // var response = await client.post(Uri.https('reqres.in', '/api/users/'),
    //     body: {"name": "morpheus", "job": "leader"});
    // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // print(decodedResponse); //para usar campos emplear ["nombreDelCampo"]
  } finally {
    client.close();
  }
}

// void apiSignUp() async {
//   var client = http.Client();
//   try {
//     var response = await client.post(Uri.https('reqres.in', '/api/register/'),
//         body: {"email": "eve.holt@reqres.in", "password": "pistol"});
//     var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
//     print(decodedResponse);
//     // PENDIENTE DE PROBAR
//     response = await client.post(
//         Uri.https('api.gracehopper.xyz', '/api/v1/auth/sign-up'),
//         headers: {
//           "Access-Control-Allow-Origin": "*",
//           "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
//           "Access-Control-Allow-Headers":
//               "Origin, X-Requested-With, Content-Type, Accept",
//           "Accept": "*/*",
//         },
//         body: {
//           "username": "johndoe",
//           "email": "johndoe@example.com",
//           "password": "1234"
//         });
//     print("llega");
//     var decodedResponse2 = utf8.decode(response.bodyBytes);
//     print(decodedResponse2);
//   } catch (e) {
//     print(e.toString());
//   } finally {
//     client.close();
//   }
// }

void apiSignUp() async {
  var client = http.Client();
  try {
    // var response = await http.post(
    //   Uri.parse('https://api.gracehopper.xyz/api/v1/ping'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{}),
    // );
    // print("llega");
    // var decodedResponse2 = response.body;
    // print(decodedResponse2);
  } catch (e) {
    // print(e.toString());
  } finally {
    client.close();
  }
}
