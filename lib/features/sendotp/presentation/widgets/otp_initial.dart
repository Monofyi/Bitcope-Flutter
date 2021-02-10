import 'package:bitcope/core/utils/customtextfield.dart';
import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcope/features/sendotp/presentation/widgets/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget otpInitial(
    {@required BuildContext context,
    @required Function onPressed,
    @required TextEditingController phoneController,
    @required TextEditingController textController,
    Key formKey}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          constraints:
              BoxConstraints(maxWidth: 90.0 * SizeConfig.widthMultiplier),
          margin: EdgeInsets.symmetric(
              horizontal: 3.0 * SizeConfig.widthMultiplier),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'We will send you an ',
                  style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: 'One Time Password ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: 'on this mobile number',
                  style: TextStyle(color: Colors.white)),
            ]),
          )),
      Container(
        height: 250,
        constraints:
            BoxConstraints(maxWidth: 90.0 * SizeConfig.widthMultiplier),
        margin: EdgeInsets.symmetric(
            horizontal: 5.0 * SizeConfig.widthMultiplier,
            vertical: 2.5 * SizeConfig.heightMultiplier),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              customTextFields(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                context: context,
                color: Colors.white24,
                iconData: FontAwesomeIcons.phone,
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
              customTextFields(
                controller: textController,
                keyboardType: TextInputType.name,
                context: context,
                color: Colors.white24,
                iconData: FontAwesomeIcons.user,
                name: 'Retailer Name*',
                validator: (value) {
                  RegExp regExp = new RegExp(
                    r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
                  );
                  if (value.length == 0) {
                    return "Retailer Name is Required";
                  } else if (!regExp.hasMatch(value)) {
                    return "Retailer Name is invalid";
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
      Container(
        margin: EdgeInsets.symmetric(
            horizontal: 5.0 * SizeConfig.widthMultiplier,
            vertical: 2.5 * SizeConfig.heightMultiplier),
        constraints:
            BoxConstraints(maxWidth: 90.0 * SizeConfig.widthMultiplier),
        child: RaisedButton(
          onPressed: onPressed,
          color: MyColors.primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: MyColors.primaryColorLight,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}
