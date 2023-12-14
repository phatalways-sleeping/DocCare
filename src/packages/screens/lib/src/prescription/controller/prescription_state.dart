// ignore_for_file: public_member_api_docs

part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionState extends Equatable {
  const PrescriptionState({
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
  });

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

  @override
  List<Object> get props => [
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
      ];

  PrescriptionState copyWith({
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
  });
}

final class PrescriptionMedicalInitial extends PrescriptionState {
  const PrescriptionMedicalInitial.empty()
      : super(
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
        );

  const PrescriptionMedicalInitial.input({
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
  });

  @override
  PrescriptionState copyWith({
    String? name,
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
  }) {
    return PrescriptionMedicalInitial.input(
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
    );
  }
}

final class PrescriptionMedicalLoading extends PrescriptionState {
  const PrescriptionMedicalLoading({
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
  });

  factory PrescriptionMedicalLoading.from(PrescriptionState state) =>
      PrescriptionMedicalLoading(
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
      );

  PrescriptionState toggleBackToInitial() => PrescriptionMedicalInitial.input(
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
      );

  @override
  PrescriptionState copyWith({
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
  }) {
    return PrescriptionMedicalLoading(
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
    );
  }
}

final class PrescriptionMedicalSuccess extends PrescriptionState {
  const PrescriptionMedicalSuccess({
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
  });

  factory PrescriptionMedicalSuccess.from(PrescriptionState state) =>
      PrescriptionMedicalSuccess(
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
      );

  @override
  PrescriptionState copyWith({
    String? name,
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
  }) {
    return PrescriptionMedicalSuccess(
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
    );
  }
}

final class PrescriptionAddMedicine extends PrescriptionState {
  const PrescriptionAddMedicine({
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
  });

  factory PrescriptionAddMedicine.from(PrescriptionState state) =>
      PrescriptionAddMedicine(
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
      );

  @override
  PrescriptionState copyWith({
    String? name,
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
  }) {
    return PrescriptionAddMedicine(
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
    );
  }
}

final class PrescriptionSuccess extends PrescriptionState {
  const PrescriptionSuccess({
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
  });

  factory PrescriptionSuccess.from(PrescriptionState state) =>
      PrescriptionSuccess(
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
      );

  @override
  PrescriptionState copyWith({
    String? name,
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
  }) {
    return PrescriptionSuccess(
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
    );
  }
}
