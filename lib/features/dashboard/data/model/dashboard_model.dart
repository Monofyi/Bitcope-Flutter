class Dashboard {
  int transactionId;
  String crateId;
  String location;
  String deliveryStatus;
  String deliveryAgent;
  String timestamp;
  String retailerName;

  Dashboard(
      {this.transactionId,
      this.crateId,
      this.location,
      this.deliveryStatus,
      this.deliveryAgent,
      this.timestamp,
      this.retailerName});

  Dashboard.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    crateId = json['crate_id'];
    location = json['location'];
    deliveryStatus = json['deliveryStatus'];
    deliveryAgent = json['deliveryAgent'];
    timestamp = json['timestamp'];
    retailerName = json['retailer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['crate_id'] = this.crateId;
    data['location'] = this.location;
    data['deliveryStatus'] = this.deliveryStatus;
    data['deliveryAgent'] = this.deliveryAgent;
    data['timestamp'] = this.timestamp;
    data['retailer_name'] = this.retailerName;
    return data;
  }
}

class DashboardList {
  final List<Dashboard> dashboardList;

  DashboardList({
    this.dashboardList,
  });

  factory DashboardList.fromJson(List<dynamic> parsedJson) {
    List<Dashboard> dashboardList = List<Dashboard>();
    dashboardList = parsedJson.map((i) => Dashboard.fromJson(i)).toList();

    return DashboardList(dashboardList: dashboardList);
  }
}
