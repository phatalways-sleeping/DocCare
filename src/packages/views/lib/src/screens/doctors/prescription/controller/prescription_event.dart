// ignore_for_file: public_member_api_docs

part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionEvent extends Equatable {
  const PrescriptionEvent();

  @override
  List<Object> get props => [];
}

final class InitializeCustomerNameEvent extends PrescriptionEvent {
  const InitializeCustomerNameEvent(this.customerName);

  final String customerName;

  @override
  List<Object> get props => [customerName];
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

final class NextButtonPressedEvent extends PrescriptionEvent {
  const NextButtonPressedEvent();
}

final class DoctorNoteMedicineInputEvent extends PrescriptionEvent {
  const DoctorNoteMedicineInputEvent(this.doctorNote);

  final String doctorNote;

  @override
  List<Object> get props => [doctorNote];
}

final class AddMedicineButtonPressedEvent extends PrescriptionEvent {
  const AddMedicineButtonPressedEvent();
}

final class MedicineNameInputEvent extends PrescriptionEvent {
  const MedicineNameInputEvent(this.currentMedicineName);

  final String currentMedicineName;

  @override
  List<Object> get props => [currentMedicineName];
}

final class MedicineDurationInputEvent extends PrescriptionEvent {
  const MedicineDurationInputEvent(this.currentDuration);

  final String currentDuration;

  @override
  List<Object> get props => [currentDuration];
}

final class MedicineDoseInputEvent extends PrescriptionEvent {
  const MedicineDoseInputEvent(this.currentDose);

  final String currentDose;

  @override
  List<Object> get props => [currentDose];
}

final class MedicineTimeTakenInputEvent extends PrescriptionEvent {
  const MedicineTimeTakenInputEvent(this.currentTimeTaken);

  final int currentTimeTaken;

  @override
  List<Object> get props => [currentTimeTaken];
}

final class MedicineMealTimeInputEvent extends PrescriptionEvent {
  const MedicineMealTimeInputEvent(this.currentMealTime);

  final int currentMealTime;

  @override
  List<Object> get props => [currentMealTime];
}

final class AddIntakeButtonPressedEvent extends PrescriptionEvent {
  const AddIntakeButtonPressedEvent();
}

final class RemoveMedicineButtonPressedEvent extends PrescriptionEvent {
  const RemoveMedicineButtonPressedEvent(this.medicineName);

  final String medicineName;

  @override
  List<Object> get props => [medicineName];
}

final class AddPrescriptionButtonPressedEvent extends PrescriptionEvent {
  const AddPrescriptionButtonPressedEvent();
}

final class PrescriptionBackEvent extends PrescriptionEvent {
  const PrescriptionBackEvent();
}

final class RetrieveMedicineEvent extends PrescriptionEvent {
  const RetrieveMedicineEvent();
}
