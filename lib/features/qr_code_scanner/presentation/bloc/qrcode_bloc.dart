import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  QrcodeBloc() : super(QrcodeInitial());

  @override
  Stream<QrcodeState> mapEventToState(
    QrcodeEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
