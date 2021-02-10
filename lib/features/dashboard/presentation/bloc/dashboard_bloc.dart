import 'dart:async';

import 'package:bitcope/core/error_handling/api_result.dart';
import 'package:bitcope/core/error_handling/network_exceptions.dart';
import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';
import 'package:bitcope/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({@required this.dashboardRepository})
      : assert(DashboardRepository != null),
        super(DashboardInitial());
  final DashboardRepository dashboardRepository;
  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is DashboardFetched) {
      yield DashboardInitial();
      String token = await dashboardRepository.getTokenForDashboard();
      String url = Uri.https(
              await dashboardRepository
                  .getUrlForDashboard()
                  .then((value) => value.substring(8)),
              "/order_list/")
          .toString()
          .trim();
      ApiResult<DashboardList> dashBoardData =
          await dashboardRepository.getDashboardData(token: token, url: url);
      List<String> columnList = dashboardRepository.columnList;
      yield* dashBoardData.when(success: (dashBoardData) async* {
        yield DashboardLoaded(
            dashboardList: dashBoardData, columnList: columnList);
      }, failure: (NetworkExceptions error) async* {
        yield DashboardFailure();
      });
    }
    if (event is RefreshButtonPressed) {
      yield DashboardInitial();
      String token = await dashboardRepository.getTokenForDashboard();
      String url = Uri.https(
              await dashboardRepository
                  .getUrlForDashboard()
                  .then((value) => value.substring(8)),
              "/order_list/")
          .toString()
          .trim();
      ApiResult<DashboardList> dashBoardData =
          await dashboardRepository.getDashboardData(token: token, url: url);
      List<String> columnList = dashboardRepository.columnList;
      yield* dashBoardData.when(success: (dashBoardData) async* {
        yield DashboardLoaded(
            dashboardList: dashBoardData, columnList: columnList);
      }, failure: (NetworkExceptions error) async* {
        yield DashboardFailure();
      });
    }
  }
}
