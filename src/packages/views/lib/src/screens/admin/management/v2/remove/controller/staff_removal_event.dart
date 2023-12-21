// ignore_for_file: public_member_api_docs

part of 'staff_removal_bloc.dart';

@immutable
sealed class StaffRemovalEvent extends Equatable {
  const StaffRemovalEvent();

  @override
  List<Object> get props => [];
}

final class StaffRemovalResetEvent extends StaffRemovalEvent {
  const StaffRemovalResetEvent();
}

final class StaffRemovalRoleChangedEvent extends StaffRemovalEvent {
  const StaffRemovalRoleChangedEvent({
    required this.role,
  });

  final String role;

  @override
  List<Object> get props => [role];
}

final class StaffRemovalEmailChangedEvent extends StaffRemovalEvent {
  const StaffRemovalEmailChangedEvent({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

final class StaffRemovalSubmitEvent extends StaffRemovalEvent {
  const StaffRemovalSubmitEvent();
}
