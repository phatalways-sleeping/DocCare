// ignore_for_file: public_member_api_docs, non_constant_identifier_names, prefer_int_literals

part of 'control_staff_bloc.dart';

@immutable
sealed class ControlStaffState extends Equatable {
  const ControlStaffState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.birthday,
    required this.role,
    required this.phone,
    required this.specializationId,
    required this.startWorkingFrom,
    required this.rating,
    required this.numberOfRates,
    required this.dayOfWeek,
    required this.startPeriodID,
    required this.endPeriodID,
  });

  final String fullName;

  final String email;

  final String password;

  final DateTime birthday;

  final String role;

  final String phone;

  final String specializationId;

  final int startWorkingFrom;

  final double rating;

  final int numberOfRates;

  final List<String> dayOfWeek;

  final List<int> startPeriodID;

  final List<int> endPeriodID;
  @override
  List<Object> get props => [
        fullName,
        email,
        password,
        birthday,
        role,
        phone,
        specializationId,
        startWorkingFrom,
        rating,
        numberOfRates,
        dayOfWeek,
        startPeriodID,
        endPeriodID,
      ];

  ControlStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    List<String>? dayOfWeek,
    List<int>? startPeriodID,
    List<int>? endPeriodID,
  });
}

final class ControlStaffInitial extends ControlStaffState {
  ControlStaffInitial.empty()
      : super(
          fullName: '',
          email: '',
          password: '',
          birthday: DateTime(1970),
          role: '',
          phone: '',
          specializationId: '',
          startWorkingFrom: 1,
          rating: 0.0,
          numberOfRates: 0,
          dayOfWeek: ['Monday'],
          startPeriodID: [1],
          endPeriodID: [2],
        );

  const ControlStaffInitial.input(
      {required super.fullName,
      required super.email,
      required super.password,
      required super.birthday,
      required super.role,
      required super.phone,
      required super.startWorkingFrom,
      required super.specializationId,
      required super.rating,
      required super.numberOfRates,
      required super.dayOfWeek,
      required super.startPeriodID,
      required super.endPeriodID});

  @override
  ControlStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    List<String>? dayOfWeek,
    List<int>? startPeriodID,
    List<int>? endPeriodID,
  }) =>
      ControlStaffInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        startPeriodID: startPeriodID ?? super.startPeriodID,
        endPeriodID: endPeriodID ?? super.endPeriodID,
      );
}

final class ControlStaffLoading extends ControlStaffState {
  const ControlStaffLoading({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required super.startPeriodID,
    required super.endPeriodID,
  });

  factory ControlStaffLoading.from(ControlStaffState state) =>
      ControlStaffLoading(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
        startPeriodID: state.endPeriodID,
        endPeriodID: state.endPeriodID,
      );

  ControlStaffState toggleBackToInitial() => ControlStaffInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        role: role,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
        rating: rating,
        numberOfRates: numberOfRates,
        dayOfWeek: dayOfWeek,
        startPeriodID: endPeriodID,
        endPeriodID: endPeriodID,
      );

  @override
  ControlStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    List<String>? dayOfWeek,
    List<int>? startPeriodID,
    List<int>? endPeriodID,
  }) =>
      ControlStaffLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        startPeriodID: startPeriodID ?? super.startPeriodID,
        endPeriodID: endPeriodID ?? super.endPeriodID,
      );
}

final class ControlStaffSuccess extends ControlStaffState {
  const ControlStaffSuccess({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required super.startPeriodID,
    required super.endPeriodID,
  });

  factory ControlStaffSuccess.from(ControlStaffState state) =>
      ControlStaffSuccess(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
        startPeriodID: state.endPeriodID,
        endPeriodID: state.endPeriodID,
      );

  @override
  ControlStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    List<String>? dayOfWeek,
    List<int>? startPeriodID,
    List<int>? endPeriodID,
  }) =>
      ControlStaffSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        startPeriodID: startPeriodID ?? super.startPeriodID,
        endPeriodID: endPeriodID ?? super.endPeriodID,
      );
}

final class ControlStaffFailure extends ControlStaffState {
  const ControlStaffFailure({
    required super.fullName,
    required super.email,
    required super.password,
    required super.birthday,
    required super.role,
    required super.phone,
    required super.startWorkingFrom,
    required super.specializationId,
    required super.rating,
    required super.numberOfRates,
    required super.dayOfWeek,
    required super.startPeriodID,
    required super.endPeriodID,
    required this.message,
  });

  factory ControlStaffFailure.from(ControlStaffState state, String message) =>
      ControlStaffFailure(
        fullName: state.fullName,
        email: state.email,
        password: state.password,
        birthday: state.birthday,
        role: state.role,
        phone: state.phone,
        specializationId: state.specializationId,
        startWorkingFrom: state.startWorkingFrom,
        rating: state.rating,
        numberOfRates: state.numberOfRates,
        dayOfWeek: state.dayOfWeek,
        startPeriodID: state.endPeriodID,
        endPeriodID: state.endPeriodID,
        message: message,
      );

  ControlStaffState toggleBackToInitial() => ControlStaffInitial.input(
        fullName: fullName,
        email: email,
        password: password,
        birthday: birthday,
        role: role,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
        rating: rating,
        numberOfRates: numberOfRates,
        dayOfWeek: dayOfWeek,
        startPeriodID: endPeriodID,
        endPeriodID: endPeriodID,
      );

  final String message;

  @override
  ControlStaffState copyWith({
    String? fullName,
    String? email,
    String? password,
    DateTime? birthday,
    String? role,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
    double? rating,
    int? numberOfRates,
    List<String>? dayOfWeek,
    List<int>? startPeriodID,
    List<int>? endPeriodID,
  }) =>
      ControlStaffFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        password: password ?? super.password,
        birthday: birthday ?? super.birthday,
        role: role ?? super.role,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
        rating: rating ?? super.rating,
        numberOfRates: numberOfRates ?? super.numberOfRates,
        dayOfWeek: dayOfWeek ?? super.dayOfWeek,
        startPeriodID: startPeriodID ?? super.startPeriodID,
        endPeriodID: endPeriodID ?? super.endPeriodID,
        message: message,
      );
}
