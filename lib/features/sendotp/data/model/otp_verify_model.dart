class OTPVerifyModel {
  String otp;
  String transactionid;

  OTPVerifyModel({
    this.otp,
    this.transactionid,
  });

  Map<String, dynamic> toJson() => {
        "otp_input": this.otp,
        "session_id": this.transactionid,
      };
}
