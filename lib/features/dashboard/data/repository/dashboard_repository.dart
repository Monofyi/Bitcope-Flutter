import 'package:bitcope/core/database/user_database_operations.dart';
import 'package:bitcope/core/error_handling/api_result.dart';
import 'package:bitcope/core/error_handling/network_exceptions.dart';
import 'package:bitcope/core/server_switch/server_switch.dart';
import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';
import 'package:bitcope/features/dashboard/data/datasources/bitecope_api_call_dashboard.dart';
import 'package:meta/meta.dart';

class DashboardRepository {
  final userDatabaseOps = UserDatabaseOps();
  Future<ApiResult<DashboardList>> getDashboardData(
      {@required String token, @required String url}) async {
    ApiResult<DashboardList> dashboard =
        await getDashBoardData(token: token, url: url);
    return dashboard.when(
      success: (dashboard) {
        return ApiResult.success(data: dashboard);
      },
      failure: (NetworkExceptions error) {
        return ApiResult.failure(
            error: NetworkExceptions.getDioException(error));
      },
    );
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
