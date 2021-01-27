import 'package:bitcope/core/database/user_database_operations.dart';
import 'package:bitcope/core/server_switch/server_switch.dart';
import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';
import 'package:bitcope/features/dashboard/data/datasources/bitecope_api_call_dashboard.dart';
import 'package:meta/meta.dart';

class DashboardRepository {
  final userDatabaseOps = UserDatabaseOps();
  Future<DashboardList> getDashboardData(
      {@required String token, @required String url}) async {
    DashboardList dashboard = await getDashBoardData(token: token, url: url);
    return dashboard;
  }

  Future<String> getTokenForDashboard() async {
    return await userDatabaseOps.getUserToken(0);
  }

  Future<String> getUrlForDashboard() async {
    return await getFileUrl();
  }

  List<String> columnList = [
    'transaction_id',
    'crate_id',
    'location',
    'deliveryStatus',
    'deliveryAgent',
    'timestamp'
  ];
}
