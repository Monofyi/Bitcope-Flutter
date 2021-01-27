import 'package:bitcope/core/database/user_database_operations.dart';
import 'package:bitcope/core/utils/sizeconfig.dart';
import 'package:bitcope/features/authentication/authentication_bloc.dart';
import 'package:bitcope/features/dashboard/data/model/dashboard_model.dart';
import 'package:bitcope/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:bitcope/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';

DashboardList dashboardList;

class Dashboard extends StatelessWidget {
  // final UserDatabaseOps userDatabaseOps = UserDatabaseOps();
  // Future<String> getToken() async {
  //   return await userDatabaseOps.getUserToken(0);
  // }

  @override
  Widget build(BuildContext context) {
    //HDTRefreshController _hdtRefreshController = HDTRefreshController();
    final dashboardRepository = DashboardRepository();
    DateFormat format = new DateFormat("MMMM");
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
      body: BlocProvider(
        create: (context) =>
            DashboardBloc(dashboardRepository: dashboardRepository)
              ..add(DashboardFetched()),
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DashboardLoaded) {
              dashboardList = state.dashboardList;
              print(state.dashboardList.dashboardList.length.toString());
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
                                  )
                                  // Row(
                                  //   //mainAxisSize: MainAxisSize.max,
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Container(
                                  //       height: 60,
                                  //       width: 10,
                                  //       color: Colors.redAccent,
                                  //       // child: Text(
                                  //       //   dashboardList
                                  //       //       .dashboardList[index].transactionId
                                  //       //       .toString(),
                                  //       //   style: TextStyle(color: Colors.black),
                                  //       // ),
                                  //     ),
                                  //     Container(
                                  //       height: 60,
                                  //       width: MediaQuery.of(context).size.width -
                                  //           16 -
                                  //           10,
                                  //       color: Colors.grey[200],
                                  //       child: ListTile(
                                  //         leading: Text(
                                  //           dashboardList.dashboardList[index]
                                  //               .transactionId
                                  //               .toString(),
                                  //           style: TextStyle(color: Colors.black),
                                  //         ),
                                  //         title: Text(
                                  //           dashboardList
                                  //               .dashboardList[index].crateId
                                  //               .split(',')
                                  //               .length
                                  //               .toString(),
                                  //           style: TextStyle(color: Colors.black),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  ),
                              Divider(
                                thickness: 0.0,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );

              // return Padding(
              //   padding: const EdgeInsets.all(2.0),
              //   child: Container(
              //     //height: 220,
              //     child: Column(
              //       children: [
              //         HorizontalDataTable(
              //           htdRefreshController: _hdtRefreshController,
              //           isFixedHeader: true,
              //           leftHandSideColumnWidth: 50,
              //           rightHandSideColumnWidth: 500,
              //           itemCount: dashboardList.dashboardList.length,
              //           headerWidgets: _getTitleWidget(),
              //           leftSideItemBuilder: _generateFirstColumnRow,
              //           rightSideItemBuilder: _generateRightHandSideColumnRow,
              //           rowSeparatorWidget: const Divider(
              //             color: Colors.black54,
              //             height: 1.0,
              //             thickness: 0.0,
              //           ),
              //           elevation: 0.0,
              //           leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
              //           rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
              //           enablePullToRefresh: false,
              //           refreshIndicator: const WaterDropHeader(),
              //           refreshIndicatorHeight: 60,
              //           onRefresh: () {
              //             _hdtRefreshController.refreshCompleted();
              //           },
              //         ),
              //         // StickyHeadersTable(
              //         //   columnsLength: 6,
              //         //   rowsLength: dashboardList.dashboardList.length,
              //         //   columnsTitleBuilder: (i) {
              //         //     return Text(state.columnList[i]);
              //         //   },
              //         //   rowsTitleBuilder: (i) {
              //         //     return Text(dashboardList
              //         //         .dashboardList[i].transactionId
              //         //         .toString());
              //         //   },
              //         //   contentCellBuilder: (i, j){
              //         //     return Text
              //         //   }
              //         //   legendCell: TableCell.legend(
              //         //     'Sticky Legend',
              //         //     textStyle: textTheme.button.copyWith(fontSize: 16.5),
              //         //   ),
              //         // ),
              //       ],
              //     ),
              //   ),
              // );
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Trans Id', 50),
      _getTitleItemWidget('CrateId', 100),
      _getTitleItemWidget('Location', 100),
      _getTitleItemWidget('DeliveryAgent', 100),
      _getTitleItemWidget('DeliveryStatus', 100),
      _getTitleItemWidget('Date', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: label == 'Trans Id'
              ? BorderSide(
                  color: Colors.green, width: 2.0, style: BorderStyle.solid)
              : BorderSide(
                  color: Colors.green, width: 0.0, style: BorderStyle.solid),
          right: BorderSide(
              color: Colors.green, width: 2.0, style: BorderStyle.solid),
          bottom: BorderSide(
              color: Colors.green, width: 2.0, style: BorderStyle.solid),
          top: BorderSide(
              color: Colors.green, width: 2.0, style: BorderStyle.solid),
        ),
      ),
      child: Text(label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     left: BorderSide(
      //         color: Colors.green, width: 2.0, style: BorderStyle.solid),
      //     right: BorderSide(
      //         color: Colors.green, width: 2.0, style: BorderStyle.solid),
      //     bottom: BorderSide(
      //         color: Colors.green, width: 2.0, style: BorderStyle.solid),
      //     top: BorderSide(
      //         color: Colors.green, width: 2.0, style: BorderStyle.solid),
      //   ),
      // ),
      child: Center(
        child: Text(
          dashboardList.dashboardList[index].transactionId.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      width: 70,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                dashboardList.dashboardList[index].crateId,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            dashboardList.dashboardList[index].location,
            style: TextStyle(color: Colors.black),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            dashboardList.dashboardList[index].deliveryAgent,
            style: TextStyle(color: Colors.black),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            dashboardList.dashboardList[index].deliveryStatus,
            style: TextStyle(color: Colors.black),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            dashboardList.dashboardList[index].timestamp.substring(0, 10),
            style: TextStyle(color: Colors.black),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
