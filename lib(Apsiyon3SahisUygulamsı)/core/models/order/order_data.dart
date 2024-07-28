class OrderData {
  String apsiyonId;
  String orderStatus;
  String userId;

  OrderData({
    required this.apsiyonId,
    required this.orderStatus,
    required this.userId,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      apsiyonId: json['apsiyonId'] as String,
      orderStatus: json['orderStatus'] as String,
      userId: json['userId'] as String,
    );
  }

  factory OrderData.initial() {
    return OrderData(
      apsiyonId: '',
      orderStatus: '',
      userId: '',
    );
  }
}
