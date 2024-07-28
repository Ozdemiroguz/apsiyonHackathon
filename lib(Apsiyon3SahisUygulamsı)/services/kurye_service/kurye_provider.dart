import 'dart:async';

import 'package:apsiyon3/core/models/kurye/kurye.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/injections/locator.dart';

final kuryeProvider =
    NotifierProvider.autoDispose<_UserNotifier, Kurye>(_UserNotifier.new);

final class _UserNotifier extends AutoDisposeNotifier<Kurye> {
  StreamSubscription<Kurye>? _subscription;

  @override
  Kurye build() {
    Future(() => init());
    return Kurye.initial();
  }

  Future<void> init() async {
    _subscription =
        ref.read(kuryeServiceProvider).getKuryeInfo().listen((event) async {
      print("Kurye Info: $event");
      state = event;
    });
  }

  void signout() {
    _subscription?.cancel();
  }

  void dispose() {
    _subscription?.cancel();
    dispose();
  }
}
