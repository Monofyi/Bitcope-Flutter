import 'dart:convert';
import 'package:bitcope/features/sendotp/data/model/otp_model.dart';
import 'package:bitcope/features/sendotp/data/model/otp_response_model.dart';
import 'package:bitcope/features/sendotp/data/model/otp_verify_model.dart';
import 'package:http/http.dart' as http;

Future<OTPResponseModel> getOTP(
    {String token, String url, OTPModel otpModel}) async {
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token' + ' ' + token,
      },
      body: json.encode(otpModel.toJson()),
    );
    if (response.statusCode == 200) {
      //final data=

      return OTPResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<OTPResponseModel> verifyOTP(
    {String token, String url, OTPVerifyModel otpVerifyModel}) async {
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Token' + ' ' + token,
      },
      body: json.encode(otpVerifyModel.toJson()),
    );
    if (response.statusCode == 200) {
      //final data=

      return OTPResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      return OTPResponseModel.fromJson(json.decode(response.body));
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
