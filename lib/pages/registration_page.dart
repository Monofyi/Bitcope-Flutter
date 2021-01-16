import 'dart:ui';

import 'package:bitcope/utils/customtext.dart';
import 'package:bitcope/utils/customtextfield.dart';
import 'package:flutter/material.dart';
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
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
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 15),
              child: CustomText(
                text: 'SIGN UP',
                color: Colors.white,
                weight: FontWeight.bold,
                size: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 10.0, left: 15),
              child: CustomText(
                text: 'Details',
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  customTextFiels(context, 'User Name*', Icons.account_box),
                  SizedBox(height: 8),
                  customTextFiels(context, 'Email*', Icons.email),
                  SizedBox(height: 8),
                  customTextFiels(context, 'Phone No*', Icons.phone),
                  SizedBox(height: 8),
                  customTextFiels(context, 'Password*', Icons.lock),
                  SizedBox(height: 8),
                  customTextFiels(context, 'Confirm Password*', Icons.lock),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15),
              child: CustomText(
                text: 'Recovery Options',
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      DropdownButton(
                        hint: Text('Select Question'),
                        value: choosedRecoveryQuestion,
                        items: recoveryQuestions.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              choosedRecoveryQuestion = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
