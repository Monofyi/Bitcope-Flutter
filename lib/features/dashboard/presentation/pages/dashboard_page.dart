import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';
import 'package:bitcope/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:bitcope/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:bitcope/features/qrcode_scan/data/repository/qrcode_repository.dart';
import 'package:bitcope/features/qrcode_scan/presentation/bloc/qrcode_bloc.dart';
import 'package:bitcope/features/qrcode_scan/presentation/pages/qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

DashboardList dashboardList;

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //HDTRefreshController _hdtRefreshController = HDTRefreshController();
    final dashboardRepository = DashboardRepository();
    final qrRepository = QrRepository();
    return Scaffold(
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
              return OTPBloc(
                dashboardRepository: dashboardRepository,
              )..add(DashboardFetched());
            },
          ),
          BlocProvider(
            create: (context) {
              return QrcodeBloc(qrRepository: qrRepository);
            },
          ),
        ],
        child: BlocBuilder<OTPBloc, OTPState>(
          builder: (context, state) {
            if (state is DashboardInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DashboardLoaded) {
              dashboardList = state.dashboardList;
              //print(state.dashboardList.dashboardList.length.toString());
              return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      onTap: null,
                      title: Text(
                        'Transaction History',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemCount: dashboardList.dashboardList.length,
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
                                                      DateFormat.MMM().format(
                                                          DateTime.parse(
                                                              dashboardList
                                                                  .dashboardList[
                                                                      index]
                                                                  .timestamp)),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      DateFormat.d().format(
                                                          DateTime.parse(
                                                              dashboardList
                                                                  .dashboardList[
                                                                      index]
                                                                  .timestamp)),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      DateFormat.y().format(
                                                          DateTime.parse(
                                                              dashboardList
                                                                  .dashboardList[
                                                                      index]
                                                                  .timestamp)),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            subtitle: Text(
                                              dashboardList.dashboardList[index]
                                                  .deliveryAgent,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            title: Text(
                                              dashboardList.dashboardList[index]
                                                  .deliveryStatus,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            trailing: Text(
                                              "Total Crates: " +
                                                  dashboardList
                                                      .dashboardList[index]
                                                      .crateId
                                                      .split(',')
                                                      .length
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          height: 80,
                                          width: 5,
                                          color: dashboardList
                                                      .dashboardList[index]
                                                      .deliveryStatus ==
                                                  "Delivered"
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  )),
                              Divider(
                                thickness: 0.0,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 80,
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
                            // BlocProvider.of<QrcodeBloc>(context)
                            //     .add(QRScanButtonPressed());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QrCodeScreen()));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
