import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit/services/auth_service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  bool _isPasswordVisible = false;
  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<CreateAccountEvent>(_onCreateAccount);
    on<ResetPasswordEvent>(_onResetPassword);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.signIn(email: event.email, password: event.password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? 'Login failed'));
    } catch (e) {
      emit(const AuthFailure(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onCreateAccount(
    CreateAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authService.createAccount(
        email: event.email,
        password: event.password,
        displayName: event.displayName,
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? 'Account creation failed'));
    } catch (e) {
      emit(const AuthFailure(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authService.resetPassword(email: event.email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message ?? 'Password reset failed'));
    } catch (e) {
      emit(const AuthFailure(message: 'An unexpected error occurred'));
    }
  }

  Future<void> _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) async {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityState(isVisible: _isPasswordVisible));
  }
}
