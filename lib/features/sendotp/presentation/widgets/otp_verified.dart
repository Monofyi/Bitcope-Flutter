import 'package:bitcope/core/utils/customtext.dart';
import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget otpVerified({@required Function onPressed}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 60.0 * SizeConfig.widthMultiplier,
        height: 30.0 * SizeConfig.heightMultiplier,
        child: Icon(
          FontAwesomeIcons.check,
          size: 100,
          color: Color.fromRGBO(84, 202, 114, 1),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 10.0 * SizeConfig.heightMultiplier),
      CustomText(
        text: "Delivery Completed",
        weight: FontWeight.bold,
        size: 3.5 * SizeConfig.textMultiplier,
      ),
      SizedBox(
        height: 60,
      ),
      Container(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Return To Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 3.0 * SizeConfig.textMultiplier,
                  ),
                ),
                SizedBox(
                  width: 1.0 * SizeConfig.widthMultiplier,
                ),
              ],
            ),
            color: Color(0xFFFF3799),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0 * SizeConfig.widthMultiplier),
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ),
    ],
  );
}
