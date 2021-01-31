import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

var dio = Dio();
String urlData = "";
final fileUrl =
    "https://raw.githubusercontent.com/Monofyi/url_update/master/server.log";
Future<String> downloadServerDetailsFile() async {
  try {
    String fullPath = await getFilePath();
    //print('full path $fullPath');

    Response response = await dio.get(
      fileUrl,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    print(response.headers);
    print(response.data);

    File file = File(fullPath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    await raf.close();
    urlData = await file.readAsString();
    print(urlData);
  } catch (e) {
    print('Error is : ' + e.toString());
  }
  return urlData.trim();
}

Future<String> getFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  return directory.path + "/server.log";
}

Future<String> getFileUrl() async {
  String fullPath = await getFilePath();
  File file = File(fullPath);
  urlData = await file.readAsString();
  return urlData.trim();
}

Future<bool> hasFile() async {
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  return File(directory.path + 'server.log').exists();
}
