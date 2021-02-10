import 'package:bitcope/core/database/user_database_operations.dart';
import 'package:bitcope/core/error_handling/api_result.dart';
import 'package:bitcope/core/error_handling/network_exceptions.dart';
import 'package:bitcope/core/server_switch/server_switch.dart';
import 'package:bitcope/features/sendotp/data/model/order_status.dart';
import 'package:bitcope/features/sendotp/data/model/order_status_response.dart';
import 'package:bitcope/features/sendotp/data/model/otp_model.dart';
import 'package:bitcope/features/sendotp/data/model/otp_response_model.dart';
import 'package:bitcope/features/sendotp/data/model/otp_verify_model.dart';
import 'package:meta/meta.dart';
import 'package:bitcope/features/sendotp/data/datasources/bitecope_api_call_sendotp.dart';

class OTPRepository {
  String sessionId;
  final userDatabaseOps = UserDatabaseOps();
  Future<ApiResult<OTPResponseModel>> otpValidationResponse({
    @required String token,
    @required String url,
    @required int phoneno,
    @required String transactionid,
    @required String retailerName,
  }) async {
    OTPModel otpModel = OTPModel(
        phoneno: phoneno,
        transactionid: transactionid.toString(),
        retailerName: retailerName);
    ApiResult<OTPResponseModel> otpResponseModel =
        await getOTP(url: url, token: token, otpModel: otpModel);

    return otpResponseModel.when(
      success: (otpResponseModel) {
        sessionId = otpResponseModel.details;
        return ApiResult.success(data: otpResponseModel);
      },
      failure: (NetworkExceptions error) {
        return ApiResult.failure(error: error);
      },
    );
  }

  Future<ApiResult<OTPResponseModel>> otpVerifyResponse(
      {@required String token,
      @required String url,
      @required String otp}) async {
    OTPVerifyModel otpVerifyModel =
        OTPVerifyModel(otp: otp, transactionid: sessionId.toString());
    ApiResult<OTPResponseModel> otpResponseModel =
        await verifyOTP(url: url, token: token, otpVerifyModel: otpVerifyModel);
    return otpResponseModel.when(
      success: (otpResponseModel) {
        sessionId = otpResponseModel.details;
        return ApiResult.success(data: otpResponseModel);
      },
      failure: (NetworkExceptions error) {
        return ApiResult.failure(error: error);
      },
    );
  }

  Future<ApiResult<OrderResponseModel>> orderSuccessResponse(
      {@required String token,
      @required String url,
      @required String orderId}) async {
    OrderModel orderModel = OrderModel(orderId: orderId);
    ApiResult<OrderResponseModel> orderResponseModel =
        await orderStatus(url: url, token: token, orderModel: orderModel);

    return orderResponseModel.when(
      success: (orderResponseModel) {
        return ApiResult.success(data: orderResponseModel);
      },
      failure: (NetworkExceptions error) {
        return ApiResult.failure(error: error);
      },
    );
  }

  Future<String> getUrlForSentOTP() async {
    return await getFileUrl();
  }

  Future<String> getTokenForSentOTP() async {
    return await userDatabaseOps.getUserToken(0);
  }
}
