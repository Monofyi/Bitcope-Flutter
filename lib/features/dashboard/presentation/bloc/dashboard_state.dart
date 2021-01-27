part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardList dashboardList;
  final List<String> columnList;

  DashboardLoaded({@required this.dashboardList, @required this.columnList});
}

class DashboardFailure extends DashboardState {}
