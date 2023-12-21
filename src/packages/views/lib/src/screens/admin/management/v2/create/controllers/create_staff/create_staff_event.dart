// ignore_for_file: public_member_api_docs

part of 'create_staff_bloc.dart';

@immutable
sealed class CreateStaffEvent extends Equatable {
  const CreateStaffEvent();

  @override
  List<Object> get props => [];
}

final class CreateStaffResetEvent extends CreateStaffEvent {
  const CreateStaffResetEvent();
}

final class CreateStaffSubmitEvent extends CreateStaffEvent {
  const CreateStaffSubmitEvent();
}

final class CreateStaffNameChangedEvent extends CreateStaffEvent {
  const CreateStaffNameChangedEvent(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

final class CreateStaffEmailChangedEvent extends CreateStaffEvent {
  const CreateStaffEmailChangedEvent(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class CreateStaffPasswordChangedEvent extends CreateStaffEvent {
  const CreateStaffPasswordChangedEvent(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

final class CreateStaffBirthdateChangedEvent extends CreateStaffEvent {
  const CreateStaffBirthdateChangedEvent(this.birthdate);

  final String birthdate;

  @override
  List<Object> get props => [birthdate];
}

final class CreateStaffPhoneNumberChangedEvent extends CreateStaffEvent {
  const CreateStaffPhoneNumberChangedEvent(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

final class CreateStaffRoleChangedEvent extends CreateStaffEvent {
  const CreateStaffRoleChangedEvent(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class CreateStaffSpecializationChangedEvent extends CreateStaffEvent {
  const CreateStaffSpecializationChangedEvent(this.specialization);

  final String specialization;

  @override
  List<Object> get props => [specialization];
}

final class CreateStaffAddNewWorkingShiftEvent extends CreateStaffEvent {
  const CreateStaffAddNewWorkingShiftEvent();
}

final class CreateStaffChangeWeekdayEvent extends CreateStaffEvent {
  const CreateStaffChangeWeekdayEvent(this.index, this.weekDay);

  final int index;
  final String weekDay;

  @override
  List<Object> get props => [index, weekDay];
}

final class CreateStaffChangeStartPeriodEvent extends CreateStaffEvent {
  const CreateStaffChangeStartPeriodEvent(this.index, this.startPeriod);

  final int index;
  final String startPeriod;

  @override
  List<Object> get props => [index, startPeriod];
}

final class CreateStaffChangeEndPeriodEvent extends CreateStaffEvent {
  const CreateStaffChangeEndPeriodEvent(this.index, this.endPeriod);

  final int index;
  final String endPeriod;

  @override
  List<Object> get props => [index, endPeriod];
}

final class CreateStaffRemoveWorkingShiftEvent extends CreateStaffEvent {
  const CreateStaffRemoveWorkingShiftEvent(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}


