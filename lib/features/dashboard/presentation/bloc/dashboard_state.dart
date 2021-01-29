part of 'dashboard_bloc.dart';

abstract class OTPState extends Equatable {
  const OTPState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends OTPState {}

class DashboardLoaded extends OTPState {
  final DashboardList dashboardList;
  final List<String> columnList;

  DashboardLoaded({@required this.dashboardList, @required this.columnList});
}

class DashboardFailure extends OTPState {}
