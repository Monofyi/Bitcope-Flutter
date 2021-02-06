class OTPModel {
  int phoneno;
  String transactionid;
  String retailerName;

  OTPModel({
    this.phoneno,
    this.transactionid,
    this.retailerName,
  });

  Map<String, dynamic> toJson() => {
        "phone_number": this.phoneno,
        "transaction_id": this.transactionid,
        "retailer_name": this.retailerName
      };
}
