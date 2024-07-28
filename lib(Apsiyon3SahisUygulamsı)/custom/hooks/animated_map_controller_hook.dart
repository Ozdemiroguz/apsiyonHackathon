import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

import 'use_ticker_provider_hook.dart';

AnimatedMapController useAnimatedMapController() {
  final vsync = useTickerProvider();

  return use(_AnimatedMapControllerHook(vsync: vsync));
}

class _AnimatedMapControllerHook extends Hook<AnimatedMapController> {
  final TickerProvider vsync;

  const _AnimatedMapControllerHook({required this.vsync});

  @override
  _AnimatedMapControllerHookState createState() =>
      _AnimatedMapControllerHookState();
}

class _AnimatedMapControllerHookState
    extends HookState<AnimatedMapController, _AnimatedMapControllerHook> {
  late final AnimatedMapController controller;

  @override
  void initHook() {
    super.initHook();
    controller = AnimatedMapController(vsync: hook.vsync);
  }

  @override
  AnimatedMapController build(BuildContext context) => controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
