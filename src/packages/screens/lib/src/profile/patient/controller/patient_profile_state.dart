part of 'patient_profile_bloc.dart';

@immutable
sealed class PatientProfileState extends Equatable {
  const PatientProfileState({
    required this.fullName,
    required this.email,
    required this.tempBirthday,
    required this.birthday,
    required this.phone,
  });

  final String fullName;
  final String email;
  final String tempBirthday;
  final DateTime birthday;
  final String phone;

  @override
  List<Object?> get props => [
        fullName,
        email,
        tempBirthday,
        birthday,
        phone,
      ];

  PatientProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  });
}

final class PatientProfileInitial extends PatientProfileState {
  PatientProfileInitial.empty()
      : super(
          fullName: '',
          email: '',
          tempBirthday: '',
          birthday: DateTime.now(),
          phone: '',
        );

  const PatientProfileInitial.input({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  @override
  PatientProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      PatientProfileInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}

final class PatientProfileOnChange extends PatientProfileState {
  const PatientProfileOnChange({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory PatientProfileOnChange.from(
          PatientProfileState PatientProfileState) =>
      PatientProfileOnChange(
        fullName: PatientProfileState.fullName,
        email: PatientProfileState.email,
        tempBirthday: PatientProfileState.tempBirthday,
        birthday: PatientProfileState.birthday,
        phone: PatientProfileState.phone,
      );

  @override
  PatientProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      PatientProfileOnChange(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );

  PatientProfileState toggleBackToInitial() => PatientProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
      );
}

final class PatientProfileChangeSuccess extends PatientProfileState {
  const PatientProfileChangeSuccess({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory PatientProfileChangeSuccess.from(
          PatientProfileState PatientProfileState) =>
      PatientProfileChangeSuccess(
        fullName: PatientProfileState.fullName,
        email: PatientProfileState.email,
        tempBirthday: PatientProfileState.tempBirthday,
        birthday: PatientProfileState.birthday,
        phone: PatientProfileState.phone,
      );

  @override
  PatientProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      PatientProfileChangeSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        phone: phone ?? super.phone,
      );
}

final class PatientProfileChangeFailure extends PatientProfileState {
  const PatientProfileChangeFailure({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory PatientProfileChangeFailure.from(
          PatientProfileState PatientProfileState) =>
      PatientProfileChangeFailure(
        fullName: PatientProfileState.fullName,
        email: PatientProfileState.email,
        tempBirthday: PatientProfileState.tempBirthday,
        birthday: PatientProfileState.birthday,
        phone: PatientProfileState.phone,
      );

  @override
  PatientProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      PatientProfileChangeFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}

final class PatientProfileLoading extends PatientProfileState {
  const PatientProfileLoading({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
  });

  factory PatientProfileLoading.from(PatientProfileState PatientProfileState) =>
      PatientProfileLoading(
        fullName: PatientProfileState.fullName,
        email: PatientProfileState.email,
        tempBirthday: PatientProfileState.tempBirthday,
        birthday: PatientProfileState.birthday,
        phone: PatientProfileState.phone,
      );

  PatientProfileState toggleBackToInitial() => PatientProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
      );

  @override
  PatientProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      PatientProfileLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
      );
}
