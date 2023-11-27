part of 'receptionist_profile_bloc.dart';

@immutable
sealed class ReceptionistProfileEvent extends Equatable {
  const ReceptionistProfileEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends ReceptionistProfileEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class ConfirmButtonPressedEvent extends ReceptionistProfileEvent {
  const ConfirmButtonPressedEvent();

  @override
  List<Object> get props => [];
}

final class CancelButtonPressedEvent extends ReceptionistProfileEvent {
  const CancelButtonPressedEvent();

  @override
  List<Object> get props => [];
}

final class EmailInputEvent extends ReceptionistProfileEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class BirthdayInputEvent extends ReceptionistProfileEvent {
  const BirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class PhoneNumberInputEvent extends ReceptionistProfileEvent {
  const PhoneNumberInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class InitialEvent extends ReceptionistProfileEvent {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

final class SpecializationInputEvent extends ReceptionistProfileEvent {
  const SpecializationInputEvent(this.specializationId);

  final String specializationId;

  @override
  List<Object> get props => [specializationId];
}

final class StartingYearInputEvent extends ReceptionistProfileEvent {
  const StartingYearInputEvent(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object> get props => [startWorkingFrom];
}

final class ValidateBirthdayInputEvent extends ReceptionistProfileEvent {
  const ValidateBirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class ChangePasswordButtonPressedEvent extends ReceptionistProfileEvent {
  const ChangePasswordButtonPressedEvent();
}
