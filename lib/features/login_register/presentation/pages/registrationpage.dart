import 'package:bitcope/features/login_register/data/repository/user_repository.dart';
import 'package:bitcope/features/login_register/presentation/pages/loginpage.dart';
import 'package:bitcope/core/utils/customtext.dart';
import 'package:bitcope/core/utils/customtextfield.dart';
import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:bitcope/core/utils/socialmediabuttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController userNameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController confirmPasswordTEC = TextEditingController();
  bool termsCheckBox = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserRepository userRepository = UserRepository();
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
                  top: 5.0 * SizeConfig.heightMultiplier,
                  left: 5.0 * SizeConfig.widthMultiplier),
              child: CustomText(
                text: 'SIGN UP',
                color: Colors.white,
                weight: FontWeight.bold,
                size: 2.0 * SizeConfig.textMultiplier,
              ),
            ),
            SizedBox(
              height: 2.0 * SizeConfig.heightMultiplier,
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
                      controller: userNameTEC,
                      keyboardType: TextInputType.text,
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.account_box,
                      name: 'User Name*',
                      //initialValue: 'imssurya',

                      validator: (value) {
                        //^[a-z0-9_]{8,16}$
                        String patttern = r'(^[a-zA-Z0-9_]{8,16}$)';
                        RegExp regExp = RegExp(patttern);
                        if (value.length == 0) {
                          return "User Name is Required";
                        } else if (!regExp.hasMatch(value)) {
                          return "User Name must be atleast 8 letters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
                    customTextFields(
                      controller: emailTEC,
                      keyboardType: TextInputType.emailAddress,
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.email,
                      name: 'Email*',
                      //initialValue: 'xyz@mail.com',

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

                      validator: (value) {
                        if (value.isEmpty) return 'Password is Required';
                        return null;
                      },
                    ),
                    SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
                    customTextFields(
                      controller: confirmPasswordTEC,
                      keyboardType: TextInputType.text,
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.visibility,
                      name: 'Confirm Password*',
                      //initialValue: '***********',

                      validator: (value) {
                        if (value.isEmpty) return 'Password is Required Here';
                        if (value != passwordTEC.text)
                          return 'Password and Confirm password Not Matched';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
            Padding(
              padding: EdgeInsets.only(
                  left: 8.0 * SizeConfig.widthMultiplier,
                  right: 8.0 * SizeConfig.widthMultiplier),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                        termsCheckBox == false
                            ? Icons.check_box_outline_blank
                            : Icons.check_box_outlined,
                        color: Colors.white60),
                    onTap: () {
                      print('object');
                      setState(() {
                        termsCheckBox = !termsCheckBox;
                      });
                    },
                  ),
                  SizedBox(width: 1.5 * SizeConfig.widthMultiplier),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'I Read and agree to, ',
                          style: TextStyle(color: Colors.white60),
                        ),
                        TextSpan(
                          text: 'terms & Conditions',
                          style: TextStyle(
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
            SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
            Padding(
              padding: EdgeInsets.only(
                  left: 8.0 * SizeConfig.widthMultiplier,
                  right: 8.0 * SizeConfig.widthMultiplier),
              child: RaisedButton(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xFFFF3799),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0 * SizeConfig.widthMultiplier))),
                onPressed: () {
                  if (_formKey.currentState.validate() && termsCheckBox) {
                    print('im okey');
                    _formKey.currentState.save();
                  }
                  if (!_formKey.currentState.validate() || !termsCheckBox) {
                    return _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Container(
                          color: Colors.transparent,
                          height: 2.5 * SizeConfig.heightMultiplier,
                          child: Center(
                            child: CustomText(
                                text:
                                    'Please read Terms&Conditions and Approve',
                                color: Colors.white),
                          )),
                      duration: Duration(milliseconds: 900),
                    ));
                  }
                },
              ),
            ),
            SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
            Padding(
              padding: EdgeInsets.only(
                  left: 8.0 * SizeConfig.widthMultiplier,
                  right: 8.0 * SizeConfig.widthMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 0.18 * SizeConfig.heightMultiplier,
                    width: 20.0 * SizeConfig.widthMultiplier,
                    color: Colors.white60,
                  ),
                  CustomText(
                    text: '  Or Connect With  ',
                    color: Colors.white60,
                    size: 2.0 * SizeConfig.textMultiplier,
                  ),
                  Container(
                    height: 0.18 * SizeConfig.heightMultiplier,
                    width: 20.0 * SizeConfig.widthMultiplier,
                    color: Colors.white60,
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.0 * SizeConfig.heightMultiplier),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialMediaButtons(
                    icon: FontAwesomeIcons.facebookF, color: Colors.blue),
                SizedBox(width: 3.0 * SizeConfig.widthMultiplier),
                socialMediaButtons(
                    icon: FontAwesomeIcons.googlePlusG, color: Colors.red),
                SizedBox(width: 3.0 * SizeConfig.widthMultiplier),
                socialMediaButtons(
                    icon: FontAwesomeIcons.twitter, color: Color(0xFF1DA1F2)),
              ],
            ),
            SizedBox(
              height: 1.0 * SizeConfig.heightMultiplier,
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
                          text: 'Already have an Account ? ',
                          style: TextStyle(color: Colors.white60),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                      userRepository: userRepository)));
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.0 * SizeConfig.heightMultiplier,
            ),
          ],
        ),
      ),
    );
  }
}
