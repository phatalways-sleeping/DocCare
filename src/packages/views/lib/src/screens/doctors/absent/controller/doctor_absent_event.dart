// ignore_for_file: avoid_positional_boolean_parameters, public_member_api_docs

part of 'doctor_absent_bloc.dart';

@immutable
sealed class DoctorAbsentEvent extends Equatable {
  const DoctorAbsentEvent();

  @override
  List<Object?> get props => [];
}

final class DoctorAbsentResetEvent extends DoctorAbsentEvent {
  const DoctorAbsentResetEvent();
}

final class DoctorAbsentButtonPressedEvent extends DoctorAbsentEvent {
  const DoctorAbsentButtonPressedEvent();
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
