class ApsiyonPoint {
  final String id;
  final String city;
  final String address;
  final String apartment_name;
  final List<String?> apartment_numbers;

  ApsiyonPoint({
    required this.id,
    required this.city,
    required this.address,
    required this.apartment_name,
    required this.apartment_numbers,
  });

  factory ApsiyonPoint.fromJson(Map<String, dynamic> json, String id) {
    return ApsiyonPoint(
      id: id,
      city: json['city'] as String,
      address: json['address'] as String,
      apartment_name: json['apartment_name'] as String,
      apartment_numbers: List<String?>.from(json['apartment_numbers'] as List),
    );
  }
}
