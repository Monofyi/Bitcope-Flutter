import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';

Future<DashboardList> getDashBoardData({String token, String url}) async {
  try {
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Token' + ' ' + token,
      },
      //body: Token(token: token).toJson(),
    );
    if (response.statusCode == 200) {
      //final data=

      return DashboardList.fromJson(json.decode(response.body));
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  } catch (e) {
    print(e.toString());
  }
}
