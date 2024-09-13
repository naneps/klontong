// login_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:klontong/bloc/auth/login.event.dart';
import 'package:klontong/bloc/auth/login.state.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event, Emitter<LoginState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    if (isLoggedIn != null && isLoggedIn) {
      emit(LoginSuccess());
    } else {
      emit(LoginInitial());
    }
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      // Hardcoded credentials
      if (event.username == 'admin' && event.password == 'password') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure('Invalid username or password'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<LoginState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    emit(LoginInitial());
  }
}

class MockSharedPreferences extends Mock implements SharedPreferences {}
