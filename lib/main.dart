import 'dart:io';

import 'package:bitcope/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/login_register/data/repository/user_repository.dart';
import 'package:bitcope/features/login_register/presentation/pages/loginpage.dart';
import 'package:bitcope/features/splash/presentation/pages/splash_page.dart';
import 'package:bitcope/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/sizeconfig.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final userRepository = UserRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.red,
              brightness: Brightness.dark,
            ),
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is AuthenticationUninitialized) {
                  return SplashPage();
                }
                if (state is AuthenticationAuthenticated) {
                  return Dashboard();
                }
                if (state is AuthenticationUnauthenticated) {
                  return LoginPage(
                    userRepository: userRepository,
                  );
                }
                if (state is AuthenticationLoading) {
                  return LoadingIndicator();
                }
                return LoginPage(
                  userRepository: userRepository,
                );
              },
            ),
          );
        });
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
