import 'package:equatable/equatable.dart';

class PasswordVisibilityState extends Equatable {
  final bool isObscure;

  const PasswordVisibilityState({required this.isObscure});

  @override
  List<Object> get props => [isObscure];
}
