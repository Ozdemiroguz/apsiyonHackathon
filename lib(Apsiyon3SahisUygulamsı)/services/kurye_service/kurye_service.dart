import '../../core/models/kurye/kurye.dart';
import '../../core/models/order/order_data.dart';

abstract interface class KuryeService {
  Future<bool> isSignIn();
  Stream<Kurye> getKuryeInfo();
  Stream<List<OrderData>> getOrders(String kuryeId);
}
