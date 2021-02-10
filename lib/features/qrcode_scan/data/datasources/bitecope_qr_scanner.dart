import 'package:bitcope/core/error_handling/api_result.dart';
import 'package:bitcope/core/error_handling/network_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<ApiResult<String>> getBiteQRCode() async {
  try {
    return ApiResult.success(
        data: await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.QR));
  } on PlatformException {} catch (UnsupportedError) {
    return ApiResult.failure(
        error: NetworkExceptions.getDioException('Unexpected error occurred'));
  }
  return ApiResult.failure(
      error: NetworkExceptions.getDioException('Unexpected error occurred'));
}
