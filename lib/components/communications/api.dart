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

void apiSignUp() async {
  var client = http.Client();
  try {
    // var response = await client.post(Uri.https('reqres.in', '/api/register/'),
    //     body: {"email": "eve.holt@reqres.in", "password": "pistol"});
    // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    // print(decodedResponse);
  } finally {
    client.close();
  }
}
