part of 'qrcode_bloc.dart';

abstract class QrcodeState {}

class QrcodeInitial extends QrcodeState {
  QrcodeInitial();
}

class QrcodeAdded extends QrcodeState {
  final List<String> qrListForPL;
  QrcodeAdded({@required this.qrListForPL});
}

class QRIsInvalid extends QrcodeState {
  QRIsInvalid();
}

class QRIsDuplicate extends QrcodeState {
  QRIsDuplicate();
}

class SomethingWentWrong extends QrcodeState {
  SomethingWentWrong();
}
