import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/password_visibility/password_visibility.event.dart';
import 'package:klontong/bloc/password_visibility/password_visibility.state.dart';

class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc()
      : super(const PasswordVisibilityState(isObscure: true)) {
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<PasswordVisibilityState> emit) {
    emit(PasswordVisibilityState(isObscure: !state.isObscure));
  }
}
