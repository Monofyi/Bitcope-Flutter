import 'package:bitcope/utils/sizeconfig.dart';
import 'package:flutter/material.dart';

Widget socialMediaButtons({IconData icon, Color color}) {
  return Container(
    height: 12.0 * SizeConfig.imageSizeMultiplier,
    width: 12.0 * SizeConfig.imageSizeMultiplier,
    child: Icon(
      icon,
      color: Colors.white,
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      // boxShadow: [
      //   BoxShadow(
      //       color: Colors.black54,
      //       offset: Offset(0, 2),
      //       blurRadius: 6.0)
      // ],
      // image: DecorationImage(
      //   image: logo,
    ),
  );
}
