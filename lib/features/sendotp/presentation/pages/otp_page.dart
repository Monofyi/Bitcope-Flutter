import 'package:bitcope/core/utils/customtextfield.dart';
import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/sendotp/data/repository/otp_repository.dart';
import 'package:bitcope/features/sendotp/presentation/bloc/otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OTPPage extends StatelessWidget {
  final String transactionId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneNoController = TextEditingController();

  OTPPage({Key key, this.transactionId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final otpRepository = OTPRepository();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bitecope'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
            child: Icon(
              FontAwesomeIcons.signOutAlt,
            ),
          ),
          SizedBox(
            width: 6.0 * SizeConfig.widthMultiplier,
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return OTPBloc(otpRepository: otpRepository);
            },
          ),
        ],
        child: BlocBuilder<OTPBloc, OTPState>(
          builder: (context, state) {
            if (state is OTPInitial) {
              return Container(
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
                                controller: _phoneNoController,
                                keyboardType: TextInputType.emailAddress,
                                context: context,
                                color: Colors.white24,
                                iconData: Icons.email,
                                name: 'Phone number*',
                                validator: (value) {
                                  RegExp regExp = new RegExp(
                                    r"(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$",
                                  );
                                  if (value.length == 0) {
                                    return "Phone no is Required";
                                  } else if (!regExp.hasMatch(value)) {
                                    return "Phone no is invalid";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                      SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 11.0 * SizeConfig.widthMultiplier,
                            right: 11.0 * SizeConfig.widthMultiplier),
                        child: RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get OTP',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 1.0 * SizeConfig.widthMultiplier,
                              ),
                              state is LoadProgressBar
                                  ? SizedBox(
                                      width: 5.0 * SizeConfig.widthMultiplier,
                                      height: 5.0 * SizeConfig.widthMultiplier,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(),
                            ],
                          ),
                          color: Color(0xFFFF3799),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10.0 * SizeConfig.widthMultiplier))),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              BlocProvider.of<OTPBloc>(context).add(
                                GetOTPButtonPressed(
                                  phoneno: int.parse(_phoneNoController.text),
                                  transactionId: transactionId,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                      SizedBox(
                        height: 3.0 * SizeConfig.heightMultiplier,
                      ),
                    ],
                  ));
            }
            if (state is OTPHasSent) {
              _phoneNoController.clear();
              return Container(
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
                              controller: _phoneNoController,
                              keyboardType: TextInputType.emailAddress,
                              context: context,
                              color: Colors.white24,
                              iconData: Icons.email,
                              name: 'Enter OTP Here',
                              validator: (value) {
                                if (value.length != 6) {
                                  return "Please Enter 6 Digit OTP here";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                    SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 11.0 * SizeConfig.widthMultiplier,
                          right: 11.0 * SizeConfig.widthMultiplier),
                      child: RaisedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Finish Delivery',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 1.0 * SizeConfig.widthMultiplier,
                            ),
                            state is LoadProgressBar
                                ? SizedBox(
                                    width: 5.0 * SizeConfig.widthMultiplier,
                                    height: 5.0 * SizeConfig.widthMultiplier,
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                          ],
                        ),
                        color: Color(0xFFFF3799),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0 * SizeConfig.widthMultiplier))),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            BlocProvider.of<OTPBloc>(context).add(
                              VerifyOTPButtonPressed(
                                  otp: (_phoneNoController.text),
                                  transactionId: transactionId),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 3.0 * SizeConfig.heightMultiplier),
                    SizedBox(
                      height: 3.0 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
              );
            }
            if (state is OTPHasVerfied) {
              return Container(child: Text("Delivery Completed"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
