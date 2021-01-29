class OTPResponseModel {
  String status;
  String details;

  OTPResponseModel({
    this.status,
    this.details,
  });
  OTPResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    details = json['Details'];
  }
}
