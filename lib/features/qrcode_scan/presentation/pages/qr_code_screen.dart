import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/qrcode_scan/data/repository/qrcode_repository.dart';
import 'package:bitcope/features/qrcode_scan/presentation/bloc/qrcode_bloc.dart';
import 'package:bitcope/features/qrcode_validate/presentation/pages/qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> qrCodeList;

class QrCodeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final qrRepository = QrRepository();

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
              return QrcodeBloc(qrRepository: qrRepository)
                ..add(QRScanButtonPressed());
            },
          ),
        ],
        child: BlocListener<QrcodeBloc, QrcodeState>(
          listener: (BuildContext context, state) {
            if (state is QRIsInvalid) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 1200),
                  content: Text('Invalid'),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is QRIsDuplicate) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 1200),
                  content: Text('Already Scanned'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<QrcodeBloc, QrcodeState>(
            builder: (context, state) {
              // if (state is QrcodeInitial) {
              //   return Container(
              //     color: Colors.grey[200],
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Center(
              //           child: Text(
              //             "Please Press Scan Button to Scan the Crate",
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //         Container(
              //           height: 80,
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: RaisedButton(
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'SCAN CRATES',
              //                     style: TextStyle(
              //                         color: Colors.white, fontSize: 20),
              //                   ),
              //                 ],
              //               ),
              //               color: Color(0xFFFF3799),
              //               // shape: RoundedRectangleBorder(
              //               //     borderRadius: BorderRadius.all(Radius.circular(
              //               //         10.0 * SizeConfig.widthMultiplier))),
              //               onPressed: () {
              //                 BlocProvider.of<QrcodeBloc>(context)
              //                     .add(QRScanButtonPressed());
              //               },
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   );
              // }
              if (state is QrcodeAdded) {
                qrCodeList = state.qrListForPL;
                print(state.qrListForPL.length.toString());

                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: null,
                        title: qrCodeList.length == 0
                            ? Text(
                                'Nothing in Scanned Crates! Please Press Scan button to start scan!',
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                'Scanned Crates',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          // shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          itemCount: qrCodeList.length,
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
                                            qrCodeList[index],
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
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'SCAN CRATES',
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
                                  BlocProvider.of<QrcodeBloc>(context)
                                      .add(QRScanButtonPressed());
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'VALIDATE',
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
                                  if (qrRepository.qrCodeList.length > 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QrValidationScreen(
                                                  qrRepository: qrRepository,
                                                )));
                                  } else {
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        duration: Duration(milliseconds: 1200),
                                        content: Text(
                                            'Please Add Atleast one QrCode to Proceed further'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
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
