// ignore_for_file: public_member_api_docs

part of 'create_staff_bloc.dart';

@immutable
sealed class CreateStaffEvent extends Equatable {
  const CreateStaffEvent();

  @override
  List<Object> get props => [];
}

final class FullNameInputEvent extends CreateStaffEvent {
  const FullNameInputEvent(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

final class EmailInputEvent extends CreateStaffEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordInputEvent extends CreateStaffEvent {
  const PasswordInputEvent(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class BirthdayInputEvent extends CreateStaffEvent {
  const BirthdayInputEvent(this.birthday);

  final String birthday;

  @override
  List<Object> get props => [birthday];
}

final class RoleInputEvent extends CreateStaffEvent {
  const RoleInputEvent(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class PhoneInputEvent extends CreateStaffEvent {
  const PhoneInputEvent(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class SpecializationIdInputEvent extends CreateStaffEvent {
  const SpecializationIdInputEvent(this.specializationId);

  final String specializationId;

  @override
  List<Object> get props => [specializationId];
}

final class StartWorkingFromInputEvent extends CreateStaffEvent {
  const StartWorkingFromInputEvent(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object> get props => [startWorkingFrom];
}

final class RatingInputEvent extends CreateStaffEvent {
  const RatingInputEvent(this.rating);

  final double rating;

  @override
  List<Object> get props => [rating];
}

final class NumberOfRatesInputEvent extends CreateStaffEvent {
  const NumberOfRatesInputEvent(this.numberOfRates);

  final int numberOfRates;

  @override
  List<Object> get props => [numberOfRates];
}

final class DayOfWeekInputEvent extends CreateStaffEvent {
  const DayOfWeekInputEvent(this.dayOfWeek);

  final Map<String, List<int>> dayOfWeek;

  @override
  List<Object> get props => [dayOfWeek];
}

final class CreateStaffButtonPressedEvent extends CreateStaffEvent {
  const CreateStaffButtonPressedEvent();
}

final class NextButtonPressedEvent extends CreateStaffEvent {
  const NextButtonPressedEvent();
}

final class NextButton1PressedEvent extends CreateStaffEvent {
  const NextButton1PressedEvent();
}

final class AddMoreButtonPressedEvent extends CreateStaffEvent {
  const AddMoreButtonPressedEvent();
}
