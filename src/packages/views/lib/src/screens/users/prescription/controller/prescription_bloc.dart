// ignore_for_file: public_member_api_docs
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:utility/utility.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this._notificationManagerService,
  ) : super(PrescriptionViewState.initial()) {
    on<PrescriptionCheckEvent>(_onPrescriptionCheckEvent);
    on<PrescriptionOpenMedicinesViewEvent>(
        _onPrescriptionOpenMedicinesViewEvent);
    on<MedicineCheckEvent>(_onMedicineCheckEvent);
    on<OpenIntakeViewEvent>(_onMedicineOpenIntakeViewEvent);
    on<IntakeRatingEvent>(_onIntakeRatingEvent);
    on<PrescriptionResetEvent>(_onPrescriptionResetEvent);
  }

  @override
  void onTransition(
      Transition<PrescriptionEvent, PrescriptionState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }

  final NotificationManagerService _notificationManagerService;

  Future<List<Map<String, dynamic>>> getLatestPrescription() => Future.delayed(
        const Duration(seconds: 3),
        () => [
          {
            'doctorName': 'Nguyen Van A',
            'date': DateTime.now(),
            'Note': 'Note',
            'id': 'P001',
          },
          {
            'doctorName': 'Nguyen Van A',
            'date': DateTime.now(),
            'Note': 'Note',
            'id': 'P002',
          },
          {
            'doctorName': 'Nguyen Van A',
            'date': DateTime.now(),
            'Note': 'Note',
            'id': 'P003',
          },
        ],
      );

  Future<List<Map<String, dynamic>>> getPastPrescriptions() => Future.delayed(
        const Duration(seconds: 3),
        () => [
          {
            'doctorName': 'Nguyen Van A',
            'date': DateTime.now(),
            'Note': 'Note',
            'id': 'P005',
          },
        ],
      );

  Future<List<Map<String, dynamic>>> getLatestMedicines() => Future.delayed(
        const Duration(seconds: 3),
        () => [
          {
            'medicineName': 'Ranitidine',
            'quantity': 1,
            'toBeTaken': 0,
            'time': 'Morning,Afternoon,Evening',
          },
          {
            'medicineName': 'Esomeprazole',
            'quantity': 1,
            'toBeTaken': 1,
            'time': 'Morning',
          },
        ],
      );

  Future<List<Map<String, dynamic>>> getPastMedicines() => Future.delayed(
        const Duration(seconds: 3),
        () => [
          {
            'medicineName': 'Ranitidine',
            'quantity': 1,
            'toBeTaken': 0,
            'time': 'Morning,Afternoon,Evening',
          },
        ],
      );

  void _onPrescriptionResetEvent(
    PrescriptionResetEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(PrescriptionViewState.initial());
  }

  Future<void> _onPrescriptionCheckEvent(
    PrescriptionCheckEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    if (state is PrescriptionViewLoadingState) {
      return;
    }
    if (state is! PrescriptionViewState) {
      return emit(PrescriptionViewState.initial());
    }
    try {
      emit(PrescriptionViewLoadingState.fromState(state));

      await Future.delayed(const Duration(seconds: 2), () {}); // Mock delay

      // throw Exception('Error');

      emit(PrescriptionViewState.initial());
    } catch (error) {
      emit(PrescriptionViewState.initial());
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text('Error'),
        message: const Text('An error occured while loading the prescription.'),
      );
    }
  }

  void _onPrescriptionOpenMedicinesViewEvent(
    PrescriptionOpenMedicinesViewEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(
      MedicinesViewState.fromState(
        state,
        prescriptionId: event.prescriptionId,
      ),
    );
  }

  Future<void> _onMedicineCheckEvent(
    MedicineCheckEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    if (state is MedicinesViewLoadingState) {
      return;
    }
    if (state is! MedicinesViewState) {
      return emit(PrescriptionViewState.initial());
    }
    try {
      emit(MedicinesViewLoadingState.fromState(state));

      await Future.delayed(const Duration(seconds: 2), () {}); // Mock delay

      emit(MedicinesViewState.fromState(state));
    } catch (error) {
      emit(MedicinesViewLoadingState.fromState(state));
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text('Error'),
        message: const Text('An error occured while processing the medicine.'),
      );
    }
  }

  void _onMedicineOpenIntakeViewEvent(
    OpenIntakeViewEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    if (state is! MedicinesViewState) {
      return emit(PrescriptionViewState.initial());
    }
    emit(
      IntakeViewState.fromState(state),
    );
  }

  void _onIntakeRatingEvent(
    IntakeRatingEvent event,
    Emitter<PrescriptionState> emit,
  ) {}
}
