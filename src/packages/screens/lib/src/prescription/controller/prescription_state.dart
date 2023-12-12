// ignore_for_file: public_member_api_docs

part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionState extends Equatable {
  const PrescriptionState({
    required this.name,
    required this.heartRate,
    required this.bloodPressure,
    required this.choresterol,
    required this.bloodSugar,
    required this.doctorNote,
  });

  final String name;
  final String heartRate;
  final String bloodPressure;
  final String choresterol;
  final String bloodSugar;
  final String doctorNote;

  @override
  List<Object> get props => [
        name,
        heartRate,
        bloodPressure,
        choresterol,
        bloodSugar,
        doctorNote,
      ];

  PrescriptionState copyWith({
    String? name,
    String? heartRate,
    String? bloodPressure,
    String? choresterol,
    String? bloodSugar,
    String? doctorNote,
  });
}

final class PrescriptionMedicalInitial extends PrescriptionState {
  const PrescriptionMedicalInitial.empty()
      : super(
          name: '',
          heartRate: '',
          bloodPressure: '',
          choresterol: '',
          bloodSugar: '',
          doctorNote: '',
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
    return const PrescriptionMedicalInitial.empty();
  }
}

final class PrescriptionMedicalLoading extends PrescriptionState {
  const PrescriptionMedicalLoading({
    required super.name,
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
    return PrescriptionMedicalLoading(
      name: name ?? this.name,
      heartRate: heartRate ?? this.heartRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      choresterol: choresterol ?? this.choresterol,
      bloodSugar: bloodSugar ?? this.bloodSugar,
      doctorNote: doctorNote ?? this.doctorNote,
    );
  }
}

final class PrescriptionMedicalSuccess extends PrescriptionState {
  const PrescriptionMedicalSuccess({
    required super.name,
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
    return PrescriptionMedicalSuccess(
      name: name ?? this.name,
      heartRate: heartRate ?? this.heartRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      choresterol: choresterol ?? this.choresterol,
      bloodSugar: bloodSugar ?? this.bloodSugar,
      doctorNote: doctorNote ?? this.doctorNote,
    );
  }
}
