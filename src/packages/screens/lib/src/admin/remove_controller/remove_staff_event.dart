// ignore_for_file: public_member_api_docs

part of 'remove_staff_bloc.dart';

@immutable
sealed class RemoveStaffEvent extends Equatable {
  const RemoveStaffEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends RemoveStaffEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class EmailInputEvent extends RemoveStaffEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordInputEvent extends RemoveStaffEvent {
  const PasswordInputEvent(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class BirthdayInputEvent extends RemoveStaffEvent {
  const BirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class RoleInputEvent extends RemoveStaffEvent {
  const RoleInputEvent(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class PhoneInputEvent extends RemoveStaffEvent {
  const PhoneInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class SpecializationIdInputEvent extends RemoveStaffEvent {
  const SpecializationIdInputEvent(this.specializationId);

  final String specializationId;

  @override
  List<Object> get props => [specializationId];
}

final class StartWorkingFromInputEvent extends RemoveStaffEvent {
  const StartWorkingFromInputEvent(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object> get props => [startWorkingFrom];
}

final class RatingInputEvent extends RemoveStaffEvent {
  const RatingInputEvent(this.rating);

  final double rating;

  @override
  List<Object> get props => [rating];
}

final class NumberOfRatesInputEvent extends RemoveStaffEvent {
  const NumberOfRatesInputEvent(this.numberOfRates);

  final int numberOfRates;

  @override
  List<Object> get props => [numberOfRates];
}

final class DayOfWeekInputEvent extends RemoveStaffEvent {
  const DayOfWeekInputEvent(this.dayOfWeek);

  final Map<String, List<int>> dayOfWeek;

  @override
  List<Object> get props => [dayOfWeek];
}

final class RemoveStaffButtonPressedEvent extends RemoveStaffEvent {
  const RemoveStaffButtonPressedEvent();
}

final class NextButtonPressedEvent extends RemoveStaffEvent {
  const NextButtonPressedEvent();
}

final class NextButton1PressedEvent extends RemoveStaffEvent {
  const NextButton1PressedEvent();
}

final class AddMoreButtonPressedEvent extends RemoveStaffEvent {
  const AddMoreButtonPressedEvent();
}

final class ValidateBirthdayInputEvent extends RemoveStaffEvent {
  const ValidateBirthdayInputEvent(this.tempBirthday);

  final String tempBirthday;

  @override
  List<Object> get props => [tempBirthday];
}

final class WorkingShiftInputEvent extends RemoveStaffEvent {
  const WorkingShiftInputEvent(this.dayOfWeek);

  final Map<String, List<int>> dayOfWeek;

  @override
  List<Object> get props => [dayOfWeek];
}
