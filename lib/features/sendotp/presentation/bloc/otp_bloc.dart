import 'dart:async';

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

        final otpResponse = await otpRepository.otpValidationResponse(
            retailerName: event.retailerName,
            phoneno: event.phoneno,
            token: token,
            transactionid: event.transactionId,
            url: url);
        //session_id = otpResponse.details;
        if ((otpResponse.status).contains('Success')) {
          yield OTPHasSent();
        }
        if (otpResponse.status != 'Success') {
          yield OTPHaveNotSent();
        }
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
        final otpVerifyResponse = await otpRepository.otpVerifyResponse(
            otp: event.otp, token: token, url: urlValidateOtp);

        if ((otpVerifyResponse.status).contains('Success')) {
          final orderSuccess = await otpRepository.orderSuccessResponse(
              orderId: event.transactionId,
              token: token,
              url: updateOrderStatus);
          if (orderSuccess.status.contains('True')) {
            yield OTPHasVerfied();
          }
        }
        if (otpVerifyResponse.status != 'Success') {
          yield OTPHasVerficationFailed();
        }
      } catch (e) {}
    }
  }
}
