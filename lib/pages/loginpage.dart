import 'package:bitcope/model/usermodel.dart';
import 'package:bitcope/utils/customtext.dart';
import 'package:bitcope/utils/customtextfield.dart';
import 'package:bitcope/utils/sizeconfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserModel _userModel;

  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                Row(
                  children: [
                    SizedBox(width: 4.0 * SizeConfig.widthMultiplier),
                    Icon(Icons.arrow_back,
                        color: Colors.white,
                        size: 7.0 * SizeConfig.imageSizeMultiplier),
                  ],
                ),
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
              height: 10.0 * SizeConfig.heightMultiplier,
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
                      controller: emailTEC,
                      keyboardType: TextInputType.emailAddress,
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.email,
                      name: 'Email*',
                      //initialValue: 'xyz@mail.com',
                      onSaved: (value) {
                        _userModel.email = value;
                      },
                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = new RegExp(pattern);
                        if (value.length == 0) {
                          return "Email is Required";
                        } else if (!regExp.hasMatch(value)) {
                          return "Invalid Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
                    customTextFields(
                      controller: passwordTEC,
                      keyboardType: TextInputType.text,
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.visibility,
                      name: 'Password*',
                      //initialValue: '***********',
                      onSaved: (value) {
                        _userModel.password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Password is Required';
                        return null;
                      },
                    ),
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
                            fontSize: 1.6 * SizeConfig.textMultiplier,
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
            Padding(
              padding: EdgeInsets.only(
                  left: 11.0 * SizeConfig.widthMultiplier,
                  right: 11.0 * SizeConfig.widthMultiplier),
              child: RaisedButton(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xFFFF3799),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0 * SizeConfig.widthMultiplier))),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print('im okey');
                    _formKey.currentState.save();
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
                            fontSize: 1.6 * SizeConfig.textMultiplier,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                              fontSize: 1.6 * SizeConfig.textMultiplier,
                              color: Colors.red,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()..onTap = () {},
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
  }
}
