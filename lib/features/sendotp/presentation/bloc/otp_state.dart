part of 'otp_bloc.dart';

abstract class OTPState extends Equatable {
  const OTPState();

  @override
  List<Object> get props => [];
}

class OTPInitial extends OTPState {}

class OTPHasSent extends OTPState {}

class OTPHaveNotSent extends OTPState {}

class LoadProgressBar extends OTPState {}

class OTPHasVerfied extends OTPState {}

class OTPHasVerficationFailed extends OTPState {}
