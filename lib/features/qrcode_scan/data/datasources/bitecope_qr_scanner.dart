import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> getBiteQRCode() async {
  try {
    return await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
  } on PlatformException {} catch (UnsupportedError) {
    UnsupportedError('An unsupported error occured');
  }
  return null;
}
