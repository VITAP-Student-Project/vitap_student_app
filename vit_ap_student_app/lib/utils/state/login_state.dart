enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final LoginStatus status;
  final String? errorMessage;

  LoginState({this.status = LoginStatus.initial, this.errorMessage});

  LoginState copyWith({LoginStatus? status, String? errorMessage}) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
