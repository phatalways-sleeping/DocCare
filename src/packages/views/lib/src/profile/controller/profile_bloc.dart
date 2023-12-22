// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:utility/utility.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this._navigatorKey,
    this._notificationManagerService, {
    required String role,
    required this.authenticationRepositoryService,
    this.customerRepositoryService,
    this.doctorRepositoryService,
    this.receptionistRepositoryService,
  })  : assert(
          (role == 'customer') || role == 'doctor' || role == 'receptionist',
          'Role must be customer, doctor or receptionist',
        ),
        super(ProfileInitial(role: role, birthday: DateTime.now())) {
    on<ProfileLoadEvent>((event, emit) async {
      await emit.forEach(
        Stream.fromFuture(
          state.role == 'customer'
              ? customerRepositoryService!.getProfileData()
              : state.role == 'doctor'
                  ? doctorRepositoryService!.getProfileData()
                  : receptionistRepositoryService!.getProfileData(),
        ),
        onData: (data) {
          return ProfileLoadedSuccess(
            role: state.role,
            fullName: data['fullName']! as String,
            email: data['email']! as String,
            phone: data['phone']! as String,
            birthday: data['birthday']! as DateTime,
            specialization: (data['specialization'] as String?) ?? '',
            startWorkingFrom: (data['startWorkingFrom'] as int?) ?? 0,
          );
        },
      );
    });

    on<ProfileFullNameChanged>(_onProfileFullNameChanged);
    on<ProfilePhoneChanged>(_onProfilePhoneChanged);
    on<ProfileBirthdayChanged>(_onProfileBirthdayChanged);
    on<ProfileSpecializationChanged>(_onProfileSpecializationChanged);
    on<ProfileStartWorkingFromChanged>(_onProfileStartWorkingFromChanged);
    on<ProfilePasswordChangedClickEvent>(_onProfilePasswordChangedClickEvent);
    on<ProfilePasswordChanged>(_onProfilePasswordChangedEvent);
    on<ProfileAskForConfirmation>((event, emit) {
      emit(ProfileWaitingForConfirmState.fromState(state));
    });
    on<ProfileResetEvent>((event, emit) {
      emit(ProfileLoadedSuccess.fromState(state));
    });
    on<ProfileSubmitted>(_onProfileSaveEvent);
  }

  final CustomerRepositoryService? customerRepositoryService;
  final DoctorRepositoryService? doctorRepositoryService;
  final ReceptionistRepositoryService? receptionistRepositoryService;
  final AuthenticationRepositoryService authenticationRepositoryService;

  final GlobalKey<NavigatorState> _navigatorKey;
  final NotificationManagerService _notificationManagerService;

  @override
  void onTransition(Transition<ProfileEvent, ProfileState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }

  void _onProfileFullNameChanged(
    ProfileFullNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        fullName: event.fullName,
        hasChanged: true,
      ),
    );
  }

  void _onProfilePhoneChanged(
    ProfilePhoneChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        phone: event.phone,
        hasChanged: true,
      ),
    );
  }

  void _onProfileBirthdayChanged(
    ProfileBirthdayChanged event,
    Emitter<ProfileState> emit,
  ) {
    final oldBirthday = state.birthday;
    try {
      emit(
        state.copyWith(
          birthday: DateTime.parse(event.birthday),
          hasChanged: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          birthday: oldBirthday,
        ),
      );
    }
  }

  void _onProfileSpecializationChanged(
    ProfileSpecializationChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        specialization: event.specialization,
        hasChanged: true,
      ),
    );
  }

  void _onProfileStartWorkingFromChanged(
    ProfileStartWorkingFromChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        startWorkingFrom: event.startWorkingFrom,
        hasChanged: true,
      ),
    );
  }

  void _onProfilePasswordChangedClickEvent(
    ProfilePasswordChangedClickEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileChangePasswordState) {
      emit(ProfileLoadedSuccess.fromState(state));
    }
    emit(
      ProfileChangePasswordState.fromState(state),
    );
  }

  Future<void> _onProfilePasswordChangedEvent(
    ProfilePasswordChanged event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      if (event.password != event.confirmPassword) {
        await _notificationManagerService.show<void>(
          _navigatorKey.currentContext!,
          NotificationType.error,
          message: const Text(
            'Password and confirm password must be the same',
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          title: const Text(
            'Opps! Something went wrong',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        );
        return emit(ProfileLoadedSuccess.fromState(state));
      }
      emit(ProfileLoadingState.fromState(state));
      await authenticationRepositoryService
          .changePassword(
        event.password,
      )
          .then((value) async {
        unawaited(
          _notificationManagerService.show<void>(
            _navigatorKey.currentContext!,
            NotificationType.login,
            message: const Text(
              'Password changed successfully',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            title: const Text(
              'Success',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        );
      });
      emit(ProfileLoadedSuccess.fromState(state));
    } catch (error) {
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
        NotificationType.error,
        message: const Text(
          'An error occurred while updating password',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        title: const Text(
          'Opps! Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      emit(ProfileLoadedSuccess.fromState(state));
    }
  }

  Future<void> _onProfileSaveEvent(
    ProfileSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoadingState.fromState(state));
      if (state.role == 'customer') {
        await customerRepositoryService!.updateProfileData(
          fullname: state.fullName,
          email: state.email,
          phone: state.phone,
          birthday: state.birthday,
        );
      } else if (state.role == 'doctor') {
        await doctorRepositoryService!.updateProfileData(
          fullname: state.fullName,
          email: state.email,
          phone: state.phone,
          birthday: state.birthday,
          specialization: state.specialization,
          startWorkingFrom: state.startWorkingFrom,
        );
      } else if (state.role == 'receptionist') {
        await receptionistRepositoryService!.updateProfileData(
          fullname: state.fullName,
          email: state.email,
          phone: state.phone,
          birthday: state.birthday,
        );
      }
      emit(ProfileUpdatedSuccess.fromState(state));
    } catch (error) {
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
        NotificationType.error,
        message: const Text(
          'An error occurred while updating profile',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        title: const Text(
          'Opps! Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
      emit(ProfileLoadedSuccess.fromState(state));
    }
  }
}
