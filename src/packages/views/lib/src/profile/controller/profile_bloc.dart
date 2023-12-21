// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required String role,
  }) : super(ProfileInitial(role: role, birthday: DateTime.now())) {
    on<ProfileLoadEvent>((event, emit) async {
      await emit.forEach(
        Stream.fromFuture(
          Future.delayed(
            const Duration(seconds: 1),
            () => {
              'fullName': 'Nguyen Van A',
              'email': 'nvanh@gmail.com',
              'phone': '0123456789',
              'birthday': DateTime.now(),
              'specialization': 'Cardiology',
              'startWorkingFrom': 2015,
            },
          ),
        ),
        onData: (data) {
          return ProfileLoadedSuccess(
            role: state.role,
            fullName: data['fullName']! as String,
            email: data['email']! as String,
            phone: data['phone']! as String,
            birthday: data['birthday']! as DateTime,
            specialization: data['specialization']! as String,
            startWorkingFrom: data['startWorkingFrom']! as int,
          );
        },
      );
    });

    on<ProfileFullNameChanged>(_onProfileFullNameChanged);
    on<ProfileEmailChanged>(_onProfileEmailChanged);
    on<ProfilePhoneChanged>(_onProfilePhoneChanged);
    on<ProfileBirthdayChanged>(_onProfileBirthdayChanged);
    on<ProfileSpecializationChanged>(_onProfileSpecializationChanged);
    on<ProfileStartWorkingFromChanged>(_onProfileStartWorkingFromChanged);
    on<ProfilePasswordChangedClickEvent>(_onProfilePasswordChangedClickEvent);
    on<ProfileSubmitted>(_onProfileSaveEvent);
  }

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
      ),
    );
  }

  void _onProfileEmailChanged(
    ProfileEmailChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
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
      ),
    );
  }

  void _onProfilePasswordChangedClickEvent(
    ProfilePasswordChangedClickEvent event,
    Emitter<ProfileState> emit,
  ) {}

  void _onProfileSaveEvent(
    ProfileSubmitted event,
    Emitter<ProfileState> emit,
  ) {}
}
