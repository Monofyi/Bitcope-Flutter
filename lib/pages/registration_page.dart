import 'dart:ui';

import 'package:bitcope/utils/customtext.dart';
import 'package:bitcope/utils/customtextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String choosedRecoveryQuestion;
  List<String> recoveryQuestions = [
    'What is the name of your first pet?',
    'Who was your childhood hero?',
    'Where was your best family vacation as a kid?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: CustomText(
      //     text: 'Bitecope',
      //     color: Colors.white,
      //   ),
      // ),
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
                    //Icon(Icons.arrow_back, color: Colors.white),

                    CustomText(
                      text: 'Bitecope',
                      color: Colors.white,
                      size: 30,
                      weight: FontWeight.bold,
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15),
              child: CustomText(
                text: 'SIGN UP',
                color: Colors.white,
                weight: FontWeight.bold,
                size: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 18.0, bottom: 10.0, left: 15),
            //   child: CustomText(
            //     text: 'Details',
            //     color: Colors.white,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  customTextFields(
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.account_box,
                      name: 'User Name*',
                      initialValue: 'imssurya'),

                  SizedBox(height: 8),
                  customTextFields(
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.email,
                      name: 'Email*',
                      initialValue: 'xyz@mail.com'),

                  SizedBox(height: 8),
                  // customTextFiels(context, 'Phone No*', Icons.phone),
                  // SizedBox(height: 8),
                  customTextFields(
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.visibility,
                      name: 'Password*',
                      initialValue: '***********'),

                  SizedBox(height: 8),
                  customTextFields(
                      context: context,
                      color: Colors.white24,
                      iconData: Icons.visibility,
                      name: 'Confirm Password*',
                      initialValue: '***********'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.check_box_outline_blank, color: Colors.white60),
                  SizedBox(width: 5),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'I Read and agree to , ',
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
                  // CustomText(
                  //   text: 'I Read and agree to terms & Conditions',
                  //   color: Colors.white60,
                  //   size: 15,
                  // ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: RaisedButton(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xFFFF3799),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1.0,
                    width: 90.0,
                    color: Colors.white60,
                  ),
                  CustomText(
                    text: '  Or Connect With  ',
                    color: Colors.white60,
                    size: 13,
                  ),
                  Container(
                    height: 1.0,
                    width: 90.0,
                    color: Colors.white60,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            // Container(
            //   height: 20,
            //   width: 20,
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.circular(20),
            //   ),

            //   //boxShadow: BaseStyles.boxShadow),
            //   child: Icon(
            //     FontAwesomeIcons.facebookF,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48.0,
                  width: 48.0,
                  child: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black54,
                    //       offset: Offset(0, 2),
                    //       blurRadius: 6.0)
                    // ],
                    // image: DecorationImage(
                    //   image: logo,
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 48.0,
                  width: 48.0,
                  child: Icon(
                    FontAwesomeIcons.googlePlusG,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black54,
                    //       offset: Offset(0, 2),
                    //       blurRadius: 6.0)
                    // ],
                    // image: DecorationImage(
                    //   image: logo,
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 48.0,
                  width: 48.0,
                  child: Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1DA1F2),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black54,
                    //       offset: Offset(0, 2),
                    //       blurRadius: 6.0)
                    // ],
                    // image: DecorationImage(
                    //   image: logo,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
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
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // GFIconButton(
            //   onPressed: () {},
            //   text: "primary",
            //   icon: Icon(Icons.),
            // ),
            // Row(
            //   children: <Widget>[
            //     Container(

            //         //    margin: EdgeInsets.all(100.0),
            //         decoration: BoxDecoration(
            //             color: Colors.white, shape: BoxShape.circle),
            //         child: Icon(
            //           FontAwesomeIcons.facebook,
            //         )),
            //     Container()
            //   ],
            // )
            // Padding(
            //   padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15),
            //   child: CustomText(
            //     text: 'Recovery Options',
            //     color: Colors.white,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 28.0, right: 28.0),
            //   child: Container(
            //     child: Center(
            //       child: Column(
            //         children: [
            //           DropdownButton(
            //             hint: Text('Select Question'),
            //             value: choosedRecoveryQuestion,
            //             items: recoveryQuestions.map((value) {
            //               return DropdownMenuItem(
            //                 value: value,
            //                 child: Text(value),
            //               );
            //             }).toList(),
            //             onChanged: (value) {
            //               setState(
            //                 () {
            //                   choosedRecoveryQuestion = value;
            //                 },
            //               );
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
