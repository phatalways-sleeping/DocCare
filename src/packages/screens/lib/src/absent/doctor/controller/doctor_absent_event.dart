part of 'doctor_absent_bloc.dart';

@immutable
sealed class DoctorAbsentEvent extends Equatable {
  const DoctorAbsentEvent();
}

final class DoctorAbsentButtonPressedEvent extends DoctorAbsentEvent {
  const DoctorAbsentButtonPressedEvent();

  @override
  List<Object?> get props => [];
}

final class DoctorAbsentDateInputEvent extends DoctorAbsentEvent {
  const DoctorAbsentDateInputEvent(this.date);

  final String date;

  @override
  List<Object?> get props => [date];
}

final class DoctorAbsentDescriptionInputEvent extends DoctorAbsentEvent {
  const DoctorAbsentDescriptionInputEvent(this.reasons);

  final String reasons;

  @override
  List<Object?> get props => [reasons];
}

final class DoctorAbsentAgreementCheckboxEvent extends DoctorAbsentEvent {
  const DoctorAbsentAgreementCheckboxEvent(this.agreed);

  final bool agreed;

  @override
  List<Object?> get props => [agreed];
}

final class DoctorAbsentArrangeAnotherDoctorEvent extends DoctorAbsentEvent {
  const DoctorAbsentArrangeAnotherDoctorEvent(this.arrangeAnotherDoctor);

  final bool arrangeAnotherDoctor;

  @override
  List<Object?> get props => [arrangeAnotherDoctor];
}