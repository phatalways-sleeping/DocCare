// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:models/models.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;

import 'package:auth_api/auth_api.dart' show AuthException;
import 'package:auth_domain/auth_domain.dart'
    show AuthenticationRepositoryService;

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(
    this._notificationManagerService,
    this._authenticationRepositoryService,
  ) : super(const ChangePasswordInitial.empty()) {
    on<EmailInputEvent>(_onEmailInputEvent);
    on<ValidateEmailEvent>(_onValidateEmailEvent);
    on<ChangePasswordButtonPressedEvent>(_onChangePasswordButtonPressedEvent);
  }

  final NotificationManagerService _notificationManagerService;
  final AuthenticationRepositoryService _authenticationRepositoryService;

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onValidateEmailEvent(
    ValidateEmailEvent event,
    Emitter<ChangePasswordState> emit,
  ) {
    if (event.email == '') {
      return;
    }
    final check = FormValidator.validateEmail(event.email);
    if (!check.isValid) {
      _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(fontSize: 16),
        ),
        message: const Text(
          'Please enter a valid email',
          style: TextStyle(fontSize: 14),
        ),
      );
      emit(ChangePasswordInitial.input(email: state.email));
      return;
    }
    emit(ChangePasswordValid.from(state));
  }

  Future<void> _onChangePasswordButtonPressedEvent(
    ChangePasswordButtonPressedEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading.from(state));
    try {
      await _authenticationRepositoryService.changePassword(
        ChangePasswordUser(
          state.email,
        ),
      );
      emit(ChangePasswordSuccess.from(state));
    } on AuthException catch (e) {
      assert(state is ChangePasswordLoading, 'State is not loading');

      await _notificationManagerService
          .show<void>(
            NotificationType.error,
            title: const Text(
              'Something went wrong',
              style: TextStyle(fontSize: 16),
            ),
            message: Text(
              e.message,
              style: const TextStyle(fontSize: 14),
            ),
          )
          .then(
            (value) => emit(
              ChangePasswordValid.from(state),
            ),
          );
    }
  }
}
