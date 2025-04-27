import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:projet_tcm/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc(this.authService) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading()); // État de chargement

      try {
        final response = await authService.login(event.username, event.password);

        if (response["statusCode"] == 200) {
          emit(LoginSuccess()); // État de succès
        } else {
          emit(LoginFailure(response['message'].toString())); // État d'échec
        }
      } catch (e) {
        emit(LoginFailure('Erreur réseau : $e')); // État d'échec avec message d'erreur
      }
    });
  }
}