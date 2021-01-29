import 'dart:convert';

import 'package:bitcope/features/qrcode_validate/data/model/qr_response_model.dart';
import 'package:bitcope/features/qrcode_validate/data/model/validate_qrcode_model.dart';
import 'package:http/http.dart' as http;

Future<QRResponceList> validateQRCodeDataAPI(
    {String token, String url, ValidateCrate validateCrate}) async {
  try {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Token' + ' ' + token,
      },
      body: validateCrate.toDatabaseJson(),
    );
    if (response.statusCode == 200) {
      return QRResponceList.fromJson(json.decode(response.body));
    } else {
      //print(json.decode(response.body).toString());
      throw Exception(response.body);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
