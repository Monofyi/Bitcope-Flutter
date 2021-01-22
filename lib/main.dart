import 'package:bitcope/features/homepage/presentation/pages/home_page.dart';
import 'package:bitcope/features/authentication/bloc/authentication_bloc.dart';
import 'package:bitcope/features/login_register/data/repository/user_repository.dart';
import 'package:bitcope/features/login_register/presentation/pages/loginpage.dart';
import 'package:bitcope/features/splash/presentation/pages/splash_page.dart';
import 'package:bitcope/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/sizeconfig.dart';
// void main() {
//   runApp(MyApp());

// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return OrientationBuilder(
//           builder: (context, orientation) {
//             SizeConfig().init(constraints, orientation);
//             return MultiProvider(
//                 providers: [
//                   ChangeNotifierProvider.value(
//                       value: AccountProvider.initialize()),
//                 ],
//                 child: MaterialApp(
//                   debugShowCheckedModeBanner: false,
//                   title: 'Flutter App',
//                   theme: ThemeData(
//                     primarySwatch: Colors.blueGrey,
//                     brightness: Brightness.light,
//                     visualDensity: VisualDensity.adaptivePlatformDensity,
//                   ),
//                   home: LoginPage(),
//                 ));
//           },
//         );
//       },
//     );
//   }
// }

void main() {
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
                  return HomePage();
                }
                if (state is AuthenticationUnauthenticated) {
                  return LoginPage(
                    userRepository: userRepository,
                  );
                }
                return LoadingIndicator();
              },
            ),
          );
        });
      },
    );
  }
}
