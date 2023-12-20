// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'create_staff_event.dart';
part 'create_staff_state.dart';

class StaffCreationBloc extends Bloc<CreateStaffEvent, CreateStaffState> {
  StaffCreationBloc() : super(CreateStaffInitial.initial()) {
    on<CreateStaffResetEvent>(_onCreateStaffResetEvent);
    on<CreateStaffNameChangedEvent>(_onCreateStaffNameChangedEvent);
    on<CreateStaffEmailChangedEvent>(_onCreateStaffEmailChangedEvent);
    on<CreateStaffPasswordChangedEvent>(_onCreateStaffPasswordChangedEvent);
    on<CreateStaffBirthdateChangedEvent>(_onCreateStaffBirthdateChangedEvent);
    on<CreateStaffPhoneNumberChangedEvent>(
        _onCreateStaffPhoneNumberChangedEvent);
    on<CreateStaffSubmitEvent>(_onCreateStaffSubmitEvent);
    on<CreateStaffAddNewWorkingShiftEvent>(
        _onCreateStaffAddNewWorkingShiftEvent);
    on<CreateStaffRemoveWorkingShiftEvent>(
        _onCreateStaffRemoveWorkingShiftEvent);
    on<CreateStaffChangeWeekdayEvent>(_onCreateStaffChangeWeekdayEvent);
    on<CreateStaffChangeStartPeriodEvent>(_onCreateStaffChangeStartPeriodEvent);
    on<CreateStaffChangeEndPeriodEvent>(_onCreateStaffChangeEndPeriodEvent);
    on<CreateStaffRoleChangedEvent>(_onCreateStaffRoleChangedEvent);
    on<CreateStaffSpecializationChangedEvent>(
        _onCreateStaffSpecializationChangedEvent);
  }

  void _onCreateStaffResetEvent(
    CreateStaffResetEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(CreateStaffInitial.initial());
  }

  void _onCreateStaffNameChangedEvent(
    CreateStaffNameChangedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(fullName: event.name));
  }

  void _onCreateStaffEmailChangedEvent(
    CreateStaffEmailChangedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onCreateStaffSpecializationChangedEvent(
    CreateStaffSpecializationChangedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(specialization: event.specialization));
  }

  void _onCreateStaffPasswordChangedEvent(
    CreateStaffPasswordChangedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onCreateStaffBirthdateChangedEvent(
    CreateStaffBirthdateChangedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(birthdate: event.birthdate));
  }

  void _onCreateStaffPhoneNumberChangedEvent(
    CreateStaffPhoneNumberChangedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onCreateStaffRoleChangedEvent(
    CreateStaffRoleChangedEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(state.copyWith(role: event.role));
  }

  Future<void> _onCreateStaffSubmitEvent(
    CreateStaffSubmitEvent event,
    Emitter<CreateStaffState> emit,
  ) async {
    // Data validation

    // Start submitting
    try {
      emit(CreateStaffLoading.fromState(state));
      await Future.delayed(const Duration(seconds: 2), () {}); // Fake request
      // throw Exception('Request failed');
      emit(CreateStaffSuccess.fromState(state));
    } catch (error) {
      emit(
        CreateStaffFailure.fromState(
          state: state,
          errorMessage: 'Request failed',
        ),
      );
    }
  }

  void _onCreateStaffAddNewWorkingShiftEvent(
    CreateStaffAddNewWorkingShiftEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    final workingShifts = <Map<String, dynamic>>[
      ...state.workingShifts,
      {
        'weekDay': null,
        'startPeriod': null,
        'endPeriod': null,
      }
    ];

    emit(state.copyWith(workingShifts: workingShifts));
  }

  void _onCreateStaffChangeWeekdayEvent(
    CreateStaffChangeWeekdayEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    final workingShifts = <Map<String, dynamic>>[
      ...state.workingShifts,
    ]..[event.index]['weekDay'] = event.weekDay;

    emit(state.copyWith(workingShifts: workingShifts));
  }

  void _onCreateStaffChangeStartPeriodEvent(
    CreateStaffChangeStartPeriodEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    final workingShifts = <Map<String, dynamic>>[
      ...state.workingShifts,
    ]..[event.index]['startPeriod'] = event.startPeriod;

    emit(state.copyWith(workingShifts: workingShifts));
  }

  void _onCreateStaffChangeEndPeriodEvent(
    CreateStaffChangeEndPeriodEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    final workingShifts = <Map<String, dynamic>>[
      ...state.workingShifts,
    ]..[event.index]['endPeriod'] = event.endPeriod;

    emit(state.copyWith(workingShifts: workingShifts));
  }

  void _onCreateStaffRemoveWorkingShiftEvent(
    CreateStaffRemoveWorkingShiftEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    final workingShifts = <Map<String, dynamic>>[
      ...state.workingShifts,
    ]..removeAt(event.index);

    emit(state.copyWith(workingShifts: workingShifts));
  }
}
