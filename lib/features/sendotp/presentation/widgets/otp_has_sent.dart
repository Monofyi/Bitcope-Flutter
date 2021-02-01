// import 'package:flutter/material.dart';
// import 'package:bitcope/features/sendotp/presentation/widgets/otpnumber.dart';
// import 'package:bitcope/features/sendotp/presentation/widgets/mycolors.dart';
// import 'package:numeric_keyboard/numeric_keyboard.dart';

// Widget otpHasSent() {
//   return SafeArea(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Text(
//                             'Enter 6 digits verification code sent to your number',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w500))),
//                     Container(
//                       constraints: const BoxConstraints(maxWidth: 500),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           otpNumberWidget(0),
//                           otpNumberWidget(1),
//                           otpNumberWidget(2),
//                           otpNumberWidget(3),
//                           otpNumberWidget(4),
//                           otpNumberWidget(5),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 constraints: const BoxConstraints(maxWidth: 500),
//                 child: RaisedButton(
//                   onPressed: () {},
//                   color: MyColors.primaryColor,
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(14))),
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(
//                           'Confirm',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(20)),
//                             color: MyColors.primaryColorLight,
//                           ),
//                           child: Icon(
//                             Icons.arrow_forward_ios,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               NumericKeyboard(
//                 //onKeyboardTap: _onKeyboardTap,
//                 textColor: MyColors.primaryColorLight,
//                 rightIcon: Icon(
//                   Icons.backspace,
//                   color: MyColors.primaryColorLight,
//                 ),
//                 rightButtonFn: () {},
//               )
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }
