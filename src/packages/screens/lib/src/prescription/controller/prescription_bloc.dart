import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:model_api/model_api.dart';
import 'package:model_api/src/prescription/service/prescription_api_service.dart';
import 'package:models/models.dart';
import 'package:utility/utility.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this.ID,
    this._prescriptionAPIService,
  ) : super(PrescriptionInitial.empty()) {
    on<PrescriptionInitialEvent>(_onPrescriptionInitialEvent);
    on<PrescriptionTapEvent>(_onPrescriptionTapEvent);
  }

  final String ID;
  final SupabasePrescriptionApiService _prescriptionAPIService;

  void _onPrescriptionInitialEvent(
    PrescriptionInitialEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    try {
      print('ID: $ID');
      emit(PrescriptionInitial.empty());
      final prescription = await _prescriptionAPIService
          .getAllPrescriptionListByCustomerID(ID)
          .then((value) {
        final doctorName = <String>[];
        final datePrescribed = <DateTime>[];
        final note = <String>[];
        final done = <bool>[];
        for (final element in value) {
          doctorName.add(element.doctorID);
          datePrescribed.add(element.datePrescribed);
          note.add(element.note);
          done.add(element.done);
        }
        return emit(
          PrescriptionInitial.input(
            doctorName: doctorName,
            datePrescribed: datePrescribed,
            note: note,
            done: done,
          ),
        );
      });
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
