// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:services/services.dart';
import 'package:supabase/supabase.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this._notificationManagerService,
    this._supabaseClient,
  ) : super(
          PrescriptionMedicalLoading.from(
            const PrescriptionMedicalInitial.empty(),
          ),
        ) {
    on<HeartRateInputEvent>(_onHeartRateInputEvent);
    on<BloodPressureInputEvent>(_onBloodPressureInputEvent);
    on<ChoresterolInputEvent>(_onCholesterolInputEvent);
    on<BloodSugarInputEvent>(_onBloodSugarInputEvent);
    on<DoctorNoteInputEvent>(_onDoctorNoteInputEvent);
    on<NextButtonPressedEvent>(_onNextButtonPressedEvent);
    on<DoctorNoteMedicineInputEvent>(_onDoctorNoteMedicineInputEvent);
    on<AddMedicineButtonPressedEvent>(_onAddMedicineButtonPressedEvent);
    on<MedicineNameInputEvent>(_onMedicineNameInputEvent);
    on<MedicineDurationInputEvent>(_onMedicineDurationInputEvent);
    on<MedicineDoseInputEvent>(_onMedicineDoseInputEvent);
    on<MedicineMealTimeInputEvent>(_onMedicineMealTimeInputEvent);
    on<MedicineTimeTakenInputEvent>(_onMedicineTimeTakenInputEvent);
    on<AddIntakeButtonPressedEvent>(_onAddIntakeButtonPressedEvent);
    on<RemoveMedicineButtonPressedEvent>(_onRemoveMedicineButtonPressedEvent);
    on<AddPrescriptionButtonPressedEvent>(_onAddPrescriptionButtonPressedEvent);
    on<PrescriptionBackEvent>(_onPrescriptionBackEvent);
    on<RetrieveMedicineEvent>(_onRetrieveMedicineEvent);
  }

  final NotificationManagerService _notificationManagerService;

  final SupabaseClient _supabaseClient;

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
    final updatedDoctorNote = List<String>.from(state.doctorNote);
    updatedDoctorNote[0] = event.doctorNote;
    emit(state.copyWith(doctorNote: updatedDoctorNote));
  }

  void _onDoctorNoteMedicineInputEvent(
    DoctorNoteMedicineInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    final updatedDoctorNote = List<String>.from(state.doctorNote);
    updatedDoctorNote[1] = event.doctorNote;
    emit(state.copyWith(doctorNote: updatedDoctorNote));
  }

  void _onAddMedicineButtonPressedEvent(
    AddMedicineButtonPressedEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(PrescriptionAddMedicine.from(state));
  }

  void _onMedicineNameInputEvent(
    MedicineNameInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(currentMedicineName: event.currentMedicineName));
  }

  void _onMedicineDurationInputEvent(
    MedicineDurationInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(currentDuration: event.currentDuration));
  }

  void _onMedicineDoseInputEvent(
    MedicineDoseInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(currentDose: event.currentDose));
  }

  void _onMedicineMealTimeInputEvent(
    MedicineMealTimeInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    final updatedMealTime = List<bool>.from(state.currentMealTime);
    updatedMealTime[event.currentMealTime] =
        !updatedMealTime[event.currentMealTime];
    emit(state.copyWith(currentMealTime: updatedMealTime));
  }

  void _onMedicineTimeTakenInputEvent(
    MedicineTimeTakenInputEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    final updatedTimeToTake = List<bool>.from(state.currentTimeToTake);
    updatedTimeToTake[event.currentTimeTaken] =
        !updatedTimeToTake[event.currentTimeTaken];
    emit(state.copyWith(currentTimeToTake: updatedTimeToTake));
  }

  Future<void> _onAddIntakeButtonPressedEvent(
    AddIntakeButtonPressedEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    if (state.currentMedicineName.isEmpty ||
        state.currentDuration.isEmpty ||
        state.currentDose.isEmpty ||
        state.currentTimeToTake.isEmpty ||
        state.currentMealTime.isEmpty) {
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

    if (!state.availableMedicines.contains(state.currentMedicineName)) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Medicine is not in available list',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    if (!FormValidator.validateNumber(state.currentDose).isValid) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Dose is invalid',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    if (!FormValidator.validateNumber(state.currentDuration).isValid) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Duration is invalid',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    if (state.medicines.containsKey(state.currentMedicineName)) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Medicine is already in the list',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      return;
    }

    var timeTake = '';
    for (var i = 0; i < state.currentTimeToTake.length; i++) {
      if (state.currentTimeToTake[i]) {
        if (i == 0) {
          timeTake += 'Morning/';
        } else if (i == 1) {
          timeTake += 'Afternoon/';
        } else if (i == 2) {
          timeTake += 'Evening/';
        } else {
          timeTake += 'Night/';
        }
      }
    }

    var mealTime = '';
    if (state.currentMealTime[0] == true) {
      mealTime += 'Before meal';
    } else {
      mealTime += 'After meal';
    }

    final newMedicines = Map<String, List<String>>.from(state.medicines);
    newMedicines[state.currentMedicineName] = [
      state.currentDuration,
      state.currentDose,
      timeTake,
      mealTime,
    ];

    emit(
      PrescriptionMedicalSuccess.from(
        state.copyWith(
          medicines: newMedicines,
          currentMedicineName: '',
          currentDuration: '',
          currentDose: '',
          currentTimeToTake: [false, false, false, false],
          currentMealTime: [false, false],
        ),
      ),
    );
  }

  Future<void> _onRemoveMedicineButtonPressedEvent(
    RemoveMedicineButtonPressedEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    final newMedicines = Map<String, List<String>>.from(state.medicines)
      ..remove(event.medicineName);

    emit(
      PrescriptionMedicalSuccess.from(
        state.copyWith(
          medicines: newMedicines,
        ),
      ),
    );
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
    emit(PrescriptionMedicalSuccess.from(state));
  }

  Future<void> _onAddPrescriptionButtonPressedEvent(
    AddPrescriptionButtonPressedEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    // TODO(phucchuhoang): add the medical stat + prescription to the database
    emit(PrescriptionMedicalLoading.from(state));

    emit(PrescriptionSuccess.from(state));
  }

  void _onPrescriptionBackEvent(
    PrescriptionBackEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    if (state is PrescriptionAddMedicine) {
      emit(PrescriptionMedicalSuccess.from(state));
    } else if (state is PrescriptionMedicalSuccess) {
      emit(PrescriptionMedicalInitial.from(state));
    }
  }

  Future<void> _onRetrieveMedicineEvent(
    RetrieveMedicineEvent event,
    Emitter<PrescriptionState> emit,
  ) async {
    final instance = SupabaseMedicineApiService(supabase: _supabaseClient);
    try {
      final availableMed = await instance.getAllMedicineList();
      final allMed = List<String>.from([]);
      for (final med in availableMed) {
        allMed.add(med.name);
      }
      emit(
        PrescriptionMedicalInitial.from(
          state.copyWith(availableMedicines: allMed),
        ),
      );
    } catch (e) {
      await _notificationManagerService.show<void>(
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Cannot retrieve medicine list',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
  }
}
