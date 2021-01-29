part of 'qrcode_validate_bloc.dart';

abstract class QrcodeValidateState {}

class QrcodeValidateInitial extends QrcodeValidateState {
  QrcodeValidateInitial();
}

class QrcodeValidated extends QrcodeValidateState {
  final List<String> validQrCodes;
  final String transactionID;
  QrcodeValidated({@required this.validQrCodes, @required this.transactionID});
}

class QrcodeValidationFailed extends QrcodeValidateState {
  final QRResponceList qrResponceList;
  QrcodeValidationFailed({@required this.qrResponceList});
}
