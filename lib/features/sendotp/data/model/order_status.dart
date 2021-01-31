class OrderModel {
  String orderId;

  OrderModel({
    this.orderId,
  });

  Map<String, dynamic> toJson() => {
        "transaction_id": this.orderId,
      };
}
