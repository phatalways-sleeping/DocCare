// ignore_for_file: public_member_api_docs

part of 'control_staff_bloc.dart';

@immutable
sealed class ControlStaffEvent extends Equatable {
  const ControlStaffEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends ControlStaffEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class EmailInputEvent extends ControlStaffEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordInputEvent extends ControlStaffEvent {
  const PasswordInputEvent(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class BirthdayInputEvent extends ControlStaffEvent {
  const BirthdayInputEvent(this.birthday);

  final String birthday;

  @override
  List<Object> get props => [birthday];
}

final class RoleInputEvent extends ControlStaffEvent {
  const RoleInputEvent(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class PhoneInputEvent extends ControlStaffEvent {
  const PhoneInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class SpecializationIdInputEvent extends ControlStaffEvent {
  const SpecializationIdInputEvent(this.specializationId);

  final String specializationId;

  @override
  List<Object> get props => [specializationId];
}

final class StartWorkingFromInputEvent extends ControlStaffEvent {
  const StartWorkingFromInputEvent(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object> get props => [startWorkingFrom];
}

final class RatingInputEvent extends ControlStaffEvent {
  const RatingInputEvent(this.rating);

  final double rating;

  @override
  List<Object> get props => [rating];
}

final class NumberOfRatesInputEvent extends ControlStaffEvent {
  const NumberOfRatesInputEvent(this.numberOfRates);

  final int numberOfRates;

  @override
  List<Object> get props => [numberOfRates];
}

final class DayOfWeekInputEvent extends ControlStaffEvent {
  const DayOfWeekInputEvent(this.dayOfWeek);

  final List<String> dayOfWeek;

  @override
  List<Object> get props => [dayOfWeek];
}

final class StartPeriodIDInputEvent extends ControlStaffEvent {
  const StartPeriodIDInputEvent(this.startPeriodID);

  final List<int> startPeriodID;

  @override
  List<Object> get props => [startPeriodID];
}

final class EndPeriodIDInputEvent extends ControlStaffEvent {
  const EndPeriodIDInputEvent(this.endPeriodID);

  final List<int> endPeriodID;

  @override
  List<Object> get props => [endPeriodID];
}

final class ControlStaffButtonPressedEvent extends ControlStaffEvent {
  const ControlStaffButtonPressedEvent();
}

final class NextButtonPressedEvent extends ControlStaffEvent {
  const NextButtonPressedEvent();
}

final class NextButton1PressedEvent extends ControlStaffEvent {
  const NextButton1PressedEvent();
}

final class AddMoreButtonPressedEvent extends ControlStaffEvent {
  const AddMoreButtonPressedEvent();
}
