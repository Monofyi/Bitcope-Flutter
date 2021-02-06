part of 'otp_bloc.dart';

abstract class OTPEvent extends Equatable {
  const OTPEvent();

  @override
  List<Object> get props => [];
}

class GetOTPButtonPressed extends OTPEvent {
  final int phoneno;
  final String transactionId;
  final String retailerName;

  GetOTPButtonPressed(
      {@required this.phoneno,
      @required this.transactionId,
      @required this.retailerName});
}

class VerifyOTPButtonPressed extends OTPEvent {
  final String otp;
  final String transactionId;
  VerifyOTPButtonPressed({@required this.otp, @required this.transactionId});
}
