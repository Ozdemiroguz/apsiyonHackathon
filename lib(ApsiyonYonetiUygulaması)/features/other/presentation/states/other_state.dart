import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/models/failure/failure.dart';
import '../../domain/models/token.dart';

part 'other_state.freezed.dart';

@freezed
class OtherState with _$OtherState {
  factory OtherState({
    required bool isLoading,
    required List<Token> tokenListConfirmed,
    required List<Token> tokenListUnconfirmed,
    required List<Token> tokenListExpired,
    required String tokenDescription,
    required String? tokenOtherId,
    required String tokenTime,
    required Option<Failure> failure,
  }) = _OtherState;

  factory OtherState.initial() => OtherState(
        tokenListConfirmed: [],
        tokenListUnconfirmed: [],
        tokenListExpired: [],
        isLoading: false,
        tokenDescription: "",
        tokenOtherId: null,
        tokenTime: "",
        failure: none(),
      );

  const OtherState._();
}
