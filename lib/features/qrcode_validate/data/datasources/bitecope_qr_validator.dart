import 'package:bitcope/features/qrcode_validate/data/model/qr_response_model.dart';
import 'package:bitcope/features/qrcode_validate/data/model/validate_qrcode_model.dart';
import 'package:dio/dio.dart';

Dio _dio = Dio();

Future<QRResponceList> validateQRCodeDataAPI(
    {String token, String url, ValidateCrate validateCrate}) async {
  try {
    _dio.options.headers["Authorization"] = "Token $token";
    final Response response = await _dio.post(
      url,
      data: validateCrate.toDatabaseJson(),
    );
    if (response.statusCode == 200) {
      return QRResponceList.fromJson(response.data);
    } else {
      throw Exception(response.data);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
