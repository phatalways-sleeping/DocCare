// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_staff_event.dart';
part 'create_staff_state.dart';

class StaffCreationBloc extends Bloc<CreateStaffEvent, CreateStaffState> {
  StaffCreationBloc(
    this._administratorRepositoryService,
  ) : super(CreateStaffInitial.initial()) {
    on<CreateStaffResetEvent>(_onCreateStaffResetEvent);
    on<CreateStaffBackEvent>(_onCreateStaffBackEvent);
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

  final AdministratorRepositoryService _administratorRepositoryService;

  Future<List<String>> getSpecializations() async =>
      _administratorRepositoryService.getSpecializations();

  @override
  void onTransition(Transition<CreateStaffEvent, CreateStaffState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }

  void _onCreateStaffResetEvent(
    CreateStaffResetEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(CreateStaffInitial.initial());
  }

  void _onCreateStaffBackEvent(
    CreateStaffBackEvent event,
    Emitter<CreateStaffState> emit,
  ) {
    emit(CreateStaffInitial.fromState(state));
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
    try {
      emit(CreateStaffLoading.fromState(state));
      final birthdayArr = state.birthdate.split('/');
      final birthday = DateTime(
        int.parse(birthdayArr[2]),
        int.parse(birthdayArr[1]),
        int.parse(birthdayArr[0]),
      );
      if (state.role == 'Doctor') {
        final workingShifts = <String, List<int>>{};
        for (final entry in state.workingShifts) {
          workingShifts[entry['weekDay'] as String] = [
            int.parse(entry['startPeriod'] as String),
            int.parse(entry['endPeriod'] as String),
          ];
        }
        await _administratorRepositoryService.signUpDoctor(
          state.fullName,
          state.email,
          state.password,
          birthday,
          state.phoneNumber,
          state.specialization,
          workingShifts,
        );
      } else {
        await _administratorRepositoryService.signUpReceptionist(
          state.fullName,
          state.email,
          state.password,
          birthday,
          state.phoneNumber,
        );
      }
      emit(CreateStaffSuccess.fromState(state));
    } on AuthException catch (error) {
      debugPrint(error.toString());
      emit(
        CreateStaffFailure.fromState(
          state: state,
          errorMessage: 'Request failed',
        ),
      );
    } on TimeoutException catch (_) {
      emit(
        CreateStaffFailure.fromState(
          state: state,
          errorMessage: 'Request timed out',
        ),
      );
    } on Exception catch (error) {
      debugPrint(error.toString());
      emit(
        CreateStaffFailure.fromState(
          state: state,
          errorMessage: 'An unknown error has occurred',
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
