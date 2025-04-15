part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

/// État initial (avant toute tentative de connexion)
final class LoginInitial extends LoginState {}

/// État de chargement (connexion en cours)
final class LoginLoading extends LoginState {}

/// État de succès (connexion réussie)
final class LoginSuccess extends LoginState {}

/// État d'échec (connexion échouée)
final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}