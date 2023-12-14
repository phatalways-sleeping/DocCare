import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:model_api/model_api.dart';
import 'package:model_api/src/prescription/service/prescription_api_service.dart';
import 'package:model_api/src/users/service/supabase_doctor_api_service.dart';
import 'package:models/models.dart';
import 'package:utility/utility.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this.ID,
    this._prescriptionAPIService,
    this._doctorAPIService,
  ) : super(PrescriptionInitial.empty()) {
    on<PrescriptionInitialEvent>(_onPrescriptionInitialEvent);
    on<PrescriptionTapEvent>(_onPrescriptionTapEvent);
  }

  final String ID;
  final SupabasePrescriptionApiService _prescriptionAPIService;
  final SupabaseDoctorApiService _doctorAPIService;

  void _onPrescriptionInitialEvent(
    PrescriptionInitialEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    try {
      print('ID: $ID');
      final doctorName = <String>[];
      final datePrescribed = <DateTime>[];
      final note = <String>[];
      final done = <bool>[];
      emit(PrescriptionInitial.empty());
      final prescription = await _prescriptionAPIService
          .getAllPrescriptionListByCustomerID(ID)
          .then((value) {
        for (final element in value) {
          doctorName.add(element.doctorID);
          datePrescribed.add(element.datePrescribed);
          note.add(element.note);
          done.add(element.done);
        }
      });

      for (var i = 0; i < doctorName.length; i++) {
        final doctor = await _doctorAPIService
            .getUser(doctorName[i])
            .then((value) => doctorName[i] = value.fullname);
      }

      emit(
        PrescriptionInitial.input(
          doctorName: doctorName,
          datePrescribed: datePrescribed,
          note: note,
          done: done,
        ),
      );
    } catch (e) {
      return;
    }
  }

  void _onPrescriptionTapEvent(
    PrescriptionTapEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    try {
      emit(PrescriptionInitial.empty());
    } catch (e) {
      return;
    }
  }
}
