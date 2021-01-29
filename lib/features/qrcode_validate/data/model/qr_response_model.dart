class QRResponce {
  String qrcode;
  String transactionId;

  QRResponce({this.qrcode, this.transactionId});

  QRResponce.fromJson(Map<String, dynamic> json) {
    qrcode = json['qrcode'];
    transactionId = json['transaction_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['qrcode'] = this.qrcode;
    data['transaction_id'] = this.transactionId;
    return data;
  }
}

class QRResponceList {
  final List<QRResponce> qrResponceList;

  QRResponceList({
    this.qrResponceList,
  });

  factory QRResponceList.fromJson(List<dynamic> parsedJson) {
    List<QRResponce> qrResponceList = List<QRResponce>();
    qrResponceList = parsedJson.map((i) => QRResponce.fromJson(i)).toList();

    return QRResponceList(qrResponceList: qrResponceList);
  }
}
