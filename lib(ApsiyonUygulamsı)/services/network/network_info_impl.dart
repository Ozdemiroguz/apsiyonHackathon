import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:injectable/injectable.dart';

import '../../constants/durations.dart';
import 'network_info.dart';

@LazySingleton(as: NetworkInfo)
final class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected =>
      connectivity.checkConnection().timeout(timeoutDuration);
}
