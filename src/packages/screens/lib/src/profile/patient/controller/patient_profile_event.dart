part of 'patient_profile_bloc.dart';

@immutable
sealed class PatientProfileEvent extends Equatable {
  const PatientProfileEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends PatientProfileEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class ConfirmButtonPressedEvent extends PatientProfileEvent {
  const ConfirmButtonPressedEvent();

  @override
  List<Object> get props => [];
}

final class CancelButtonPressedEvent extends PatientProfileEvent {
  const CancelButtonPressedEvent();

  @override
  List<Object> get props => [];
}

final class EmailInputEvent extends PatientProfileEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class BirthdayInputEvent extends PatientProfileEvent {
  const BirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class PhoneNumberInputEvent extends PatientProfileEvent {
  const PhoneNumberInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class InitialEvent extends PatientProfileEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

final class SpecializationInputEvent extends PatientProfileEvent {
  const SpecializationInputEvent(this.specializationId);

  final String specializationId;

  @override
  List<Object> get props => [specializationId];
}

final class StartingYearInputEvent extends PatientProfileEvent {
  const StartingYearInputEvent(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object> get props => [startWorkingFrom];
}

final class ValidateBirthdayInputEvent extends PatientProfileEvent {
  const ValidateBirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class ChangePasswordButtonPressedEvent extends PatientProfileEvent {
  const ChangePasswordButtonPressedEvent();
}
