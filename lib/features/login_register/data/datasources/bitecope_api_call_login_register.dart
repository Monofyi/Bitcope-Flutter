import 'dart:convert';
import 'package:bitcope/core/model/token.dart';
import 'package:bitcope/features/login_register/data/model/user_login.dart';
import 'package:bitcope/features/login_register/data/model/user_register.dart';
import 'package:http/http.dart' as http;

Future<Token> getTokenUsingLogin(UserLogin userLogin, String url) async {
//  print(url);
  final http.Response response = await http.post(
    Uri.parse(url),
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

Future<Token> getTokenUsingRegister(
    UserRegister userRegister, String url) async {
  print(url);
  final http.Response response = await http.post(
    url,
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
