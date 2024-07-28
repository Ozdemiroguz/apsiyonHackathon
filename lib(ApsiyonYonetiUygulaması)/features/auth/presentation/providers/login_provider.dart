//Login state ile Login provider

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/injections/locator.dart';
import '../../../../utils/validators.dart';
import '../states/login/login_state.dart';

final loginProvider = NotifierProvider.autoDispose<_LoginNotifier, LoginState>(
  _LoginNotifier.new,
);

class _LoginNotifier extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    Future(() => init());
    return LoginState.initial();
  }

  Future<void> init() async {
    state = state.copyWith(
      isLoading: false,
      emailFailure: validateEmailAddress(state.email),
      passwordFailure: validatePassword(state.password),
    );
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true);
    final result = await ref.read(authRepositoryProvider).login(
          username: state.email,
          password: state.password,
        );
    print(result);

    state = state.copyWith(failure: result, isLoading: false);
  }

  void onChangedEmail(String? email) {
    state = state.copyWith(
      email: email!,
      emailFailure: validateEmailAddress(email),
    );
  }

  void onChangedPassword(String? password) {
    state = state.copyWith(
      password: password!,
      passwordFailure: validatePassword(password),
    );
  }
}
