// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this._notificationManagerService,
  ) : super(PrescriptionMedicalInitial.empty()) {
    on<HeartRateInputEvent>(_onHeartRateInputEvent);
    on<BloodPressureInputEvent>(_onBloodPressureInputEvent);
    on<ChoresterolInputEvent>(_onCholesterolInputEvent);
    on<BloodSugarInputEvent>(_onBloodSugarInputEvent);
    on<DoctorNoteInputEvent>(_onDoctorNoteInputEvent);
    on<NextButtonPressedEvent>(_onNextButtonPressedEvent);
  }

  final NotificationManagerService _notificationManagerService;

  void _onHeartRateInputEvent(
    HeartRateInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(heartRate: event.heartRate));
  }

  void _onBloodPressureInputEvent(
    BloodPressureInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(bloodPressure: event.bloodPressure));
  }

  void _onCholesterolInputEvent(
    ChoresterolInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(choresterol: event.choresterol));
  }

  void _onBloodSugarInputEvent(
    BloodSugarInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(bloodSugar: event.bloodSugar));
  }

  void _onDoctorNoteInputEvent(
    DoctorNoteInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(doctorNote: event.doctorNote));
  }

  Future<void> _onNextButtonPressedEvent(
    NextButtonPressedEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    if (state.bloodPressure.isEmpty ||
        state.bloodSugar.isEmpty ||
        state.heartRate.isEmpty ||
        state.choresterol.isEmpty) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
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

    if (!FormValidator.validateBloodPressure(state.bloodPressure).isValid) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Blood pressure is invalid',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    if (!FormValidator.validateNumber(state.heartRate).isValid) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Heart rate is invalid',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    if (!FormValidator.validateNumber(state.choresterol).isValid) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Cholesterol is invalid',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    if (!FormValidator.validateNumber(state.bloodSugar).isValid) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Blood sugar is invalid',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    emit(PrescriptionMedicalLoading.from(state));

    // TODO(phucchuhoang): add the medical stats to the database

    emit(PrescriptionMedicalSuccess.from(state));
  }
}
