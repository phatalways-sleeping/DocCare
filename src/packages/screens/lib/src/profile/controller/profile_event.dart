part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends ProfileEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class EmailInputEvent extends ProfileEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class BirthdayInputEvent extends ProfileEvent {
  const BirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class PhoneNumberInputEvent extends ProfileEvent {
  const PhoneNumberInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class InitialEvent extends ProfileEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

final class SpecializationInputEvent extends ProfileEvent {
  const SpecializationInputEvent(this.specializationId);

  final String specializationId;

  @override
  List<Object> get props => [specializationId];
}

final class StartingYearInputEvent extends ProfileEvent {
  const StartingYearInputEvent(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object> get props => [startWorkingFrom];
}

final class ValidateBirthdayInputEvent extends ProfileEvent {
  const ValidateBirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class ChangePasswordButtonPressedEvent extends ProfileEvent {
  const ChangePasswordButtonPressedEvent();
}
