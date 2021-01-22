import 'dart:async';
import 'dart:convert';
import 'package:bitcope/features/login_register/data/model/token.dart';
import 'package:bitcope/features/login_register/data/model/user_login.dart';
import 'package:bitcope/features/login_register/data/model/user_register.dart';
import 'package:http/http.dart' as http;

final _loginTokenURL =
    'https://a4d06ff47760.ngrok.io/login/'; //+ _tokenEndpoint;
final _registerTokenURL =
    'https://7eb45e884fc3.ngrok.io/register/'; //+ _tokenEndpoint;

Future<Token> getTokenUsingLogin(UserLogin userLogin) async {
  print(_loginTokenURL);
  final http.Response response = await http.post(
    _loginTokenURL,
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    //body: jsonEncode(userLogin.toDatabaseJson()),
    body: userLogin.toDatabaseJson(),
  );
  if (response.statusCode == 200) {
    print(Token.fromJson(json.decode(response.body)).token);
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Token> getTokenUsingRegister(UserRegister userRegister) async {
  print(_registerTokenURL);
  final http.Response response = await http.post(
    _registerTokenURL,
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    //body: jsonEncode(userLogin.toDatabaseJson()),
    body: userRegister.toDatabaseJson(),
  );
  if (response.statusCode == 200) {
    print(Token.fromJson(json.decode(response.body)).token);
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
