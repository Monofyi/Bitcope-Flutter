class ValidateCrate {
  // ignore: non_constant_identifier_names
  final String crate_id;
  final String location;
  final String deliveryAgent;

  // ignore: non_constant_identifier_names
  ValidateCrate({this.crate_id, this.location, this.deliveryAgent});

  Map<String, dynamic> toDatabaseJson() => {
        "crate_id": this.crate_id,
        "location": this.location,
        "deliveryAgent": this.deliveryAgent
      };
}
