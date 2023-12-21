// ignore_for_file: public_member_api_docs

part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState({
    required this.role,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.specialization,
    required this.startWorkingFrom,
  });

  final String role;

  final String fullName;
  final String email;
  final String phone;
  final DateTime birthday;

  final String specialization;
  final int startWorkingFrom;

  @override
  List<Object?> get props => [
        role,
        fullName,
        email,
        phone,
        birthday,
        specialization,
        startWorkingFrom,
      ];

  ProfileState copyWith({
    String? role,
    String? fullName,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  });
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial({
    required super.birthday,
    required super.role,
  }) : super(
          fullName: '',
          email: '',
          phone: '',
          specialization: '',
          startWorkingFrom: 0,
        );
  @override
  ProfileState copyWith({
    String? role,
    String? fullName,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  }) {
    return ProfileInitial(
      role: role ?? this.role,
      birthday: birthday ?? this.birthday,
    );
  }
}

final class ProfileLoadedSuccess extends ProfileState {
  const ProfileLoadedSuccess({
    required super.role,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.birthday,
    required super.specialization,
    required super.startWorkingFrom,
  });

  factory ProfileLoadedSuccess.fromState(ProfileState state) {
    return ProfileLoadedSuccess(
      role: state.role,
      fullName: state.fullName,
      email: state.email,
      phone: state.phone,
      birthday: state.birthday,
      specialization: state.specialization,
      startWorkingFrom: state.startWorkingFrom,
    );
  }

  @override
  ProfileState copyWith({
    String? role,
    String? fullName,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  }) {
    return ProfileLoadedSuccess(
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      specialization: specialization ?? this.specialization,
      startWorkingFrom: startWorkingFrom ?? this.startWorkingFrom,
    );
  }
}

final class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState({
    required super.role,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.birthday,
    required super.specialization,
    required super.startWorkingFrom,
  });

  factory ProfileLoadingState.fromState(ProfileState state) {
    return ProfileLoadingState(
      role: state.role,
      fullName: state.fullName,
      email: state.email,
      phone: state.phone,
      birthday: state.birthday,
      specialization: state.specialization,
      startWorkingFrom: state.startWorkingFrom,
    );
  }

  @override
  ProfileState copyWith({
    String? role,
    String? fullName,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  }) {
    return ProfileLoadingState(
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      specialization: specialization ?? this.specialization,
      startWorkingFrom: startWorkingFrom ?? this.startWorkingFrom,
    );
  }
}

final class ProfileUpdatedSuccess extends ProfileState {
  const ProfileUpdatedSuccess({
    required super.role,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.birthday,
    required super.specialization,
    required super.startWorkingFrom,
  });

  factory ProfileUpdatedSuccess.fromState(ProfileState state) {
    return ProfileUpdatedSuccess(
      role: state.role,
      fullName: state.fullName,
      email: state.email,
      phone: state.phone,
      birthday: state.birthday,
      specialization: state.specialization,
      startWorkingFrom: state.startWorkingFrom,
    );
  }

  @override
  ProfileState copyWith({
    String? role,
    String? fullName,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  }) {
    return ProfileUpdatedSuccess(
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      specialization: specialization ?? this.specialization,
      startWorkingFrom: startWorkingFrom ?? this.startWorkingFrom,
    );
  }
}

final class ProfileFailureState extends ProfileState {
  const ProfileFailureState({
    required super.role,
    required super.fullName,
    required super.email,
    required super.phone,
    required super.birthday,
    required super.specialization,
    required super.startWorkingFrom,
  });

  factory ProfileFailureState.fromState(ProfileState state) {
    return ProfileFailureState(
      role: state.role,
      fullName: state.fullName,
      email: state.email,
      phone: state.phone,
      birthday: state.birthday,
      specialization: state.specialization,
      startWorkingFrom: state.startWorkingFrom,
    );
  }

  @override
  ProfileState copyWith({
    String? role,
    String? fullName,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  }) {
    return ProfileFailureState(
      role: role ?? this.role,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      specialization: specialization ?? this.specialization,
      startWorkingFrom: startWorkingFrom ?? this.startWorkingFrom,
    );
  }
}
