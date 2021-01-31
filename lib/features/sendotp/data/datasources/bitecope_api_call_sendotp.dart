import 'package:bitcope/features/sendotp/data/model/order_status.dart';
import 'package:bitcope/features/sendotp/data/model/order_status_response.dart';
import 'package:bitcope/features/sendotp/data/model/otp_model.dart';
import 'package:bitcope/features/sendotp/data/model/otp_response_model.dart';
import 'package:bitcope/features/sendotp/data/model/otp_verify_model.dart';
import 'package:dio/dio.dart';

Future<OTPResponseModel> getOTP(
    {String token, String url, OTPModel otpModel}) async {
  Dio _dio = Dio();
  try {
    _dio.options.headers["Authorization"] = "token $token";

    final Response response = await _dio.post(
      url,
      data: otpModel.toJson(),
    );
    if (response.statusCode == 200) {
      return OTPResponseModel.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<OTPResponseModel> verifyOTP(
    {String token, String url, OTPVerifyModel otpVerifyModel}) async {
  Dio _dio = Dio();

  try {
    _dio.options.headers["Authorization"] = "token $token";
    final Response response = await _dio.post(
      url,
      data: otpVerifyModel.toJson(),
    );
    if (response.statusCode == 200) {
      return OTPResponseModel.fromJson(response.data);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}

Future<OrderResponseModel> orderStatus(
    {String token, String url, OrderModel orderModel}) async {
  Dio _dio = Dio();

  try {
    _dio.options.headers["Authorization"] = "token $token";
    final Response response = await _dio.put(
      url,
      data: orderModel.toJson(),
    );
    if (response.statusCode == 200) {
      return OrderResponseModel.fromJson(response.data);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
