import 'package:flutter/material.dart';

Widget customTextFields(
    {BuildContext context,
    String name,
    IconData iconData,
    Color color,
    String initialValue,
    Function validator,
    Function onSaved,
    TextInputType keyboardType,
    TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    onChanged: onSaved,
    //cursorColor: Theme.of(context).cursorColor,
    initialValue: initialValue, style: TextStyle(color: Colors.white60),
    //maxLength: 20,
    decoration: InputDecoration(
      //icon: Icon(Icons.favorite),
      labelText: name,
      labelStyle: TextStyle(
        fontSize: 15,
        color: Colors.white30,
      ),
      // helperText: 'Helper text',
      suffixIcon: Icon(
        iconData,
        size: 20,
        color: Colors.white24,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
    ),
  );
  //Center(
  //   child: Row(
  //     children: [
  //       SizedBox(
  //         width: 270,
  //         child: Padding(
  //           padding: const EdgeInsets.only(left: 8.0),
  //           child: TextFormField(
  //             initialValue: '',
  //             decoration: InputDecoration(
  //               labelText: 'Label text',
  //               errorText: '',
  //               border: InputBorder.none,
  //               // suffixIcon: Icon(
  //               //   Icons.error,
  //               // ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Icon(iconData),
  //       SizedBox(width: 10)
  //     ],
  //   ),
  // );

  // Container(
  //   height: 40,
  //   decoration: BoxDecoration(
  //     color: Colors.transparent,
  //     borderRadius: BorderRadius.only(
  //       bottomLeft: Radius.circular(5),
  //       bottomRight: Radius.circular(5),
  //       topLeft: Radius.circular(5),
  //       topRight: Radius.circular(5),
  //     ),
  //   ),
  //   child: Center(
  //     child: Row(
  //       children: [
  //         SizedBox(
  //           width: 270,
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 8.0),
  //             child: TextField(
  //               decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 hintText: name,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Icon(iconData),
  //         SizedBox(width: 10)
  //       ],
  //     ),
  //   ),
  // );
}
