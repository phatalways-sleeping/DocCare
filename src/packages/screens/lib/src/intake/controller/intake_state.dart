part of 'intake_bloc.dart';

@immutable
sealed class IntakeState extends Equatable {
  const IntakeState({
    required this.prescriptionID,
    required this.datePrescribed,
    required this.note,
    required this.done,
  });

  final List<String> prescriptionID;
  final List<DateTime> datePrescribed;
  final List<String> note;
  final List<bool> done;

  @override
  List<Object?> get props => [
        prescriptionID,
        datePrescribed,
        note,
        done,
      ];

  IntakeState copyWith({
    List<String>? prescriptionID,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
  });
}

final class IntakeInitial extends IntakeState {
  IntakeInitial.empty()
      : super(
          prescriptionID: [],
          datePrescribed: [],
          note: [],
          done: [],
        );

  const IntakeInitial.input({
    required super.prescriptionID,
    required super.datePrescribed,
    required super.note,
    required super.done,
  });

  @override
  IntakeState copyWith({
    List<String>? prescriptionID,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
  }) =>
      IntakeInitial.input(
        prescriptionID: prescriptionID ?? super.prescriptionID,
        datePrescribed: datePrescribed ?? super.datePrescribed,
        note: note ?? super.note,
        done: done ?? super.done,
      );
}

final class IntakeLoading extends IntakeState {
  const IntakeLoading({
    required super.prescriptionID,
    required super.datePrescribed,
    required super.note,
    required super.done,
  });

  @override
  IntakeState copyWith({
    List<String>? prescriptionID,
    List<DateTime>? datePrescribed,
    List<String>? note,
    List<bool>? done,
  }) =>
      IntakeLoading(
        prescriptionID: prescriptionID ?? super.prescriptionID,
        datePrescribed: datePrescribed ?? super.datePrescribed,
        note: note ?? super.note,
        done: done ?? super.done,
      );
}
