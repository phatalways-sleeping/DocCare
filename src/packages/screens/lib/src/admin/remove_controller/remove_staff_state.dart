// ignore_for_file: public_member_api_docs, non_constant_identifier_names, prefer_int_literals, lines_longer_than_80_chars

part of 'remove_staff_bloc.dart';

@immutable
sealed class RemoveStaffState extends Equatable {
  const RemoveStaffState({
    required this.email,
    this.role = 'Doctor',
    required this.allReceptionistEmail,
    required this.allDoctorEmail,
    required this.selectedEmails,
  });
  final String email;

  final String role;

  final List<String> allReceptionistEmail;

  final List<String> allDoctorEmail;

  final List<String> selectedEmails;

  @override
  List<Object> get props => [
        email,
        role,
        allReceptionistEmail,
        allDoctorEmail,
        selectedEmails,
      ];

  RemoveStaffState copyWith({
    String? email,
    String? role,
    List<String>? allReceptionistEmail,
    List<String>? allDoctorEmail,
    List<String>? selectedEmails,
  });
}

final class RemoveStaffInitial extends RemoveStaffState {
  const RemoveStaffInitial({
    required super.email,
    required super.role,
    required super.allReceptionistEmail,
    required super.allDoctorEmail,
    required super.selectedEmails,
  });
  RemoveStaffInitial.empty()
      : super(
          email: '',
          role: '',
          allReceptionistEmail: [],
          allDoctorEmail: [],
          selectedEmails: [],
        );

  const RemoveStaffInitial.input({
    required super.email,
    required super.role,
    required super.allReceptionistEmail,
    required super.allDoctorEmail,
    required super.selectedEmails,
  });

  factory RemoveStaffInitial.from(RemoveStaffState state) => RemoveStaffInitial(
        email: state.email,
        role: state.role,
        allReceptionistEmail: state.allReceptionistEmail,
        allDoctorEmail: state.allDoctorEmail,
        selectedEmails: state.selectedEmails,
      );

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
    List<String>? allReceptionistEmail,
    List<String>? allDoctorEmail,
    List<String>? selectedEmails,
  }) =>
      RemoveStaffInitial.input(
        email: email ?? super.email,
        role: role ?? super.role,
        allReceptionistEmail:
            allReceptionistEmail ?? super.allReceptionistEmail,
        allDoctorEmail: allDoctorEmail ?? super.allDoctorEmail,
        selectedEmails: selectedEmails ?? super.selectedEmails,
      );
}

final class RemoveStaffLoading extends RemoveStaffState {
  RemoveStaffLoading.empty()
      : super(
          email: '',
          role: 'Doctor',
          allReceptionistEmail: [],
          allDoctorEmail: [],
          selectedEmails: [],
        );
  const RemoveStaffLoading({
    required super.email,
    required super.role,
    required super.allReceptionistEmail,
    required super.allDoctorEmail,
    required super.selectedEmails,
  });

  factory RemoveStaffLoading.from(RemoveStaffState state) => RemoveStaffLoading(
        email: state.email,
        role: state.role,
        allReceptionistEmail: state.allReceptionistEmail,
        allDoctorEmail: state.allDoctorEmail,
        selectedEmails: state.selectedEmails,
      );

  RemoveStaffState toggleBackToInitial() => RemoveStaffInitial.input(
        email: email,
        role: role,
        allReceptionistEmail: allReceptionistEmail,
        allDoctorEmail: allDoctorEmail,
        selectedEmails: selectedEmails,
      );

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
    List<String>? allReceptionistEmail,
    List<String>? allDoctorEmail,
    List<String>? selectedEmails,
  }) =>
      RemoveStaffLoading(
        email: email ?? super.email,
        role: role ?? super.role,
        allReceptionistEmail:
            allReceptionistEmail ?? super.allReceptionistEmail,
        allDoctorEmail: allDoctorEmail ?? super.allDoctorEmail,
        selectedEmails: selectedEmails ?? super.selectedEmails,
      );
}

final class RemoveStaffSuccess extends RemoveStaffState {
  const RemoveStaffSuccess({
    required super.email,
    required super.role,
    required super.allReceptionistEmail,
    required super.allDoctorEmail,
    required super.selectedEmails,
  });

  factory RemoveStaffSuccess.from(RemoveStaffState state) => RemoveStaffSuccess(
        email: state.email,
        role: state.role,
        allReceptionistEmail: state.allReceptionistEmail,
        allDoctorEmail: state.allDoctorEmail,
        selectedEmails: state.selectedEmails,
      );

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
    List<String>? allReceptionistEmail,
    List<String>? allDoctorEmail,
    List<String>? selectedEmails,
  }) =>
      RemoveStaffSuccess(
        email: email ?? super.email,
        role: role ?? super.role,
        allReceptionistEmail:
            allReceptionistEmail ?? super.allReceptionistEmail,
        allDoctorEmail: allDoctorEmail ?? super.allDoctorEmail,
        selectedEmails: selectedEmails ?? super.selectedEmails,
      );
}

final class RemoveStaffFailure extends RemoveStaffState {
  const RemoveStaffFailure({
    required super.email,
    required super.role,
    required super.allReceptionistEmail,
    required super.allDoctorEmail,
    required super.selectedEmails,
  });

  factory RemoveStaffFailure.from(RemoveStaffState state, String message) =>
      RemoveStaffFailure(
        email: state.email,
        role: state.role,
        allReceptionistEmail: state.allReceptionistEmail,
        allDoctorEmail: state.allDoctorEmail,
        selectedEmails: state.selectedEmails,
      );

  RemoveStaffState toggleBackToInitial() => RemoveStaffInitial.input(
        email: email,
        role: role,
        allReceptionistEmail: allReceptionistEmail,
        allDoctorEmail: allDoctorEmail,
        selectedEmails: selectedEmails,
      );

  @override
  RemoveStaffState copyWith({
    String? email,
    String? role,
    List<String>? allReceptionistEmail,
    List<String>? allDoctorEmail,
    List<String>? selectedEmails,
  }) =>
      RemoveStaffFailure(
        email: email ?? super.email,
        role: role ?? super.role,
        allReceptionistEmail:
            allReceptionistEmail ?? super.allReceptionistEmail,
        allDoctorEmail: allDoctorEmail ?? super.allDoctorEmail,
        selectedEmails: selectedEmails ?? super.selectedEmails,
      );
}
