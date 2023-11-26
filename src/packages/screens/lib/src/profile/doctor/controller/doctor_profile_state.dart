part of 'doctor_profile_bloc.dart';

@immutable
sealed class DoctorProfileState extends Equatable {
  const DoctorProfileState({
    required this.fullName,
    required this.email,
    required this.tempBirthday,
    required this.birthday,
    required this.phone,
    required this.specializationId,
    required this.startWorkingFrom,
  });

  final String fullName;
  final String email;
  final String tempBirthday;
  final DateTime birthday;
  final String phone;
  final String specializationId;
  final int startWorkingFrom;

  @override
  List<Object?> get props => [
        fullName,
        email,
        tempBirthday,
        birthday,
        phone,
        specializationId,
        startWorkingFrom,
      ];

  DoctorProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  });
}

final class DoctorProfileInitial extends DoctorProfileState {
  DoctorProfileInitial.empty()
      : super(
          fullName: '',
          email: '',
          tempBirthday: '',
          birthday: DateTime.now(),
          phone: '',
          specializationId: '',
          startWorkingFrom: 0,
        );

  const DoctorProfileInitial.input({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  @override
  DoctorProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class DoctorProfileOnChange extends DoctorProfileState {
  const DoctorProfileOnChange({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory DoctorProfileOnChange.from(DoctorProfileState DoctorProfileState) =>
      DoctorProfileOnChange(
        fullName: DoctorProfileState.fullName,
        email: DoctorProfileState.email,
        tempBirthday: DoctorProfileState.tempBirthday,
        birthday: DoctorProfileState.birthday,
        phone: DoctorProfileState.phone,
        specializationId: DoctorProfileState.specializationId,
        startWorkingFrom: DoctorProfileState.startWorkingFrom,
      );

  @override
  DoctorProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileOnChange(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );

  DoctorProfileState toggleBackToInitial() => DoctorProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
      );
}

final class DoctorProfileChangeSuccess extends DoctorProfileState {
  const DoctorProfileChangeSuccess({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory DoctorProfileChangeSuccess.from(
          DoctorProfileState DoctorProfileState) =>
      DoctorProfileChangeSuccess(
        fullName: DoctorProfileState.fullName,
        email: DoctorProfileState.email,
        tempBirthday: DoctorProfileState.tempBirthday,
        birthday: DoctorProfileState.birthday,
        phone: DoctorProfileState.phone,
        specializationId: DoctorProfileState.specializationId,
        startWorkingFrom: DoctorProfileState.startWorkingFrom,
      );

  @override
  DoctorProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileChangeSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class DoctorProfileChangeFailure extends DoctorProfileState {
  const DoctorProfileChangeFailure({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory DoctorProfileChangeFailure.from(
          DoctorProfileState DoctorProfileState) =>
      DoctorProfileChangeFailure(
        fullName: DoctorProfileState.fullName,
        email: DoctorProfileState.email,
        tempBirthday: DoctorProfileState.tempBirthday,
        birthday: DoctorProfileState.birthday,
        phone: DoctorProfileState.phone,
        specializationId: DoctorProfileState.specializationId,
        startWorkingFrom: DoctorProfileState.startWorkingFrom,
      );

  @override
  DoctorProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileChangeFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class DoctorProfileLoading extends DoctorProfileState {
  const DoctorProfileLoading({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory DoctorProfileLoading.from(DoctorProfileState DoctorProfileState) =>
      DoctorProfileLoading(
        fullName: DoctorProfileState.fullName,
        email: DoctorProfileState.email,
        tempBirthday: DoctorProfileState.tempBirthday,
        birthday: DoctorProfileState.birthday,
        phone: DoctorProfileState.phone,
        specializationId: DoctorProfileState.specializationId,
        startWorkingFrom: DoctorProfileState.startWorkingFrom,
      );

  DoctorProfileState toggleBackToInitial() => DoctorProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
      );

  @override
  DoctorProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      DoctorProfileLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}
