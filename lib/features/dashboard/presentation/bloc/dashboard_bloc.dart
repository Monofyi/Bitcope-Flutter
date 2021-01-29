import 'dart:async';

import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';
import 'package:bitcope/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class OTPBloc extends Bloc<DashboardEvent, OTPState> {
  OTPBloc({@required this.dashboardRepository})
      : assert(DashboardRepository != null),
        super(DashboardInitial());
  final DashboardRepository dashboardRepository;
  @override
  Stream<OTPState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is DashboardFetched) {
      try {
        yield DashboardInitial();
        String token = await dashboardRepository.getTokenForDashboard();
        String url = Uri.https(
                await dashboardRepository
                    .getUrlForDashboard()
                    .then((value) => value.substring(8)),
                "/order_list/")
            .toString()
            .trim();
        final dashBoardData =
            await dashboardRepository.getDashboardData(token: token, url: url);
        List<String> columnList = dashboardRepository.columnList;
        yield DashboardLoaded(
            dashboardList: dashBoardData, columnList: columnList);
      } catch (e) {
        print(e.toString());
        yield DashboardFailure();
      }
    }
  }
}
