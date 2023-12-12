// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this._notificationManagerService,
  ) : super(PrescriptionInitial.empty()) {
    on<HeartRateInputEvent>(_onHeartRateInputEvent);
    on<BloodPressureInputEvent>(_onBloodPressureInputEvent);
    on<ChoresterolInputEvent>(_onCholesterolInputEvent);
    on<BloodSugarInputEvent>(_onBloodSugarInputEvent);
    on<DoctorNoteInputEvent>(_onDoctorNoteInputEvent);
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
}
