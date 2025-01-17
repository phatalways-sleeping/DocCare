// ignore_for_file: public_member_api_docs
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:utility/utility.dart';
import 'package:controllers/controllers.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this._navigatorKey,
    this._notificationManagerService,
    this._customerRepositoryService,
  ) : super(PrescriptionViewState.initial()) {
    on<PrescriptionCheckEvent>(_onPrescriptionCheckEvent);
    on<PrescriptionOpenMedicinesViewEvent>(
        _onPrescriptionOpenMedicinesViewEvent);
    on<MedicineCheckEvent>(_onMedicineCheckEvent);
    on<OpenIntakeViewEvent>(_onMedicineOpenIntakeViewEvent);
    on<IntakeRatingEvent>(_onIntakeRatingEvent);
    on<PrescriptionResetEvent>(_onPrescriptionResetEvent);
    on<PrescriptionEmptyEvent>(_onPrescriptionEmptyEvent);
  }

  @override
  void onTransition(
      Transition<PrescriptionEvent, PrescriptionState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }

  final NotificationManagerService _notificationManagerService;
  final GlobalKey<NavigatorState> _navigatorKey;
  final CustomerRepositoryService _customerRepositoryService;

  Future<List<Map<String, dynamic>>> getLatestPrescription() async {
    final results = await _customerRepositoryService.getCurrentPrescriptions();

    return results;
  }

  Future<List<Map<String, dynamic>>> getPastPrescriptions() async {
    final results = await _customerRepositoryService.getPastPrescriptions();

    return results;
  }

  Future<List<Map<String, dynamic>>> getLatestMedicines(
    String prescriptionID,
  ) async {
    final results = await _customerRepositoryService
        .getCurrentPrescriptionMedicines(prescriptionID);

    return results;
  }

  Future<List<Map<String, dynamic>>> getPastMedicines(
    String prescriptionID,
  ) async {
    final results = await _customerRepositoryService
        .getPastPrescriptionMedicines(prescriptionID);

    return results;
  }

  Future<Map<String, dynamic>> getCurrentPrescriptions(
    String prescriptionID,
  ) async {
    final results =
        await _customerRepositoryService.getPrescriptionData(prescriptionID);

    return results;
  }

  void _onPrescriptionResetEvent(
    PrescriptionResetEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(PrescriptionViewState.initial());
  }

  Future<void> _onPrescriptionEmptyEvent(
    PrescriptionEmptyEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    emit(PrescriptionBlankState.fromState(state));

    var check = false;

    await _customerRepositoryService.getPastPrescriptions().then((value) {
      if (value.isEmpty) {
        check = true;
      }
    });

    await _customerRepositoryService.getCurrentPrescriptions().then((value) {
      if (value.isEmpty && check) {
        emit(const PrescriptionEmptyState());
      } else {
        emit(PrescriptionViewState.initial());
      }
    });
  }

  Future<void> _onPrescriptionCheckEvent(
    PrescriptionCheckEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    if (state is PrescriptionViewLoadingState) {
      return emit(PrescriptionViewLoadingState.fromState(state));
    }
    if (state is! PrescriptionViewState) {
      return emit(PrescriptionViewState.initial());
    }
    try {
      emit(PrescriptionViewLoadingState.fromState(state));

      await _customerRepositoryService.updateAppointmentDone(
        event.done,
        event.prescriptionId,
      );

      emit(PrescriptionViewState.initial());
      // throw Exception('Error');
    } catch (error) {
      emit(PrescriptionViewState.initial());
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
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
      var tmpPrescriptionId = event.prescriptionId;
      return emit(
        MedicinesViewState.fromState(
          state,
          prescriptionId: tmpPrescriptionId,
        ),
      );
    }
    try {
      emit(MedicinesViewLoadingState.fromState(state));

      await _customerRepositoryService
          .updateMedicineDone(
            event.done,
            state.prescriptionId,
            event.medicineName,
          )
          .then((value) {});

      emit(MedicinesViewState.fromState(state));
    } catch (error) {
      emit(MedicinesViewLoadingState.fromState(state));
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
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
    if (state is! PrescriptionViewState) {
      return emit(PrescriptionViewState.initial());
    }
    emit(
      IntakeViewState.fromState(state, event.prescriptionId),
    );
  }

  Future<void> _onIntakeRatingEvent(
    IntakeRatingEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    if (state is! IntakeViewState) {
      emit(IntakeViewState.fromState(state, event.prescriptionId));
    }

    final results = await _customerRepositoryService
        .getPrescriptionData(event.prescriptionId);

    await _customerRepositoryService.ratePrescription(
      int.parse(results['period'].toString()),
      results['doctorID'].toString(),
      results['date'].toString(),
      event.rating,
    );

    emit(PrescriptionViewState.initial());
  }
}
