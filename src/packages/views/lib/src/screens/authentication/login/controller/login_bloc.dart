import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
    this._navigatorKey,
    this._authenticationRepositoryService,
    this._customerRepositoryService,
    this._doctorRepositoryService,
    this._receptionistRepositoryService,
    this._notificationManagerService,
  ) : super(const LoginInitial.empty()) {
    on<EmailInputEvent>(_onEmailInputEvent);
    on<PasswordInputEvent>(_onPasswordInputEvent);
    on<LoginButtonPressedEvent>(_onLoginButtonPressedEvent);
    on<GoogleLoginButtonPressedEvent>(_onGoogleLoginButtonPressedEvent);
  }

  final AuthenticationRepositoryService _authenticationRepositoryService;
  final CustomerRepositoryService _customerRepositoryService;
  final DoctorRepositoryService _doctorRepositoryService;
  final ReceptionistRepositoryService _receptionistRepositoryService;
  final NotificationManagerService _notificationManagerService;
  final GlobalKey<NavigatorState> _navigatorKey;

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
        state.email,
        state.password,
      )
          .then(
        (value) {
          if (value[0] == 'customer') {
            _customerRepositoryService.initializeCustomerId(value[1]);
          } else if (value[0] == 'doctor') {
            _doctorRepositoryService.initializeDoctorId(value[1]);
          } else if (value[0] == 'receptionist') {
            _receptionistRepositoryService.initializeReceptionistId(value[1]);
          } else if (value[0] == 'admin') {}
          _authenticationRepositoryService.setRole(value[0]);
          emit(
            LoginSuccess.from(
              state,
              value[0],
            ),
          );
        },
      );
    } on TimeoutException catch (_) {
      assert(state is LoginLoading, 'State is not loading');
      unawaited(
        _showNotification(
          'Something went wrong',
          'Operation timed out. Please try again later',
        ),
      );
      emit((state as LoginLoading).toggleBackToInitial());
    } on AuthException catch (e) {
      assert(state is LoginLoading, 'State is not loading');
      unawaited(
        _showNotification(
          'Something went wrong',
          e.message,
        ),
      );
      emit((state as LoginLoading).toggleBackToInitial());
    } catch (e) {
      assert(state is LoginLoading, 'State is not loading');
      unawaited(
        _showNotification(
          'Something went wrong',
          'Please try again later',
        ),
      );
      emit((state as LoginLoading).toggleBackToInitial());
    }
  }

  Future<void> _showNotification(
    String title,
    String message,
  ) async {
    unawaited(
      _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
        NotificationType.login,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        message: Text(
          message,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
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
