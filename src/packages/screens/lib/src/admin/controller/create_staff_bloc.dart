// ignore_for_file: public_member_api_docs, inference_failure_on_function_invocation
import 'dart:async';

import 'package:administrator/administrator.dart';
import 'package:auth_api/auth_api.dart' show AuthException;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;

part 'create_staff_event.dart';
part 'create_staff_state.dart';

class CreateStaffBloc extends Bloc<CreateStaffEvent, CreateStaffState> {
  CreateStaffBloc(
    this._notificationManagerService,
    this._supabaseAdminService,
  ) : super(CreateStaffInitial.empty()) {
    on<FullNameInputEvent>(_onFullNameInputEvent);
    on<EmailInputEvent>(_onEmailInputEvent);
    on<PasswordInputEvent>(_onPasswordInputEvent);
    on<BirthdayInputEvent>(_onBirthdayInputEvent);
    on<PhoneInputEvent>(_onPhoneInputEvent);
    on<RoleInputEvent>(_onRoleInputEvent);
    on<SpecializationIdInputEvent>(_onSpecializationIdInputEvent);
    on<StartWorkingFromInputEvent>(_onStartWorkingFromInputEvent);
    on<RatingInputEvent>(_onRatingInputEvent);
    on<NumberOfRatesInputEvent>(_onNumberOfRatesInputEvent);
    on<DayOfWeekInputEvent>(_onDayOfWeekInputEvent);
    on<NextButtonPressedEvent>(_onNextButtonPressedEvent);
    on<NextButton1PressedEvent>(_onNextButton1PressedEvent);
    on<AddMoreButtonPressedEvent>(_onAddMoreButtonPressedEvent);
    on<CreateStaffButtonPressedEvent>(_onCreateStaffButtonPressedEvent);
    on<ValidateBirthdayInputEvent>(_validateBirthdayInputEvent);
    on<WorkingShiftInputEvent>(_onWorkingShiftInputEvent);
  }

  final NotificationManagerService _notificationManagerService;

  final AdminControlStaffApiService _supabaseAdminService;

  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordInputEvent(
    PasswordInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(tempBirthday: event.tempBirthday));
  }

  void _validateBirthdayInputEvent(
    ValidateBirthdayInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    final check = FormValidator.validateDate(event.tempBirthday).isValid;
    if (!check) {
      _notificationManagerService
          .show<void>(
            NotificationType.adminCreateStaff,
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
            (value) =>
                emit((state as CreateStaffLoading).toggleBackToInitial()),
          );
      return;
    }
    final formatter = DateFormat('dd/MM/yyyy');
    final birthday = formatter.parseStrict(
      event.tempBirthday,
    );
    emit(state.copyWith(birthday: birthday));
  }

  void _showErrorDialog() {
    if (_context != null) {
      showDialog(
        context: _context!,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter the date in the format dd/MM/yyyy'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _onPhoneInputEvent(
    PhoneInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onRoleInputEvent(
    RoleInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(role: event.role));
  }

  void _onSpecializationIdInputEvent(
    SpecializationIdInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(specializationId: event.specializationId));
  }

  void _onStartWorkingFromInputEvent(
    StartWorkingFromInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(startWorkingFrom: event.startWorkingFrom));
  }

  void _onRatingInputEvent(
    RatingInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onNumberOfRatesInputEvent(
    NumberOfRatesInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(numberOfRates: event.numberOfRates));
  }

  void _onDayOfWeekInputEvent(
    DayOfWeekInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(dayOfWeek: event.dayOfWeek));
  }

  void _onNextButtonPressedEvent(
    NextButtonPressedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(CreateStaffLater.from(state));
    // Login with Google
    try {} on AuthException catch (_) {}
  }

  void _onNextButton1PressedEvent(
    NextButton1PressedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    // Emit loading state
    emit(CreateStaffLoading.from(state));

    // Navigate to Sum-up Screen
    try {} on AuthException catch (_) {}
  }

  void _onAddMoreButtonPressedEvent(
    AddMoreButtonPressedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    // Emit loading state
    emit(CreateStaffLoading.from(state));

    // Navigate to Working-shift Screen
    try {} on AuthException catch (_) {}
  }

  Future<void> _onCreateStaffButtonPressedEvent(
    CreateStaffButtonPressedEvent event,
    Emitter<CreateStaffState> emit,
  ) async {
    emit(CreateStaffLoading.from(state));

    try {
      if (state.role == "Receptionist") {
        print('create receptionist');
        await _supabaseAdminService.signUpReceptionist(
          state.fullName,
          state.email,
          state.password,
          state.birthday,
          state.phone,
        );
      } else if (state.role == "Doctor") {
        await _supabaseAdminService.signUpDoctor(
          state.fullName,
          state.email,
          state.password,
          state.birthday,
          state.phone,
          state.specializationId,
          state.startWorkingFrom,
          state.rating,
          state.numberOfRates,
          state.dayOfWeek,
        );
      }
      emit(CreateStaffSuccess.from(state));
    } on AuthException catch (e) {
      assert(state is CreateStaffLoading, 'State is not loading');

      await _notificationManagerService
          .show<void>(
            NotificationType.adminCreateStaff,
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
            (value) =>
                emit((state as CreateStaffLoading).toggleBackToInitial()),
          );
    }
  }

  void _onWorkingShiftInputEvent(
    WorkingShiftInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    // Emit loading state
    emit(state.copyWith(dayOfWeek: event.dayOfWeek));
  }

  @override
  void onChange(Change<CreateStaffState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
