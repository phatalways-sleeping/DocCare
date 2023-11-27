// ignore_for_file: public_member_api_docs
import 'package:administrator/administrator.dart';
import 'package:auth_api/auth_api.dart' show AuthException;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:utility/utility.dart'
    show NotificationManagerService, NotificationType;

part 'control_staff_event.dart';
part 'control_staff_state.dart';

class ControlStaffBloc extends Bloc<ControlStaffEvent, ControlStaffState> {
  ControlStaffBloc(
    this._notificationManagerService,
    this._supabaseAdminService,
  ) : super(ControlStaffInitial.empty()) {
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
    on<StartPeriodIDInputEvent>(_onStartPeriodIDInputEvent);
    on<EndPeriodIDInputEvent>(_onEndPeriodIDInputEvent);
    on<NextButtonPressedEvent>(_onNextButtonPressedEvent);
    on<NextButton1PressedEvent>(_onNextButton1PressedEvent);
    on<AddMoreButtonPressedEvent>(_onAddMoreButtonPressedEvent);
    on<ControlStaffButtonPressedEvent>(_onControlStaffButtonPressedEvent);
  }

  final NotificationManagerService _notificationManagerService;

  final AdminControlStaffApiService _supabaseAdminService;
  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordInputEvent(
    PasswordInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    final formatter = DateFormat('dd/mm/yyyy');
    final birthday = formatter.parse(event.birthday);
    emit(state.copyWith(birthday: birthday));
  }

  void _onPhoneInputEvent(
    PhoneInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
  }

  void _onRoleInputEvent(
    RoleInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(phone: event.role));
  }

  void _onSpecializationIdInputEvent(
    SpecializationIdInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(specializationId: event.specializationId));
  }

  void _onStartWorkingFromInputEvent(
    StartWorkingFromInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(startWorkingFrom: event.startWorkingFrom));
  }

  void _onRatingInputEvent(
    RatingInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onNumberOfRatesInputEvent(
    NumberOfRatesInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(numberOfRates: event.numberOfRates));
  }

  void _onDayOfWeekInputEvent(
    DayOfWeekInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(dayOfWeek: event.dayOfWeek));
  }

  void _onStartPeriodIDInputEvent(
    StartPeriodIDInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(startPeriodID: event.startPeriodID));
  }

  void _onEndPeriodIDInputEvent(
    EndPeriodIDInputEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    emit(state.copyWith(endPeriodID: event.endPeriodID));
  }

  void _onNextButtonPressedEvent(
    NextButtonPressedEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    // Emit loading state
    emit(ControlStaffLoading.from(state));

    // Login with Google
    try {} on AuthException catch (_) {}
  }

  void _onNextButton1PressedEvent(
    NextButton1PressedEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    // Emit loading state
    emit(ControlStaffLoading.from(state));

    // Navigate to Sum-up Screen
    try {} on AuthException catch (_) {}
  }

  void _onAddMoreButtonPressedEvent(
    AddMoreButtonPressedEvent event,
    Emitter<ControlStaffState> emit,
  ) {
    // Emit loading state
    emit(ControlStaffLoading.from(state));

    // Navigate to Working-shift Screen
    try {} on AuthException catch (_) {}
  }

  Future<void> _onControlStaffButtonPressedEvent(
    ControlStaffButtonPressedEvent event,
    Emitter<ControlStaffState> emit,
  ) async {
    emit(ControlStaffLoading.from(state));

    try {
      if (state.role == "receptionist") {
        await _supabaseAdminService.signUpReceptionist(
          state.fullName,
          state.email,
          state.password,
          state.birthday,
          state.phone,
        );
      } else if (state.role == "doctor") {
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
          state.endPeriodID,
          state.endPeriodID,
        );
      }

      emit(ControlStaffSuccess.from(state));
    } on AuthException catch (e) {
      assert(state is ControlStaffLoading, 'State is not loading');

      await _notificationManagerService
          .show<void>(
            NotificationType.adminControlStaff,
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
                emit((state as ControlStaffLoading).toggleBackToInitial()),
          );
    }
  }
}
