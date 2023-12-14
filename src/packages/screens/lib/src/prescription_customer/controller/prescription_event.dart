part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionEvent extends Equatable {
  const PrescriptionEvent();

  @override
  List<Object?> get props => [];
}

final class PrescriptionInitialEvent extends PrescriptionEvent {
  const PrescriptionInitialEvent();

  @override
  List<Object?> get props => [];
}

final class PrescriptionTapEvent extends PrescriptionEvent {
  const PrescriptionTapEvent();

  @override
  List<Object?> get props => [];
}
