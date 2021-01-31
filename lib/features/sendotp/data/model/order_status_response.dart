class OrderResponseModel {
  String status;

  OrderResponseModel({
    this.status,
  });
  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}
