part of 'doctor_profile_bloc.dart';

@immutable
sealed class DoctorProfileEvent extends Equatable {
  const DoctorProfileEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends DoctorProfileEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class ConfirmButtonPressedEvent extends DoctorProfileEvent {
  const ConfirmButtonPressedEvent();

  @override
  List<Object> get props => [];
}

final class CancelButtonPressedEvent extends DoctorProfileEvent {
  const CancelButtonPressedEvent();

  @override
  List<Object> get props => [];
}

final class EmailInputEvent extends DoctorProfileEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class BirthdayInputEvent extends DoctorProfileEvent {
  const BirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class PhoneNumberInputEvent extends DoctorProfileEvent {
  const PhoneNumberInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class InitialEvent extends DoctorProfileEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

final class SpecializationInputEvent extends DoctorProfileEvent {
  const SpecializationInputEvent(this.specializationId);

  final String specializationId;

  @override
  List<Object> get props => [specializationId];
}

final class StartingYearInputEvent extends DoctorProfileEvent {
  const StartingYearInputEvent(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object> get props => [startWorkingFrom];
}

final class ValidateBirthdayInputEvent extends DoctorProfileEvent {
  const ValidateBirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class ChangePasswordButtonPressedEvent extends DoctorProfileEvent {
  const ChangePasswordButtonPressedEvent();
}
