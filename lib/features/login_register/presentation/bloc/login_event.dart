part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class ShowProgressBarEvent extends LoginEvent {
  final bool showProgress;

  ShowProgressBarEvent({@required this.showProgress});

  List<Object> get props => [showProgress];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
