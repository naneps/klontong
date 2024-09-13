import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Import Firebase Crashlytics
import 'package:klontong/bloc/auth/login.event.dart';
import 'package:klontong/bloc/auth/login.state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatus event, Emitter<LoginState> emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isLoggedIn = prefs.getBool('isLoggedIn');

      if (isLoggedIn != null && isLoggedIn) {
        emit(LoginSuccess());
      } else {
        emit(LoginInitial());
      }
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance
          .recordError(e, stackTrace); // Log error to Crashlytics
      emit(LoginFailure(e.toString()));
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
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance
          .recordError(e, stackTrace); // Log error to Crashlytics
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<LoginState> emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      emit(LoginInitial());
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance
          .recordError(e, stackTrace); // Log error to Crashlytics
      emit(LoginFailure(e.toString()));
    }
  }
}
