part of 'qrcode_bloc.dart';

abstract class QrcodeState extends Equatable {
  const QrcodeState();

  @override
  List<Object> get props => [];
}

class QrcodeInitial extends QrcodeState {}
