// ignore_for_file: public_member_api_docs

part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionEvent extends Equatable {
  const PrescriptionEvent();

  @override
  List<Object> get props => [];
}

final class HeartRateInputEvent extends PrescriptionEvent {
  const HeartRateInputEvent(this.heartRate);

  final String heartRate;

  @override
  List<Object> get props => [heartRate];
}

final class BloodPressureInputEvent extends PrescriptionEvent {
  const BloodPressureInputEvent(this.bloodPressure);

  final String bloodPressure;

  @override
  List<Object> get props => [bloodPressure];
}

final class ChoresterolInputEvent extends PrescriptionEvent {
  const ChoresterolInputEvent(this.choresterol);

  final String choresterol;

  @override
  List<Object> get props => [choresterol];
}

final class BloodSugarInputEvent extends PrescriptionEvent {
  const BloodSugarInputEvent(this.bloodSugar);

  final String bloodSugar;

  @override
  List<Object> get props => [bloodSugar];
}

final class DoctorNoteInputEvent extends PrescriptionEvent {
  const DoctorNoteInputEvent(this.doctorNote);

  final String doctorNote;

  @override
  List<Object> get props => [doctorNote];
}
