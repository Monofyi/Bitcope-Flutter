import 'dart:async';

import 'package:bitcope/core/error_handling/api_result.dart';
import 'package:bitcope/core/error_handling/network_exceptions.dart';
import 'package:bitcope/features/sendotp/data/model/order_status_response.dart';
import 'package:bitcope/features/sendotp/data/model/otp_response_model.dart';
import 'package:bitcope/features/sendotp/data/repository/otp_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  OTPBloc({@required this.otpRepository})
      : assert(OTPRepository != null),
        super(OTPInitial());
  final OTPRepository otpRepository;
  @override
  Stream<OTPState> mapEventToState(
    OTPEvent event,
  ) async* {
    if (event is GetOTPButtonPressed) {
      yield LoadProgressBar();
      try {
        String token = await otpRepository.getTokenForSentOTP();
        String url = Uri.https(
                await otpRepository
                    .getUrlForSentOTP()
                    .then((value) => value.substring(8)),
                "/send_otp/")
            .toString()
            .trim();

        ApiResult<OTPResponseModel> otpResponse =
            await otpRepository.otpValidationResponse(
                retailerName: event.retailerName,
                phoneno: event.phoneno,
                token: token,
                transactionid: event.transactionId,
                url: url);
        //session_id = otpResponse.details;

        yield* otpResponse.when(success: (otpResponse) async* {
          if ((otpResponse.status).contains('Success')) {
            yield OTPHasSent();
          }
          if (otpResponse.status != 'Success') {
            yield OTPHaveNotSent();
          }
        }, failure: (NetworkExceptions error) async* {
          //yield LoginFaliure(error: NetworkExceptions.getErrorMessage(error));
        });
      } catch (e) {}
    }
    if (event is VerifyOTPButtonPressed) {
      yield LoadProgressBar();
      try {
        String token = await otpRepository.getTokenForSentOTP();
        String urlValidateOtp = Uri.https(
                await otpRepository
                    .getUrlForSentOTP()
                    .then((value) => value.substring(8)),
                "/validate_sms_otp/")
            .toString()
            .trim();
        String updateOrderStatus = Uri.https(
                await otpRepository
                    .getUrlForSentOTP()
                    .then((value) => value.substring(8)),
                "/order_status_update/")
            .toString()
            .trim();
        ApiResult<OTPResponseModel> otpVerifyResponse =
            await otpRepository.otpVerifyResponse(
                otp: event.otp, token: token, url: urlValidateOtp);
        yield* otpVerifyResponse.when(success: (otpVerifyResponse) async* {
          if ((otpVerifyResponse.status).contains('Success')) {
            ApiResult<OrderResponseModel> orderSuccess =
                await otpRepository.orderSuccessResponse(
                    orderId: event.transactionId,
                    token: token,
                    url: updateOrderStatus);
            yield* orderSuccess.when(
              success: (orderSuccess) async* {
                if (orderSuccess.status.contains('True')) {
                  yield OTPHasVerfied();
                }
              },
              failure: (NetworkExceptions error) async* {
                //yield LoginFaliure(error: NetworkExceptions.getErrorMessage(error));
              },
            );
          }
          if (otpVerifyResponse.status != 'Success') {
            yield OTPHasVerficationFailed();
          }
        }, failure: (NetworkExceptions error) async* {
          //yield LoginFaliure(error: NetworkExceptions.getErrorMessage(error));
        });
      } catch (e) {}
    }
  }
}
