import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tcm/bloc/login/login_event.dart';
import 'package:projet_tcm/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(false)) {
    on<LoginButtonPressed>((event, emit) {
      emit(LoginState(true));
    });
  }
}
