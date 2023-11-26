part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState({
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

  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  });
}

final class ProfileInitial extends ProfileState {
  ProfileInitial.empty()
      : super(
          fullName: '',
          email: '',
          tempBirthday: '',
          birthday: DateTime.now(),
          phone: '',
          specializationId: '',
          startWorkingFrom: 0,
        );

  const ProfileInitial.input({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  @override
  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ProfileInitial.input(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class ProfileOnChange extends ProfileState {
  const ProfileOnChange({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory ProfileOnChange.from(ProfileState profileState) => ProfileOnChange(
        fullName: profileState.fullName,
        email: profileState.email,
        tempBirthday: profileState.tempBirthday,
        birthday: profileState.birthday,
        phone: profileState.phone,
        specializationId: profileState.specializationId,
        startWorkingFrom: profileState.startWorkingFrom,
      );

  @override
  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ProfileOnChange(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );

  ProfileState toggleBackToInitial() => ProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
      );
}

final class ProfileChangeSuccess extends ProfileState {
  const ProfileChangeSuccess({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory ProfileChangeSuccess.from(ProfileState profileState) =>
      ProfileChangeSuccess(
        fullName: profileState.fullName,
        email: profileState.email,
        tempBirthday: profileState.tempBirthday,
        birthday: profileState.birthday,
        phone: profileState.phone,
        specializationId: profileState.specializationId,
        startWorkingFrom: profileState.startWorkingFrom,
      );

  @override
  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ProfileChangeSuccess(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        birthday: birthday ?? super.birthday,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class ProfileChangeFailure extends ProfileState {
  const ProfileChangeFailure({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory ProfileChangeFailure.from(ProfileState profileState) =>
      ProfileChangeFailure(
        fullName: profileState.fullName,
        email: profileState.email,
        tempBirthday: profileState.tempBirthday,
        birthday: profileState.birthday,
        phone: profileState.phone,
        specializationId: profileState.specializationId,
        startWorkingFrom: profileState.startWorkingFrom,
      );

  @override
  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ProfileChangeFailure(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading({
    required super.fullName,
    required super.email,
    required super.tempBirthday,
    required super.birthday,
    required super.phone,
    required super.specializationId,
    required super.startWorkingFrom,
  });

  factory ProfileLoading.from(ProfileState profileState) => ProfileLoading(
        fullName: profileState.fullName,
        email: profileState.email,
        tempBirthday: profileState.tempBirthday,
        birthday: profileState.birthday,
        phone: profileState.phone,
        specializationId: profileState.specializationId,
        startWorkingFrom: profileState.startWorkingFrom,
      );

  ProfileState toggleBackToInitial() => ProfileInitial.input(
        fullName: fullName,
        email: email,
        tempBirthday: tempBirthday,
        birthday: birthday,
        phone: phone,
        specializationId: specializationId,
        startWorkingFrom: startWorkingFrom,
      );

  @override
  ProfileState copyWith({
    String? fullName,
    String? email,
    String? tempBirthday,
    DateTime? birthday,
    String? phone,
    String? specializationId,
    int? startWorkingFrom,
  }) =>
      ProfileLoading(
        fullName: fullName ?? super.fullName,
        email: email ?? super.email,
        tempBirthday: tempBirthday ?? super.tempBirthday,
        birthday: birthday ?? super.birthday,
        phone: phone ?? super.phone,
        specializationId: specializationId ?? super.specializationId,
        startWorkingFrom: startWorkingFrom ?? super.startWorkingFrom,
      );
}
