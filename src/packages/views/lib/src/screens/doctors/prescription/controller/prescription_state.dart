// ignore_for_file: public_member_api_docs

part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionState extends Equatable {
  const PrescriptionState({
    required this.customerName,
    required this.heartRate,
    required this.bloodPressure,
    required this.choresterol,
    required this.bloodSugar,
    required this.doctorNote,
    required this.medicines,
    required this.currentMedicineName,
    required this.currentDuration,
    required this.currentDose,
    required this.currentTimeToTake,
    required this.currentMealTime,
    required this.availableMedicines,
  });

  final String customerName;

  final String heartRate;
  final String bloodPressure;
  final String choresterol;
  final String bloodSugar;

  /// doctorNote[0] is the doctor's note for medical stat
  /// doctorNote[1] is the doctor's note for medicine
  final List<String> doctorNote;

  /// medicines is a map of medicine name to medicine details
  /// key is the medicine name
  /// value is a list of medicine details
  /// value[0] is the medicine duration
  /// value[1] is the medicine dose per time
  /// value[2] is the time of the day to take the medicine
  /// value[3] is before or after meal
  final Map<String, List<String>> medicines;

  final String currentMedicineName;
  final String currentDuration;
  final String currentDose;
  final List<bool> currentTimeToTake;
  final List<bool> currentMealTime;
  final List<String> availableMedicines;

  @override
  List<Object> get props => [
        customerName,
        heartRate,
        bloodPressure,
        choresterol,
        bloodSugar,
        doctorNote,
        medicines,
        currentMedicineName,
        currentDuration,
        currentDose,
        currentTimeToTake,
        currentMealTime,
        availableMedicines,
      ];

  PrescriptionState copyWith({
    String? customerName,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    List<String>? doctorNote,
    Map<String, List<String>>? medicines,
    String? currentMedicineName,
    String? currentDuration,
    String? currentDose,
    List<bool>? currentTimeToTake,
    List<bool>? currentMealTime,
    List<String>? availableMedicines,
  });
}

final class PrescriptionMedicalInitial extends PrescriptionState {
  const PrescriptionMedicalInitial({
    required super.customerName,
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
    required super.medicines,
    required super.currentMedicineName,
    required super.currentDuration,
    required super.currentDose,
    required super.currentTimeToTake,
    required super.currentMealTime,
    required super.availableMedicines,
  });

  const PrescriptionMedicalInitial.empty()
      : super(
          customerName: '',
          heartRate: '',
          bloodPressure: '',
          choresterol: '',
          bloodSugar: '',
          doctorNote: const ['', ''],
          medicines: const {},
          currentMedicineName: '',
          currentDuration: '',
          currentDose: '',
          currentTimeToTake: const [false, false, false, false],
          currentMealTime: const [false, false],
          availableMedicines: const [],
        );

  factory PrescriptionMedicalInitial.from(PrescriptionState state) =>
      PrescriptionMedicalInitial(
        customerName: state.customerName,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
        medicines: state.medicines,
        currentMedicineName: state.currentMedicineName,
        currentDuration: state.currentDuration,
        currentDose: state.currentDose,
        currentTimeToTake: state.currentTimeToTake,
        currentMealTime: state.currentMealTime,
        availableMedicines: state.availableMedicines,
      );

  const PrescriptionMedicalInitial.input({
    required super.customerName,
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
    required super.medicines,
    required super.currentMedicineName,
    required super.currentDuration,
    required super.currentDose,
    required super.currentTimeToTake,
    required super.currentMealTime,
    required super.availableMedicines,
  });

  @override
  PrescriptionState copyWith({
    String? customerName,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    List<String>? doctorNote,
    Map<String, List<String>>? medicines,
    String? currentMedicineName,
    String? currentDuration,
    String? currentDose,
    List<bool>? currentTimeToTake,
    List<bool>? currentMealTime,
    List<String>? availableMedicines,
  }) {
    return PrescriptionMedicalInitial.input(
      customerName: customerName ?? super.customerName,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
      medicines: medicines ?? super.medicines,
      currentMedicineName: currentMedicineName ?? super.currentMedicineName,
      currentDuration: currentDuration ?? super.currentDuration,
      currentDose: currentDose ?? super.currentDose,
      currentTimeToTake: currentTimeToTake ?? super.currentTimeToTake,
      currentMealTime: currentMealTime ?? super.currentMealTime,
      availableMedicines: availableMedicines ?? super.availableMedicines,
    );
  }
}

