import 'dart:convert';
import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';
import 'package:dio/dio.dart';

Future<DashboardList> getDashBoardData({String token, String url}) async {
  Dio _dio = Dio();
  try {
    //_dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["Authorization"] = "token $token";
    //response = await dio.post(url, data: data);
    final Response response = await _dio.get(url);
    if (response.statusCode == 200) {
      return DashboardList.fromJson(response.data);
    } else {
      throw Exception(json.decode(response.data));
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
