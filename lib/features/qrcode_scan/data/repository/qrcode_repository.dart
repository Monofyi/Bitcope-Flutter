import 'package:bitcope/core/error_handling/api_result.dart';
import 'package:bitcope/core/error_handling/network_exceptions.dart';
import 'package:bitcope/features/qrcode_scan/data/datasources/bitecope_qr_scanner.dart';

class QrRepository {
  List<String> qrCodeList = [];
  Future<ApiResult<String>> getQrCode() async {
    ApiResult<String> value = await getBiteQRCode();

    return value.when(success: (value) {
      if (value != null && value != '-1') {
        if (!qrCodeList.contains(value)) {
          qrCodeList.add(value);
          return ApiResult.success(data: "valid");
        } else {
          return ApiResult.success(data: "duplicate");
        }
      } else {
        return ApiResult.success(data: "Invalid Qrcode");
      }
    }, failure: (NetworkExceptions error) {
      return ApiResult.failure(error: error);
    });
  }

  String get listToString {
    String listToString = '';
    for (String qr in qrCodeList) {
      listToString = qr + "," + listToString;
    }
    listToString = listToString.endsWith(',')
        ? listToString.substring(0, listToString.length - 1)
        : listToString;
    print(listToString);
    return listToString;
  }

  List<String> get qrStringList {
    return List.of(qrCodeList);
  }
}
