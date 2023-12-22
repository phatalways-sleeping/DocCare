// ignore_for_file: public_member_api_docs

part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileLoadEvent extends ProfileEvent {
  const ProfileLoadEvent();
}

final class ProfileFullNameChanged extends ProfileEvent {
  const ProfileFullNameChanged(this.fullName);

  final String fullName;

  @override
  List<Object?> get props => [fullName];
}

final class ProfileEmailChanged extends ProfileEvent {
  const ProfileEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class ProfilePhoneChanged extends ProfileEvent {
  const ProfilePhoneChanged(this.phone);

  final String phone;

  @override
  List<Object?> get props => [phone];
}

final class ProfileBirthdayChanged extends ProfileEvent {
  const ProfileBirthdayChanged(this.birthday);

  final String birthday;

  @override
  List<Object?> get props => [birthday];
}

final class ProfileSpecializationChanged extends ProfileEvent {
  const ProfileSpecializationChanged(this.specialization);

  final String specialization;

  @override
  List<Object?> get props => [specialization];
}

final class ProfileStartWorkingFromChanged extends ProfileEvent {
  const ProfileStartWorkingFromChanged(this.startWorkingFrom);

  final int startWorkingFrom;

  @override
  List<Object?> get props => [startWorkingFrom];
}

final class ProfilePasswordChangedClickEvent extends ProfileEvent {
  const ProfilePasswordChangedClickEvent();

  @override
  List<Object?> get props => [];
}

final class ProfilePasswordChanged extends ProfileEvent {
  const ProfilePasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

final class ProfileSubmitted extends ProfileEvent {
  const ProfileSubmitted();
}
