part of 'qrcode_bloc.dart';

abstract class QrcodeEvent {}

class QRScanButtonPressed extends QrcodeEvent {}

class QRValidateButtonPressed extends QrcodeEvent {}

class CheckBoxClicked extends QrcodeEvent {}
