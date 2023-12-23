// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;
import 'package:uuid/uuid.dart';

part 'prescription_event.dart';
part 'prescription_state.dart';

class PrescriptionBloc extends Bloc<PrescriptionEvent, PrescriptionState> {
  PrescriptionBloc(
    this._navigatorKey,
    this._notificationManagerService,
    this._doctorRepositoryService,
  ) : super(
          PrescriptionMedicalInitial.empty(),
        ) {
    on<CustomerIDAssignEvent>(_onCustomerIDAssignEvent);
    on<PeriodAssignEvent>(_onPeriodAssignEvent);
    on<DateAssignEvent>(_onDateAssignEvent);
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
  final GlobalKey<NavigatorState> _navigatorKey;
  final DoctorRepositoryService _doctorRepositoryService;

  void _onCustomerIDAssignEvent(
    CustomerIDAssignEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(customerID: event.customerID));
  }

  void _onPeriodAssignEvent(
    PeriodAssignEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(period: event.period));
  }

  void _onDateAssignEvent(
    DateAssignEvent event,
    Emitter<PrescriptionState> emit,
  ) {
    emit(state.copyWith(date: event.date));
  }

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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
        _navigatorKey.currentContext!,
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
    if (state.medicines.isEmpty || state.doctorNote[0].isEmpty) {
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
        NotificationType.error,
        title: const Text(
          'Prescription is not complete',
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

    // final prescriptionId = const Uuid().v4();
    const prescriptionId = 'P001';
    final diagnosis = state.doctorNote[0];
    final medicineNote = state.doctorNote[1];
    final date = DateTime.now().toIso8601String();

    await _doctorRepositoryService.addPrescriptionToDatabase(
      customerID: state.customerID,
      period: '',
      date: date,
      prescriptionID: prescriptionId,
      doctorNote: [diagnosis, medicineNote],
      medicines: state.medicines,
      heartRate: state.heartRate,
      bloodPressure: state.bloodPressure,
      bloodSugar: state.bloodSugar,
      choresterol: state.choresterol,
    );

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
    try {
      final availableMed =
          await _doctorRepositoryService.getAvailableMedicine();
      final allMed = List<String>.from([]);
      for (final med in availableMed) {
        allMed.add(med);
      }

      emit(
        PrescriptionMedicalInitial.from(
          state.copyWith(availableMedicines: allMed),
        ),
      );
    } catch (e) {
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
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
