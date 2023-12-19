import 'package:auth_api/auth_api.dart' show AuthException;
import 'package:auth_domain/auth_domain.dart'
    show AuthenticationRepositoryService;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:utility/utility.dart'
    show NotificationManagerService, NotificationType;

part 'login_event.dart';
part 'login_state.dart';

/// [LoginBloc] is a [Bloc] that handles the login process.
/// It is used in the dc_login_modal_bottom_sheet.dart file.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// [LoginBloc] constructor. It sets the initial state to [LoginInitial].
  /// It requires [AuthenticationRepositoryService]
  /// and [NotificationManagerService] instances.
  LoginBloc(
    this._authenticationRepositoryService,
    this._notificationManagerService,
  ) : super(const LoginInitial.empty()) {
    on<EmailInputEvent>(_onEmailInputEvent);
    on<PasswordInputEvent>(_onPasswordInputEvent);
    on<LoginButtonPressedEvent>(_onLoginButtonPressedEvent);
    on<GoogleLoginButtonPressedEvent>(_onGoogleLoginButtonPressedEvent);
  }

  final AuthenticationRepositoryService _authenticationRepositoryService;
  final NotificationManagerService _notificationManagerService;

  /// [_onEmailInputEvent] is a method that handles the [EmailInputEvent].
  /// It sets the email of the [LoginState] to the input email
  /// in [EmailInputEvent].
  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordInputEvent(
    PasswordInputEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginButtonPressedEvent(
    LoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    // Emit loading state, we will show loading indicator
    // in the login button
    emit(LoginLoading.from(state));

    // Login by email and password
    // If login failed, show notification
    // If login success, emit success state
    try {
      await _authenticationRepositoryService
          .login(
            state.email, state.password,
          )
          .then((value) => emit(LoginSuccess.from(state)));
    } on AuthException catch (e) {
      assert(state is LoginLoading, 'State is not loading');
      await _notificationManagerService
          .show<void>(
            NotificationType.login,
            title: const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            message: Text(
              e.message,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          )
          .then((value) => emit((state as LoginLoading).toggleBackToInitial()));
    }
  }

  // TODO: Implement Google login functionality
  void _onGoogleLoginButtonPressedEvent(
    GoogleLoginButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) {
    // Emit loading state
    emit(LoginLoading.from(state));

    // Login with Google
    try {
      // await _authenticationRepositoryService.loginWithGoogle();
    } on AuthException catch (_) {
      // await _notificationManagerService.show<void>();
    }
  }
}
