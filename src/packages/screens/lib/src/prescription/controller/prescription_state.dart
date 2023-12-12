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
  });

  final String heartRate;
  final String bloodPressure;
  final String choresterol;
  final String bloodSugar;
  final String doctorNote;

  @override
  List<Object> get props => [
        heartRate,
        bloodPressure,
        choresterol,
        bloodSugar,
        doctorNote,
      ];

  PrescriptionState copyWith({
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    String? doctorNote,
  });
}

final class PrescriptionMedicalInitial extends PrescriptionState {
  PrescriptionMedicalInitial.empty()
      : super(
          heartRate: '',
          bloodPressure: '',
          choresterol: '',
          bloodSugar: '',
          doctorNote: '',
        );

  const PrescriptionMedicalInitial.input({
    required super.heartRate,
    required super.bloodPressure,
    required super.choresterol,
    required super.bloodSugar,
    required super.doctorNote,
  });

  @override
  PrescriptionState copyWith({
    String? name,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    String? doctorNote,
  }) {
    return PrescriptionMedicalInitial.input(
      heartRate: heartRate ?? this.heartRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      choresterol: choresterol ?? this.choresterol,
      bloodSugar: bloodSugar ?? this.bloodSugar,
      doctorNote: doctorNote ?? this.doctorNote,
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
  });

  factory PrescriptionMedicalLoading.from(PrescriptionState state) =>
      PrescriptionMedicalLoading(
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
      );

  PrescriptionState toggleBackToInitial() => PrescriptionMedicalInitial.input(
        heartRate: heartRate,
        bloodPressure: bloodPressure,
        choresterol: choresterol,
        bloodSugar: bloodSugar,
        doctorNote: doctorNote,
      );

  @override
  PrescriptionState copyWith({
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    String? doctorNote,
  }) {
    return PrescriptionMedicalLoading(
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
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
  });

  factory PrescriptionMedicalSuccess.from(PrescriptionState state) =>
      PrescriptionMedicalSuccess(
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        choresterol: state.choresterol,
        bloodSugar: state.bloodSugar,
        doctorNote: state.doctorNote,
      );

  @override
  PrescriptionState copyWith({
    String? name,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    String? doctorNote,
  }) {
    return PrescriptionMedicalSuccess(
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      choresterol: choresterol ?? super.choresterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      doctorNote: doctorNote ?? super.doctorNote,
    );
  }
}
