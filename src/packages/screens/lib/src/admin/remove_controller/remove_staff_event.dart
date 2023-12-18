// ignore_for_file: public_member_api_docs

part of 'remove_staff_bloc.dart';

@immutable
sealed class RemoveStaffEvent extends Equatable {
  const RemoveStaffEvent();

  @override
  List<Object> get props => [];
}

final class EmailInputEvent extends RemoveStaffEvent {
  const EmailInputEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class RoleInputEvent extends RemoveStaffEvent {
  const RoleInputEvent(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class RemoveStaffLoadingEvent extends RemoveStaffEvent {
  const RemoveStaffLoadingEvent();

  @override
  List<Object> get props => [];
}

final class RemoveStaffButtonPressedEvent extends RemoveStaffEvent {
  const RemoveStaffButtonPressedEvent();
}

final class SelectEmailEvent extends RemoveStaffEvent {
  const SelectEmailEvent(this.selectedEmails);

  final String selectedEmails;

  @override
  List<Object> get props => [selectedEmails];
}
