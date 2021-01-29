class OTPModel {
  int phoneno;
  String transactionid;

  OTPModel({
    this.phoneno,
    this.transactionid,
  });

  Map<String, dynamic> toJson() => {
        "phone_number": this.phoneno,
        "transaction_id": this.transactionid,
      };
}
