import 'dart:async';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/login_register/data/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:bitcope/core/server_switch/server_switch.dart' as ss;
import 'package:permission_handler/permission_handler.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInitial();
      yield ShowProgressBar();

      try {
        PermissionStatus _permissionStatus = await Permission.storage.status;
        if (_permissionStatus != PermissionStatus.granted) {
          Permission.storage.request();
        }
        final bool hasFile = await ss.hasFile();
        print('file is :' + hasFile.toString());
        if (hasFile) {
          String serverUrl = await ss.getFileUrl();
          print('serverURL is : ' + serverUrl.trim() + '/login/');
          final user = await userRepository.authenticate(
            username: event.username,
            password: event.password,
            url: serverUrl.trim() + '/login/',
          );
          authenticationBloc.add(LoggedIn(user: user));
          yield LoginInitial();
        } else {
          String serverUrl = await ss.downloadServerDetailsFile();
          print('serverURL is : ' + serverUrl.trim() + '/login/');
          final user = await userRepository.authenticate(
            username: event.username,
            password: event.password,
            url: serverUrl.trim() + '/login/',
          );
          authenticationBloc.add(LoggedIn(user: user));
          yield LoginInitial();
        }
      } catch (error) {
        print(error);
        yield LoginFaliure(error: error.toString());
      }
    }
  }
}