final class PrescriptionMedicalLoading extends PrescriptionState {
  const PrescriptionMedicalLoading({
    required super.customerName,
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
    required super.medicines,
    required super.currentMedicineName,
    required super.currentDuration,
    required super.currentDose,
    required super.currentTimeToTake,
    required super.currentMealTime,
    required super.availableMedicines,
  });

  factory PrescriptionMedicalLoading.from(PrescriptionState state) =>
      PrescriptionMedicalLoading(
        customerName: state.customerName,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
        medicines: state.medicines,
        currentMedicineName: state.currentMedicineName,
        currentDuration: state.currentDuration,
        currentDose: state.currentDose,
        currentTimeToTake: state.currentTimeToTake,
        currentMealTime: state.currentMealTime,
        availableMedicines: state.availableMedicines,
      );

  PrescriptionState toggleBackToInitial() => PrescriptionMedicalInitial.input(
        customerName: customerName,
        heartRate: heartRate,
        bloodPressure: bloodPressure,
        choresterol: choresterol,
        bloodSugar: bloodSugar,
        doctorNote: doctorNote,
        medicines: medicines,
        currentMedicineName: currentMedicineName,
        currentDuration: currentDuration,
        currentDose: currentDose,
        currentTimeToTake: currentTimeToTake,
        currentMealTime: currentMealTime,
        availableMedicines: availableMedicines,
      );

  @override
  PrescriptionState copyWith({
    String? customerName,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    List<String>? doctorNote,
    Map<String, List<String>>? medicines,
    String? currentMedicineName,
    String? currentDuration,
    String? currentDose,
    List<bool>? currentTimeToTake,
    List<bool>? currentMealTime,
    List<String>? availableMedicines,
  }) {
    return PrescriptionMedicalLoading(
      customerName: customerName ?? super.customerName,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
      medicines: medicines ?? super.medicines,
      currentMedicineName: currentMedicineName ?? super.currentMedicineName,
      currentDuration: currentDuration ?? super.currentDuration,
      currentDose: currentDose ?? super.currentDose,
      currentTimeToTake: currentTimeToTake ?? super.currentTimeToTake,
      currentMealTime: currentMealTime ?? super.currentMealTime,
      availableMedicines: availableMedicines ?? super.availableMedicines,
    );
  }
}

final class PrescriptionMedicalSuccess extends PrescriptionState {
  const PrescriptionMedicalSuccess({
    required super.customerName,
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
    required super.medicines,
    required super.currentMedicineName,
    required super.currentDuration,
    required super.currentDose,
    required super.currentTimeToTake,
    required super.currentMealTime,
    required super.availableMedicines,
  });

  factory PrescriptionMedicalSuccess.from(PrescriptionState state) =>
      PrescriptionMedicalSuccess(
        customerName: state.customerName,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
        medicines: state.medicines,
        currentMedicineName: state.currentMedicineName,
        currentDuration: state.currentDuration,
        currentDose: state.currentDose,
        currentTimeToTake: state.currentTimeToTake,
        currentMealTime: state.currentMealTime,
        availableMedicines: state.availableMedicines,
      );

  @override
  PrescriptionState copyWith({
    String? customerName,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    List<String>? doctorNote,
    Map<String, List<String>>? medicines,
    String? currentMedicineName,
    String? currentDuration,
    String? currentDose,
    List<bool>? currentTimeToTake,
    List<bool>? currentMealTime,
    List<String>? availableMedicines,
  }) {
    return PrescriptionMedicalSuccess(
      customerName: customerName ?? super.customerName,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
      medicines: medicines ?? super.medicines,
      currentMedicineName: currentMedicineName ?? super.currentMedicineName,
      currentDuration: currentDuration ?? super.currentDuration,
      currentDose: currentDose ?? super.currentDose,
      currentTimeToTake: currentTimeToTake ?? super.currentTimeToTake,
      currentMealTime: currentMealTime ?? super.currentMealTime,
      availableMedicines: availableMedicines ?? super.availableMedicines,
    );
  }
}

final class PrescriptionAddMedicine extends PrescriptionState {
  const PrescriptionAddMedicine({
    required super.customerName,
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
    required super.medicines,
    required super.currentMedicineName,
    required super.currentDuration,
    required super.currentDose,
    required super.currentTimeToTake,
    required super.currentMealTime,
    required super.availableMedicines,
  });

  factory PrescriptionAddMedicine.from(PrescriptionState state) =>
      PrescriptionAddMedicine(
        customerName: state.customerName,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
        medicines: state.medicines,
        currentMedicineName: state.currentMedicineName,
        currentDuration: state.currentDuration,
        currentDose: state.currentDose,
        currentTimeToTake: state.currentTimeToTake,
        currentMealTime: state.currentMealTime,
        availableMedicines: state.availableMedicines,
      );

