import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Creates a full-fledged [TickerProvider].
///
/// See also:
///  * [TickerProviderStateMixin]
TickerProvider useTickerProvider({List<Object?>? keys}) {
  return use(
    keys != null ? _TickerProviderHook(keys) : const _TickerProviderHook(),
  );
}

class _TickerProviderHook extends Hook<TickerProvider> {
  const _TickerProviderHook([List<Object?>? keys]) : super(keys: keys);

  @override
  _TickerProviderHookState createState() => _TickerProviderHookState();
}

class _TickerProviderHookState
    extends HookState<TickerProvider, _TickerProviderHook>
    implements TickerProvider {
  Set<Ticker>? _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <_HookTicker>{};
    final _HookTicker result =
        _HookTicker(onTick, this, debugLabel: 'created by $this');
    _tickers!.add(result);
    return result;
  }

  void _removeTicker(_HookTicker ticker) {
    assert(_tickers != null);
    assert(_tickers!.contains(ticker));
    _tickers!.remove(ticker);
  }

  @override
  void dispose() {
    assert(() {
      if (_tickers != null) {
        for (final Ticker ticker in _tickers!) {
          if (ticker.isActive) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('$this was disposed with an active Ticker.'),
              ErrorDescription(
                  '$runtimeType created a Ticker via its useTickerProvider, but at the time '
                  'dispose() was called on the mixin, that Ticker was still active. All Tickers must '
                  'be disposed before calling super.dispose().'),
              ErrorHint('Tickers used by AnimationControllers '
                  'should be disposed by calling dispose() on the AnimationController itself. '
                  'Otherwise, the ticker will leak.'),
              ticker.describeForError('The offending ticker was'),
            ]);
          }
        }
      }
      return true;
    }());
    super.dispose();
  }

  @override
  TickerProvider build(BuildContext context) {
    if (_tickers != null) {
      for (final Ticker ticker in _tickers!) {
        ticker.muted = !TickerMode.of(context);
      }
    }
    return this;
  }

  @override
  String get debugLabel => 'useTickerProvider';

  @override
  bool get debugSkipValue => true;
}

class _HookTicker extends Ticker {
  _HookTicker(super.onTick, this._creator, {super.debugLabel});

  final _TickerProviderHookState _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
