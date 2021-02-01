import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/qrcode_scan/data/repository/qrcode_repository.dart';
import 'package:bitcope/features/qrcode_validate/data/repository/qrcode_repository.dart';
import 'package:bitcope/features/qrcode_validate/presentation/bloc/qrcode_validate_bloc.dart';
import 'package:bitcope/features/sendotp/presentation/pages/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QrValidationScreen extends StatelessWidget {
  final QrRepository qrRepository;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  QrValidationScreen({Key key, @required this.qrRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final qrValidationRepository = QrValidationRepository();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bitecope'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
            child: Icon(
              FontAwesomeIcons.signOutAlt,
            ),
          ),
          SizedBox(
            width: 6.0 * SizeConfig.widthMultiplier,
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return QrcodeValidateBloc(
                  qrValidationRepository: qrValidationRepository,
                  qrRepository: qrRepository)
                ..add(QRValidateButtonPressed());
            },
          ),
        ],
        child: BlocListener<QrcodeValidateBloc, QrcodeValidateState>(
          listener: (BuildContext context, state) {},
          child: BlocBuilder<QrcodeValidateBloc, QrcodeValidateState>(
            builder: (context, state) {
              if (state is QrcodeValidateInitial) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
              if (state is QrcodeValidated) {
                print(state.validQrCodes.length.toString());

                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: null,
                        title: Text(
                          'Valid Crates',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          // shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          itemCount: state.validQrCodes.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                  ),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                16 -
                                                10,
                                        color: Colors.grey[200],
                                        child: Center(
                                            child: ListTile(
                                          leading: Container(
                                            width: 60,
                                            height: 60,
                                            color: Colors.white,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            state.validQrCodes[index],
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          trailing: Checkbox(
                                              value: true,
                                              activeColor: Colors.green,
                                              onChanged: (bool newValue) {}),
                                        )),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          height: 80,
                                          width: 5,
                                          color: 1 == 1
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 0.0,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'DELIVER',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                color: Color(0xFFFF3799),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.all(Radius.circular(
                                //         10.0 * SizeConfig.widthMultiplier))),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => OTPPage(
                                        transactionId: state.transactionID,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
