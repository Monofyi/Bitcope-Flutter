import 'dart:convert';
import 'package:bitcope/core/model/token.dart';
import 'package:bitcope/features/login_register/data/model/user_login.dart';
import 'package:bitcope/features/login_register/data/model/user_register.dart';
import 'package:dio/dio.dart';

Dio _dio = Dio();
Future<Token> getTokenUsingLogin(UserLogin userLogin, String url) async {
  final Response response = await _dio.post(
    url,
    data: userLogin.toDatabaseJson(),
  );
  if (response.statusCode == 200) {
    //print(Token.fromJson(response.data).token);
    return Token.fromJson(response.data);
  } else {
    //print(json.decode(response.data).toString());
    throw Exception(response.data);
  }
}

Future<Token> getTokenUsingRegister(
    UserRegister userRegister, String url) async {
  final Response response = await _dio.post(
    url,
    data: userRegister.toDatabaseJson(),
  );
  if (response.statusCode == 200) {
    print(Token.fromJson(json.decode(response.data)).token);
    return Token.fromJson(json.decode(response.data));
  } else {
    print(json.decode(response.data).toString());
    throw Exception(json.decode(response.data));
  }
}
