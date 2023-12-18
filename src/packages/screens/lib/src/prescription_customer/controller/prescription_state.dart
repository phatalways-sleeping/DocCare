part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionState extends Equatable {
  const PrescriptionState({
    required this.prescriptionID,
    required this.doctorName,
    required this.datePrescribed,
    required this.note,
    required this.done,
    required this.diagnosis,
  });

  final List<String> prescriptionID;
  final List<String> doctorName;
  final List<DateTime> datePrescribed;
  final List<String> note;
  final List<bool> done;
  final List<String?> diagnosis;

  @override
  List<Object?> get props => [
        prescriptionID,
        doctorName,
        datePrescribed,
        note,
        done,
        diagnosis,
      ];

  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
    List<String?>? diagnosis,
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
          diagnosis: [],
        );

  const PrescriptionInitial.input({
    required super.prescriptionID,
    required super.doctorName,
    required super.datePrescribed,
    required super.note,
    required super.done,
    required super.diagnosis,
  });

  @override
  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
    List<String?>? diagnosis,
  }) =>
      PrescriptionInitial.input(
        prescriptionID: prescriptionID ?? super.prescriptionID,
        doctorName: doctorName ?? super.doctorName,
        datePrescribed: datePrescribed ?? super.datePrescribed,
        note: note ?? super.note,
        done: done ?? super.done,
        diagnosis: diagnosis ?? super.diagnosis,
      );
}

final class PrescriptionLoading extends PrescriptionState {
  const PrescriptionLoading({
    required super.prescriptionID,
    required super.doctorName,
    required super.datePrescribed,
    required super.note,
    required super.done,
    required super.diagnosis,
  });

  @override
  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
    List<String?>? diagnosis,
  }) =>
      PrescriptionLoading(
        prescriptionID: prescriptionID ?? super.prescriptionID,
        doctorName: doctorName ?? super.doctorName,
        datePrescribed: datePrescribed ?? super.datePrescribed,
        note: note ?? super.note,
        done: done ?? super.done,
        diagnosis: diagnosis ?? super.diagnosis,
      );

  PrescriptionInitial toggleBackToInitial() => PrescriptionInitial.input(
        prescriptionID: prescriptionID,
        doctorName: doctorName,
        datePrescribed: datePrescribed,
        note: note,
        done: done,
        diagnosis: diagnosis,
      );
}

final class MedicineInitial extends PrescriptionState {
  const MedicineInitial({
    required super.prescriptionID,
    required super.doctorName,
    required super.datePrescribed,
    required super.note,
    required super.done,
    required super.diagnosis,
    required this.medicineName,
    required this.quantity,
    required this.toBeTaken,
    required this.timeOfTheDay,
    required this.currentPrescriptionID,
    required this.clickedIndex,
  });

  final List<String> medicineName;
  final List<int?> quantity;
  final List<int?> toBeTaken;
  final List<String?> timeOfTheDay;
  final String currentPrescriptionID;
  final int clickedIndex;

  @override
  List<Object?> get props => [
        prescriptionID,
        doctorName,
        datePrescribed,
        note,
        done,
        diagnosis,
        medicineName,
        quantity,
        toBeTaken,
        timeOfTheDay,
        currentPrescriptionID,
        clickedIndex,
      ];

  @override
  PrescriptionState copyWith({
    List<String>? prescriptionID,
    List<String>? doctorName,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
    List<String?>? diagnosis,
  }) {
    return MedicineInitial(
      prescriptionID: prescriptionID ?? super.prescriptionID,
      doctorName: doctorName ?? super.doctorName,
      datePrescribed: datePrescribed ?? super.datePrescribed,
      note: note ?? super.note,
      done: done ?? super.done,
      diagnosis: diagnosis ?? super.diagnosis,
      medicineName: medicineName,
      quantity: quantity,
      toBeTaken: toBeTaken,
      timeOfTheDay: timeOfTheDay,
      currentPrescriptionID: currentPrescriptionID,
      clickedIndex: clickedIndex,
    );
  }
}
