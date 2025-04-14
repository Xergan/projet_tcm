part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed(this.username, this.password);
}