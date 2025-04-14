class LoginState {
  final bool loggedIn;
  final bool isLoading;
  final String? errorMessage;

  LoginState({required this.loggedIn, this.isLoading = false, this.errorMessage});

  factory LoginState.loading() => LoginState(loggedIn: false, isLoading: true);
  factory LoginState.success() => LoginState(loggedIn: true);
  factory LoginState.failure(String errorMessage) =>
      LoginState(loggedIn: false, errorMessage: errorMessage);
}