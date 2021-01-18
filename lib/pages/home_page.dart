import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:translator/translator.dart';
import 'package:bitcope/pages/registrationpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final style = GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black54, fontSize:20.0,));

  @override
  Widget build(BuildContext context) {
    // final translator = GoogleTranslator();
    final myEmailController = TextEditingController();
    final myPasswordController = TextEditingController();
    final emailfield = TextField(
      controller: myEmailController,
      obscureText: false,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: Colors.black54,
          fontSize: 20.0,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27.0),
        ),
      ),
    );
    final password = TextField(
      controller: myPasswordController,
      obscureText: true,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: Colors.black54,
          fontSize: 20.0,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(27.0),
        ),
      ),
    );
    // final loginButton = Material(
    //   elevation: 5.0,
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Color(0xff01A0C7),
    //   child: MaterialButton(
    //     minWidth: MediaQuery.of(context).size.width,
    //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     onPressed: () {},
    //     child: Text(
    //       "Login",
    //       textAlign: TextAlign.center,
    //       style: GoogleFonts.montserrat(
    //           textStyle:
    //               TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    //     ),
    //   ),
    // );

    // @override
    // void dispose() {
    //   // Clean up the controller when the widget is removed from the
    //   // widget tree.
    //   myEmailController.dispose();
    //   myPasswordController.dispose();
    //   super.dispose();
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bitecope",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emailfield,
                SizedBox(
                  height: 20.0,
                ),
                password,
                RaisedButton(
                    child: Text('Click to login'),
                    padding: EdgeInsets.all(12.0),
                    onPressed: () {}),
                RaisedButton(
                    child: Text('Click to signup'),
                    padding: EdgeInsets.all(12.0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
