import 'dart:async';

import 'package:bitcope/features/qrcode_scan/data/repository/qrcode_repository.dart';
import 'package:bitcope/features/qrcode_validate/data/model/qr_response_model.dart';
import 'package:bitcope/features/qrcode_validate/data/repository/qrcode_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qrcode_validate_event.dart';
part 'qrcode_validate_state.dart';

class QrcodeValidateBloc
    extends Bloc<QrcodeValidateEvent, QrcodeValidateState> {
  QrcodeValidateBloc(
      {@required this.qrValidationRepository, @required this.qrRepository})
      : assert(qrValidationRepository != null),
        super(QrcodeValidateInitial());
  final QrValidationRepository qrValidationRepository;
  final QrRepository qrRepository;
  @override
  Stream<QrcodeValidateState> mapEventToState(
    QrcodeValidateEvent event,
  ) async* {
    if (event is QRValidateButtonPressed) {
      try {
        String token = await qrValidationRepository.getTokenForValidateQr();
        String url = Uri.https(
                await qrValidationRepository
                    .getUrlForValidateQr()
                    .then((value) => value.substring(8)),
                "/order_checkout/")
            .toString()
            .trim();

        String userName =
            await qrValidationRepository.getUserNameForValidateQr();
        final qrResponceList =
            await qrValidationRepository.qrValidationResponse(
                token: token,
                url: url,
                crates: qrRepository.listToString,
                userName: userName);

        List<String> validQrCodes = [];
        for (var list in qrRepository.qrCodeList) {
          for (var responce in qrResponceList.qrResponceList) {
            if (list != responce.qrcode) {
              validQrCodes.add(list);
            }
          }
        }
        yield QrcodeValidated(
            validQrCodes: validQrCodes,
            transactionID: qrResponceList.qrResponceList[0].transactionId);
      } catch (e) {}
    }
  }
}
