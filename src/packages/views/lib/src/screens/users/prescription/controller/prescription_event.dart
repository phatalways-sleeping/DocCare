// ignore_for_file: public_member_api_docs

part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionEvent extends Equatable {
  const PrescriptionEvent();

  @override
  List<Object?> get props => [];
}

final class PrescriptionResetEvent extends PrescriptionEvent {
  const PrescriptionResetEvent();

  @override
  List<Object?> get props => [];
}

final class PrescriptionCheckEvent extends PrescriptionEvent {
  const PrescriptionCheckEvent({
    required this.prescriptionId,
    required this.done,
  });

  final String prescriptionId;
  final bool done;

  @override
  List<Object?> get props => [prescriptionId, done];
}

final class PrescriptionEmptyEvent extends PrescriptionEvent {
  const PrescriptionEmptyEvent();

  @override
  List<Object?> get props => [];
}

final class PrescriptionOpenMedicinesViewEvent extends PrescriptionEvent {
  const PrescriptionOpenMedicinesViewEvent({
    required this.prescriptionId,
  });

  final String prescriptionId;

  @override
  List<Object?> get props => [prescriptionId];
}

final class MedicineCheckEvent extends PrescriptionEvent {
  const MedicineCheckEvent({
    required this.prescriptionId,
    required this.medicineName,
    required this.done,
  });

  final String medicineName;
  final String prescriptionId;
  final bool done;

  @override
  List<Object?> get props =>
      [medicineName, prescriptionId, done, prescriptionId];
}

final class OpenIntakeViewEvent extends PrescriptionEvent {
  const OpenIntakeViewEvent({
    required this.prescriptionId,
  });
  final String prescriptionId;

  @override
  List<Object?> get props => [prescriptionId];
}

final class IntakeRatingEvent extends PrescriptionEvent {
  const IntakeRatingEvent({
    required this.prescriptionId,
    required this.rating,
  });

  final int rating;
  final String prescriptionId;

  @override
  List<Object?> get props => [rating, prescriptionId];
}
