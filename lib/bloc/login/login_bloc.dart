import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tcm/bloc/login/login_event.dart';
import 'package:projet_tcm/bloc/login/login_state.dart';
import 'package:projet_tcm/services/auth_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc(this.authService) : super(LoginState(loggedIn: false)) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginState.loading()); // État de chargement

      try {
        final statusCode = await authService.login(
          event.username,
          event.password,
        );

        if (statusCode == 200) {
          emit(LoginState.success()); // État de succès
        } else {
          emit(LoginState.failure('Erreur lors de la connexion : $statusCode')); // État d'échec
        }
      } catch (e) {
        emit(LoginState.failure('Erreur réseau : $e')); // État d'échec avec message d'erreur
      }
    });
  }
}