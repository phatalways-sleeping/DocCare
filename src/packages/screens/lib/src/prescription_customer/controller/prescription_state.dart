part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionState extends Equatable {
  const PrescriptionState({
    required this.prescriptionID,
    required this.doctorName,
    required this.datePrescribed,
    required this.note,
    required this.done,
  });

  final List<String> prescriptionID;
  final List<String> doctorName;
  final List<DateTime> datePrescribed;
  final List<String> note;
  final List<bool> done;

  @override
  List<Object?> get props => [
        prescriptionID,
        doctorName,
        datePrescribed,
        note,
        done,
      ];

  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
  });
}

final class PrescriptionInitial extends PrescriptionState {
  PrescriptionInitial.empty()
      : super(
          prescriptionID: [],
          doctorName: [],
          datePrescribed: [],
          note: [],
          done: [],
        );

  const PrescriptionInitial.input({
    required super.prescriptionID,
    required super.doctorName,
    required super.datePrescribed,
    required super.note,
    required super.done,
  });

  @override
  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
  }) =>
      PrescriptionInitial.input(
        prescriptionID: prescriptionID ?? super.prescriptionID,
        doctorName: doctorName ?? super.doctorName,
        datePrescribed: datePrescribed ?? super.datePrescribed,
        note: note ?? super.note,
        done: done ?? super.done,
      );
}

final class PrescriptionLoading extends PrescriptionState {
  const PrescriptionLoading({
    required super.prescriptionID,
    required super.doctorName,
    required super.datePrescribed,
    required super.note,
    required super.done,
  });

  @override
  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
  }) =>
      PrescriptionLoading(
        prescriptionID: prescriptionID ?? super.prescriptionID,
        doctorName: doctorName ?? super.doctorName,
        datePrescribed: datePrescribed ?? super.datePrescribed,
        note: note ?? super.note,
        done: done ?? super.done,
      );

  PrescriptionInitial toggleBackToInitial() => PrescriptionInitial.input(
        prescriptionID: prescriptionID,
        doctorName: doctorName,
        datePrescribed: datePrescribed,
        note: note,
        done: done,
      );
}

final class MedicineInitial extends PrescriptionState {
  const MedicineInitial({
    required super.prescriptionID,
    required super.doctorName,
    required super.datePrescribed,
    required super.note,
    required super.done,
    required this.medicineName,
    required this.quantity,
    required this.toBeTaken,
    required this.timeOfTheDay,
    required this.currentPrescriptionID,
  });

  final List<String> medicineName;
  final List<int?> quantity;
  final List<int?> toBeTaken;
  final List<String?> timeOfTheDay;
  final String currentPrescriptionID;

  @override
  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
  }) {
    return MedicineInitial(
      prescriptionID: prescriptionID ?? super.prescriptionID,
      doctorName: doctorName ?? super.doctorName,
      datePrescribed: datePrescribed ?? super.datePrescribed,
      note: note ?? super.note,
      done: done ?? super.done,
      medicineName: medicineName,
      quantity: quantity,
      toBeTaken: toBeTaken,
      timeOfTheDay: timeOfTheDay,
      currentPrescriptionID: currentPrescriptionID,
    );
  }
}
