part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class PasswordVisibilityState extends AuthState {
  final bool isVisible;

  const PasswordVisibilityState({required this.isVisible});

  @override
  List<Object> get props => [isVisible];
}
