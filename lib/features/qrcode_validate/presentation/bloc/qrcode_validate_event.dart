part of 'qrcode_validate_bloc.dart';

abstract class QrcodeValidateEvent {}

class QRValidateButtonPressed extends QrcodeValidateEvent {}

class CheckBoxClicked extends QrcodeValidateEvent {}
