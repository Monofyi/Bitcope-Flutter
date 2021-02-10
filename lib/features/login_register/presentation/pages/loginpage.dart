import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/login_register/data/repository/user_repository.dart';
import 'package:bitcope/features/login_register/presentation/bloc/login_bloc.dart';
import 'package:bitcope/features/login_register/presentation/cubit/visibility_cubit.dart';
import 'package:bitcope/core/utils/customtext.dart';
import 'package:bitcope/core/utils/customtextfield.dart';
import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  IconData icon = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: widget.userRepository,
            );
          },
        ),
        BlocProvider(
          create: (_) => VisibilityCubit(),
        ),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
          if (state is LoginFaliure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 1200),
                content: Container(
                    height: 4.5 * SizeConfig.heightMultiplier,
                    child: Center(child: Text('${state.error}'))),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is LoginLoading) {
            return Scaffold(
              body: CircularProgressIndicator(),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          final isVisible = context.watch<VisibilityCubit>().state;
          return Scaffold(
            key: _scaffoldKey,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  //stops: [0.3, 0.6, .9],
                  colors: [
                    Color(0xff993164),
                    Color(0xff6E3869),
                    Color(0xff323F6C),
                  ],
                ),
              ),
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(
                            text: 'Bitecope',
                            color: Colors.white,
                            size: 3.5 * SizeConfig.textMultiplier,
                            weight: FontWeight.bold,
                          )
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(width: 4.0 * SizeConfig.widthMultiplier),
                      //     Icon(Icons.arrow_back,
                      //         color: Colors.white,
                      //         size: 7.0 * SizeConfig.imageSizeMultiplier),
                      //   ],
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.0 * SizeConfig.heightMultiplier,
                        left: 5.0 * SizeConfig.widthMultiplier),
                    child: CustomText(
                      text: 'SIGN IN',
                      color: Colors.white,
                      weight: FontWeight.bold,
                      size: 2.0 * SizeConfig.textMultiplier,
                    ),
                  ),
                  SizedBox(
                    height: 8.0 * SizeConfig.heightMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0 * SizeConfig.widthMultiplier,
                        right: 8.0 * SizeConfig.widthMultiplier),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          customTextFields(
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                            context: context,
                            color: Colors.white24,
                            iconData: Icons.email,
                            name: 'Email*',
                            //initialValue: 'xyz@mail.com',
                            // onSaved: (value) {
                            //   _loginModel.email = value;
                            // },
                            validator: (value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                              String patttern_2 = r'(^[a-zA-Z0-9_]{4,16}$)';
                              RegExp regExp = RegExp(
                                  value.toString().contains('@')
                                      ? pattern
                                      : patttern_2);
                              if (value.length == 0) {
                                return "Email is Required";
                              } else if (!regExp.hasMatch(value)) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            obscureText: false,
                          ),
                          SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
                          customTextFields(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              context: context,
                              color: Colors.white24,
                              iconData: isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              name: 'Password*',
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'Password is Required';
                                return null;
                              },
                              obscureText: !isVisible,
                              iconTap: () {
                                context
                                    .read<VisibilityCubit>()
                                    .toggleVisibility();
                              }),
                          SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0 * SizeConfig.widthMultiplier,
                        right: 8.0 * SizeConfig.widthMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Forget password? ',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 1.9 * SizeConfig.textMultiplier,
                                ),
                              ),
                              // TextSpan(
                              //   text: 'terms & Conditions',
                              //   style: TextStyle(
                              //       color: Colors.red,
                              //       decoration: TextDecoration.underline),
                              //   recognizer: TapGestureRecognizer()..onTap = () {},
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                  // state is ShowProgressBar
                  //     ? CircularProgressIndicator()
                  //     : Container(),
                  // BlocListener<LoginBloc, LoginState>(
                  //   listenWhen: (LoginButtonPressed, ShowProgressBarEvent) {
                  //     return false;
                  //   },
                  //   listener: (BuildContext context, state) {
                  //     if (state is ShowProgressBar) {}
                  //   },
                  //   child: CircularProgressIndicator(),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: 11.0 * SizeConfig.widthMultiplier,
                        right: 11.0 * SizeConfig.widthMultiplier),
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state is ShowProgressBar
                              ? SizedBox(
                                  width: 5.0 * SizeConfig.widthMultiplier,
                                  height: 5.0 * SizeConfig.widthMultiplier,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  'SIGN IN',
                                  style: TextStyle(color: Colors.white),
                                ),
                          SizedBox(
                            width: 1.0 * SizeConfig.widthMultiplier,
                          ),
                          // state is ShowProgressBar
                          //     ? SizedBox(
                          //         width: 5.0 * SizeConfig.widthMultiplier,
                          //         height: 5.0 * SizeConfig.widthMultiplier,
                          //         child: CircularProgressIndicator(),
                          //       )
                          //     : Container(),
                        ],
                      ),
                      color: Color(0xFFFF3799),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0 * SizeConfig.widthMultiplier))),
                      onPressed: state is ShowProgressBar
                          ? () {}
                          : () {
                              if (_formKey.currentState.validate()) {
                                //print('im okey');
                                // _formKey.currentState.save();

                                BlocProvider.of<LoginBloc>(context)
                                    .add(LoginButtonPressed(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ));
                                BlocProvider.of<LoginBloc>(context).add(
                                    ShowProgressBarEvent(showProgress: true));
                              }
                            },
                    ),
                  ),
                  SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: 8.0 * SizeConfig.widthMultiplier,
                  //       right: 8.0 * SizeConfig.widthMultiplier),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         height: 0.18 * SizeConfig.heightMultiplier,
                  //         width: 20.0 * SizeConfig.widthMultiplier,
                  //         color: Colors.white60,
                  //       ),
                  //       CustomText(
                  //         text: '  Or Connect With  ',
                  //         color: Colors.white60,
                  //         size: 1.6 * SizeConfig.textMultiplier,
                  //       ),
                  //       Container(
                  //         height: 0.18 * SizeConfig.heightMultiplier,
                  //         width: 20.0 * SizeConfig.widthMultiplier,
                  //         color: Colors.white60,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     socialMediaButtons(
                  //         icon: FontAwesomeIcons.facebookF, color: Colors.blue),
                  //     SizedBox(width: 4.0 * SizeConfig.widthMultiplier),
                  //     socialMediaButtons(
                  //         icon: FontAwesomeIcons.googlePlusG, color: Colors.red),
                  //     SizedBox(width: 4.0 * SizeConfig.widthMultiplier),
                  //     socialMediaButtons(
                  //         icon: FontAwesomeIcons.twitter, color: Color(0xFF1DA1F2)),
                  //   ],
                  // ),
                  SizedBox(
                    height: 3.0 * SizeConfig.heightMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8.0 * SizeConfig.widthMultiplier,
                        right: 8.0 * SizeConfig.widthMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 1.9 * SizeConfig.textMultiplier,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                    fontSize: 1.9 * SizeConfig.textMultiplier,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             RegistrationPage()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