  @override
  PrescriptionState copyWith({
    String? customerName,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    List<String>? doctorNote,
    Map<String, List<String>>? medicines,
    String? currentMedicineName,
    String? currentDuration,
    String? currentDose,
    List<bool>? currentTimeToTake,
    List<bool>? currentMealTime,
    List<String>? availableMedicines,
  }) {
    return PrescriptionAddMedicine(
      customerName: customerName ?? super.customerName,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
      medicines: medicines ?? super.medicines,
      currentMedicineName: currentMedicineName ?? super.currentMedicineName,
      currentDuration: currentDuration ?? super.currentDuration,
      currentDose: currentDose ?? super.currentDose,
      currentTimeToTake: currentTimeToTake ?? super.currentTimeToTake,
      currentMealTime: currentMealTime ?? super.currentMealTime,
      availableMedicines: availableMedicines ?? super.availableMedicines,
    );
  }
}

final class PrescriptionSuccess extends PrescriptionState {
  const PrescriptionSuccess({
    required super.customerName,
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
    required super.medicines,
    required super.currentMedicineName,
    required super.currentDuration,
    required super.currentDose,
    required super.currentTimeToTake,
    required super.currentMealTime,
    required super.availableMedicines,
  });

  factory PrescriptionSuccess.from(PrescriptionState state) =>
      PrescriptionSuccess(
        customerName: state.customerName,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
        medicines: state.medicines,
        currentMedicineName: state.currentMedicineName,
        currentDuration: state.currentDuration,
        currentDose: state.currentDose,
        currentTimeToTake: state.currentTimeToTake,
        currentMealTime: state.currentMealTime,
        availableMedicines: state.availableMedicines,
      );

  @override
  PrescriptionState copyWith({
    String? customerName,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    List<String>? doctorNote,
    Map<String, List<String>>? medicines,
    String? currentMedicineName,
    String? currentDuration,
    String? currentDose,
    List<bool>? currentTimeToTake,
    List<bool>? currentMealTime,
    List<String>? availableMedicines,
  }) {
    return PrescriptionSuccess(
      customerName: customerName ?? super.customerName,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
      medicines: medicines ?? super.medicines,
      currentMedicineName: currentMedicineName ?? super.currentMedicineName,
      currentDuration: currentDuration ?? super.currentDuration,
      currentDose: currentDose ?? super.currentDose,
      currentTimeToTake: currentTimeToTake ?? super.currentTimeToTake,
      currentMealTime: currentMealTime ?? super.currentMealTime,
      availableMedicines: availableMedicines ?? super.availableMedicines,
    );
  }
}

final class PrescriptionMedicineLoading extends PrescriptionState {
  const PrescriptionMedicineLoading({
    required super.customerName,
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
    required super.medicines,
    required super.currentMedicineName,
    required super.currentDuration,
    required super.currentDose,
    required super.currentTimeToTake,
    required super.currentMealTime,
    required super.availableMedicines,
  });

  factory PrescriptionMedicineLoading.from(PrescriptionState state) =>
      PrescriptionMedicineLoading(
        customerName: state.customerName,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
        medicines: state.medicines,
        currentMedicineName: state.currentMedicineName,
        currentDuration: state.currentDuration,
        currentDose: state.currentDose,
        currentTimeToTake: state.currentTimeToTake,
        currentMealTime: state.currentMealTime,
        availableMedicines: state.availableMedicines,
      );

  @override
  PrescriptionState copyWith({
    String? customerName,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    List<String>? doctorNote,
    Map<String, List<String>>? medicines,
    String? currentMedicineName,
    String? currentDuration,
    String? currentDose,
    List<bool>? currentTimeToTake,
    List<bool>? currentMealTime,
    List<String>? availableMedicines,
  }) {
    return PrescriptionMedicineLoading(
      customerName: customerName ?? super.customerName,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
      medicines: medicines ?? super.medicines,
      currentMedicineName: currentMedicineName ?? super.currentMedicineName,
      currentDuration: currentDuration ?? super.currentDuration,
      currentDose: currentDose ?? super.currentDose,
      currentTimeToTake: currentTimeToTake ?? super.currentTimeToTake,
      currentMealTime: currentMealTime ?? super.currentMealTime,
      availableMedicines: availableMedicines ?? super.availableMedicines,
    );
  }
}
