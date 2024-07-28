class Demand {
  final String apsiyonPointId;
  final String apartmentNumber;
  final String status;
  final String apartment_name;

  Demand({
    required this.apsiyonPointId,
    required this.apartmentNumber,
    required this.status,
    required this.apartment_name,
  });

  factory Demand.fromJson(Map<String, dynamic> json) {
    return Demand(
      apsiyonPointId: json['apsiyon_id'] as String,
      apartmentNumber: json['apartment_number'] as String,
      status: json['status'] as String,
      apartment_name: json['apartment_name'] as String,
    );
  }
}
