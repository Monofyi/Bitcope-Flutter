import 'package:bitcope/features/qrcode_scan/data/datasources/bitecope_qr_scanner.dart';

class QrRepository {
  List<String> qrCodeList = [];
  Future<String> getQrCode() async {
    String value = await getBiteQRCode();
    if (value != null && value != '-1') {
      if (!qrCodeList.contains(value)) {
        qrCodeList.add(value);
        return "valid";
      } else {
        return "duplicate";
      }
    }
    return "invalid";
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
