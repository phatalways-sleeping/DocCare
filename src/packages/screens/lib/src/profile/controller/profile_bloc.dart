import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:models/models.dart';
import 'package:intl/intl.dart';

import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._notificationManagerService,
  ) : super(ProfileInitial.empty()) {
    on<FullNameInputEvent>(_onFullNameInputEvent);
    on<EmailInputEvent>(_onEmailInputEvent);
    on<BirthdayInputEvent>(_onBirthdayInputEvent);
    on<PhoneNumberInputEvent>(_onPhoneNumberInputEvent);
    on<SpecializationInputEvent>(_onSpecializationInputEvent);
    on<StartingYearInputEvent>(_onStartWorkingFromInputEvent);
    on<ValidateBirthdayInputEvent>(_onValidateBirthdayInputEvent);
    on<ChangePasswordButtonPressedEvent>(_onChangePasswordButtonPressedEvent);
  }

  final NotificationManagerService _notificationManagerService;

  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(tempBirthday: event.tempBirthday));
  }

  void _onPhoneNumberInputEvent(
    PhoneNumberInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onSpecializationInputEvent(
    SpecializationInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(specializationId: event.specializationId));
  }

  void _onStartWorkingFromInputEvent(
    StartingYearInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(startWorkingFrom: event.startWorkingFrom));
  }

  void _onValidateBirthdayInputEvent(
    ValidateBirthdayInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    print("Validate Birthday");
    print(event.birthday);
    final check = FormValidator.validateDate(event.birthday).isValid;
    if (!check) {
      _notificationManagerService
          .show<void>(
            NotificationType.dismissed,
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
            (value) => emit((state as ProfileLoading).toggleBackToInitial()),
          );
      return;
    }
    print("hshdsd");
    final formatter = DateFormat('dd/MM/yyyy');
    final birthday = formatter.parseStrict(
      event.birthday,
    );
    emit(state.copyWith(birthday: birthday));
  }

  void _onChangePasswordButtonPressedEvent(
    ChangePasswordButtonPressedEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith());
  }
}
