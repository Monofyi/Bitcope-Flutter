import 'dart:convert';
import 'package:bitcope/core/error_handling/api_result.dart';
import 'package:bitcope/core/error_handling/network_exceptions.dart';
import 'package:bitcope/core/model/token.dart';
import 'package:bitcope/features/login_register/data/model/user_login.dart';
import 'package:bitcope/features/login_register/data/model/user_register.dart';
import 'package:dio/dio.dart';

Dio _dio = Dio();
Future<ApiResult<Token>> getTokenUsingLogin(
    UserLogin userLogin, String url) async {
  try {
    final Response response = await _dio.post(
      url,
      data: userLogin.toDatabaseJson(),
    );
    // if (response.statusCode == 200) {
    //   //print(Token.fromJson(response.data).token);
    return ApiResult.success(data: Token.fromJson(response.data));
    // } else {
    //   print(json.decode(response.data).toString());
    //   // throw ApiResult.failure(error: NetworkExceptions.getDioException(e));
    // }
  } catch (e) {
    return ApiResult.failure(error: NetworkExceptions.getDioException(e));
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
