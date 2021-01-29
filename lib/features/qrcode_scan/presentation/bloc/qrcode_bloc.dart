import 'dart:async';

import 'package:bitcope/features/qrcode_scan/data/repository/qrcode_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  QrcodeBloc({@required this.qrRepository})
      : assert(qrRepository != null),
        super(QrcodeInitial());
  final QrRepository qrRepository;
  @override
  Stream<QrcodeState> mapEventToState(
    QrcodeEvent event,
  ) async* {
    if (event is QRScanButtonPressed) {
      try {
        String status = await qrRepository.getQrCode();
        print(status);
        if (status == 'valid') {
          yield QrcodeAdded(qrListForPL: qrRepository.qrStringList);
        } else if (status == 'duplicate') {
          yield QRIsDuplicate();
        } else if (status == 'invalid') {
          yield QRIsInvalid();
        }
        //List<String> qrCodeList = List.of(qrRepository.qrStringList);
        yield QrcodeAdded(qrListForPL: qrRepository.qrStringList);
      } catch (e) {}
    }
  }
}
