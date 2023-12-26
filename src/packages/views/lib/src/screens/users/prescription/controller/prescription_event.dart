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
  });

  final String prescriptionId;

  @override
  List<Object?> get props => [prescriptionId];
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
    required this.medineName,
  });

  final String medineName;

  @override
  List<Object?> get props => [medineName];
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
