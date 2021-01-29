import 'package:bitcope/core/server_switch/server_switch.dart';
import 'package:bitcope/features/qrcode_validate/data/datasources/bitecope_qr_validator.dart';
import 'package:bitcope/features/qrcode_validate/data/model/qr_response_model.dart';
import 'package:bitcope/features/qrcode_validate/data/model/validate_qrcode_model.dart';
import 'package:meta/meta.dart';
import 'package:bitcope/core/database/user_database_operations.dart';

class QrValidationRepository {
  final userDatabaseOps = UserDatabaseOps();
  Future<QRResponceList> qrValidationResponse(
      {@required String token,
      @required String url,
      @required String crates,
      @required String userName}) async {
    ValidateCrate validateCrate = ValidateCrate(
        crate_id: crates, location: "fhgjojo", deliveryAgent: userName);
    QRResponceList qrResponce = await validateQRCodeDataAPI(
        token: token, url: url, validateCrate: validateCrate);
    return qrResponce;
  }

  Future<String> getUrlForValidateQr() async {
    return await getFileUrl();
  }

  Future<String> getTokenForValidateQr() async {
    return await userDatabaseOps.getUserToken(0);
  }

  Future<String> getUserNameForValidateQr() async {
    return await userDatabaseOps.getUserName(0);
  }
}
