// ignore_for_file: public_member_api_docs

import 'package:auth_api/auth_api.dart' show AuthException;
import 'package:auth_domain/auth_domain.dart'
    show AuthenticationRepositoryService;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:models/models.dart' show SignUpUser;

import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(
    this._authenticationRepositoryService,
    this._notificationManagerService,
  ) : super(SignUpInitial.empty()) {
    on<FullNameInputEvent>(_onFullNameInputEvent);
    on<EmailInputEvent>(_onEmailInputEvent);
    on<PasswordInputEvent>(_onPasswordInputEvent);
    on<BirthdayInputEvent>(_onBirthdayInputEvent);
    on<PhoneInputEvent>(_onPhoneInputEvent);
    on<ConfirmPasswordInputEvent>(_onConfirmPasswordInputEvent);
    on<TermsAndConditionsCheckboxChangedEvent>(
      _onTermsAndConditionsCheckboxChangedEvent,
    );
    on<SignUpButtonPressedEvent>(_onSignUpButtonPressedEvent);
    on<ValidateBirthdayInputEvent>(_validateBirthdayInputEvent);
  }

  final AuthenticationRepositoryService _authenticationRepositoryService;

  final NotificationManagerService _notificationManagerService;

  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordInputEvent(
    PasswordInputEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(tempBirthday: event.tempBirthday));
  }

  void _validateBirthdayInputEvent(
    ValidateBirthdayInputEvent event,
    Emitter<SignUpState> emit,
  ) {
    final check = FormValidator.validateDate(event.tempBirthday).isValid;
    if (!check) {
      _notificationManagerService
          .show<void>(
            NotificationType.signUp,
            title: const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            message: const Text(
              'Please enter a valid date with valid format (dd/mm/yyyy)',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          )
          .then(
            (value) => emit((state as SignUpLoading).toggleBackToInitial()),
          );
      return;
    }
    final formatter = DateFormat('dd/MM/yyyy');
    final birthday = formatter.parseStrict(
      event.tempBirthday,
    );
    emit(state.copyWith(birthday: birthday));
  }

  void _onPhoneInputEvent(
    PhoneInputEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onConfirmPasswordInputEvent(
    ConfirmPasswordInputEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  void _onTermsAndConditionsCheckboxChangedEvent(
    TermsAndConditionsCheckboxChangedEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(checkedTerm: event.checkedTerm));
  }

  Future<void> _onSignUpButtonPressedEvent(
    SignUpButtonPressedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    if (state.fullName.isEmpty ||
        state.password.isEmpty ||
        state.email.isEmpty ||
        state.phone.isEmpty ||
        state.confirmPassword.isEmpty ||
        state.checkedTerm == false) {
      await _notificationManagerService.show<void>(
        NotificationType.signUp,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Please fill all the fields',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );

      return;
    }

    if (state.password != state.confirmPassword) {
      await _notificationManagerService.show<void>(
        NotificationType.signUp,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Password and confirm password does not match',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      );

      return;
    }

    try {
      emit(SignUpLoading.from(state));
      await _authenticationRepositoryService
          .signUp(
            SignUpUser(
              state.email,
              state.password,
              state.birthday,
              state.fullName,
              state.phone,
            ),
          )
          .then((value) => emit(SignUpSuccess.from(state)));
    } on AuthException catch (e) {
      assert(state is SignUpLoading, 'State is not loading');

      await _notificationManagerService
          .show<void>(
            NotificationType.signUp,
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
          .then(
            (value) => emit((state as SignUpLoading).toggleBackToInitial()),
          );
    }
  }
}
