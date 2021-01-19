import 'package:bitcope/pages/loginpage.dart';
import 'package:bitcope/utils/sizeconfig.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter App',
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                brightness: Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: LoginPage(),
            );
          },
        );
      },
    );
  }
}
