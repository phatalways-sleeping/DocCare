// ignore_for_file: public_member_api_docs
import 'package:administrator/administrator.dart';
import 'package:auth_api/auth_api.dart' show AuthException;
import 'package:auth_domain/auth_domain.dart'
    show AuthenticationRepositoryService;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:models/models.dart' show CreateStaffUser;
import 'package:utility/utility.dart'
    show NotificationManagerService, NotificationType;

part 'create_staff_event.dart';
part 'create_staff_state.dart';

class CreateStaffBloc extends Bloc<CreateStaffEvent, CreateStaffState> {
  CreateStaffBloc(
    this._authenticationRepositoryService,
    this._notificationManagerService,
  ) : super(CreateStaffInitial.empty()) {
    on<FullNameInputEvent>(_onFullNameInputEvent);
    on<EmailInputEvent>(_onEmailInputEvent);
    on<PasswordInputEvent>(_onPasswordInputEvent);
    on<BirthdayInputEvent>(_onBirthdayInputEvent);
    on<PhoneInputEvent>(_onPhoneInputEvent);
    on<CreateStaffButtonPressedEvent>(_onCreateStaffButtonPressedEvent);
  }

  final AuthenticationRepositoryService _authenticationRepositoryService;

  final NotificationManagerService _notificationManagerService;

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
    final formatter = DateFormat('dd/mm/yyyy');
    final birthday = formatter.parse(event.birthday);
    emit(state.copyWith(birthday: birthday));
  }

  void _onPhoneInputEvent(
    PhoneInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(phone: event.phone));
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

  void _onStartPeriodIDInputEvent(
    StartPeriodIDInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(startPeriodID: event.startPeriodID));
  }

  void _onEndPeriodIDInputEvent(
    EndPeriodIDInputEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(endPeriodID: event.endPeriodID));
  }

  Future<void> _onCreateStaffButtonPressedEvent(
    CreateStaffButtonPressedEvent event,
    Emitter<CreateStaffState> emit,
  ) async {
    emit(CreateStaffLoading.from(state));

    try {
      CreateStaffUser user;
      if (state.role == "receptionist") {
        user = CreateStaffUser(
          state.email,
          state.password,
          state.birthday,
          state.fullName,
          state.phone,
        );
      } else if (state.role == "doctor") {
        user = CreateStaffUser(
          state.email,
          state.password,
          state.birthday,
          state.fullName,
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

      await _authenticationRepositoryService.CreateStaff(user).then(
        (value) => emit(CreateStaffSuccess.from(state)),
      );
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

  void _onGoogleLoginButtonPressedEvent(
    NextButtonPressedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    // Emit loading state
    emit(CreateStaffLoading.from(state));

    // Login with Google
    try {} on AuthException catch (_) {}
  }
}
