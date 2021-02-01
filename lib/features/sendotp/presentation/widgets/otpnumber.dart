import 'package:flutter/material.dart';

Widget otpNumberWidget(int position) {
  try {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Center(
          child: Text(
        position.toString(),
        style: TextStyle(color: Colors.black),
      )),
    );
  } catch (e) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
    );
  }
}
